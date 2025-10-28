using System;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.Services;
using System.Text.RegularExpressions;

using MySqlConnector;
using Newtonsoft.Json;

using System.IO;
// per il cookie di autenticazione
using System.Web.Security;

[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// Per consentire la chiamata di questo servizio Web dallo script utilizzando ASP.NET AJAX, rimuovere il commento dalla riga seguente. 
[System.Web.Script.Services.ScriptService]
public class WebServiceComputi : System.Web.Services.WebService {

    public WebServiceComputi () {

        //Rimuovere il commento dalla riga seguente se si utilizzano componenti progettati 
        //InitializeComponent(); 
    }

    // metodo di esempio:
    // [WebMethod] public void metodoDiEsempio(int valore) { }

    protected bool sonoInLocale()
    {
        String fullpathname = HttpContext.Current.Request.Url.Authority.ToLower();
        return fullpathname.Contains("localhost");
    }

    [WebMethod]
    public void eliminaVoce(int idvoce)
    {
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            connection.Open();

            MySqlCommand command;
            MySqlDataReader reader;

            // ciclo sulle misure di questa voce. Per ogni misura devo cancellare (se c'è) anche la sua immagine nel percorso percorsoUploadImmaginiGestionale
            command = connection.CreateCommand();
            command.CommandText = "SELECT id FROM misura WHERE idvoce = @idvoce";
            command.Parameters.AddWithValue("@idvoce", idvoce);

            reader = command.ExecuteReader();
            while (reader.Read())
            {
                int idmisura = (int)reader["id"];
                eliminaMisura(idmisura);
            }
            reader.Close();

            command = connection.CreateCommand();
            command.CommandText = "DELETE FROM voce WHERE id = @id";
            command.Parameters.AddWithValue("@id", idvoce);
            command.ExecuteNonQuery();

            connection.Close();
        }
    }

    // NOTA: Questa eliminazione non rimappa le misure, serve solo per eliminaVoce.
    private void eliminaMisura(int idmisura)
    {
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString"))) {
            connection.Open();

            MySqlCommand command; object objTemp;

            // ottengo il nome dell'immagine da cancellare
            command = connection.CreateCommand();
            command.CommandText = "SELECT pathimmagine FROM misura WHERE id = @id";
            command.Parameters.AddWithValue("@id", idmisura);

            objTemp = command.ExecuteScalar();
            String nomefile = objTemp == null ? "" : objTemp.ToString();

            // ottengo il percorso del file dell'immagine (nota: non è mai stato utilizzato -> percorsoUploadImmaginiGestionale)
            String percorsofile = Server.MapPath("~/" + System.Configuration.ConfigurationManager.AppSettings["percorsoUploadGestionaleScansioni"].ToString());

            // elimino il file
            if (nomefile != "")
                File.Delete(percorsofile + nomefile);

            command = connection.CreateCommand();
            command.CommandText = "DELETE FROM misura WHERE id = @id";
            command.Parameters.AddWithValue("@id", idmisura);
            command.ExecuteNonQuery();

            connection.Close();
        }
    }


    // Oggi inserisco una bolla e creo 2 record su costi. Domani Arriva la fattura e creo altri 2 costi associati alla fattura.
    // Quando cancello la bolla devo cancellare anche le righe bolla, però restano le righe controllate della fattura senza righe bolla associate. devo cancellare anche quelle? se cancello anche quelle e la fattura rimane senza righe e dovrei cancellare anche la fattura.
    [WebMethod]
    public string eliminaFattura(int idFattura)
    {
        return eliminaBolla(idFattura);
    }
    [WebMethod]
    public string eliminaFatture(object[] arrayFatture)
    {
        String jsonString = "";
        for (int i = 0; i < arrayFatture.Length; i++) {
            jsonString = eliminaFattura(Convert.ToInt32(arrayFatture[i]));
        }
        return jsonString;
    }
    [WebMethod]
    public string eliminaBolla(int idBolla)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command; object objTemp;

                // cancello la scansione. il path del file è: percorsoUploadGestionaleScansioni + bollafattura.pathfilescansione
                command = connection.CreateCommand();
                command.CommandText = "SELECT pathfilescansione FROM bollafattura WHERE id = @idBolla";
                command.Parameters.AddWithValue("@idBolla", idBolla);

                // ottengo il nomefile della scansione
                objTemp = command.ExecuteScalar();
                String nomefile = objTemp == null ? "" : objTemp.ToString();

                // ottengo il percorso del file della scansione
                String percorsofile = Server.MapPath("~/" + System.Configuration.ConfigurationManager.AppSettings["percorsoUploadGestionaleScansioni"].ToString());

                // elimino il file
                String file = percorsofile + nomefile;
                if (nomefile != "")
                    File.Delete(file);

                // cancello le righe (so per certo che quando mi trovo qui, non ci sono costi per questa bolla con dati associati ad una o più fatture)
                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM costo WHERE idbollafattura = @idbollafattura";
                command.Parameters.AddWithValue("@idbollafattura", idBolla);
                command.ExecuteNonQuery();

                // cancello la bolla
                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM bollafattura WHERE id = @idbollafattura";
                command.Parameters.AddWithValue("@idbollafattura", idBolla);
                command.ExecuteNonQuery();

                connection.Close();
            }

        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public string eliminaComputo(int idcomputo)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command;
                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM misura "
                                    + "WHERE idvoce in (select id from voce where idcomputo = @idcomputo)";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM voce "
                                    + "WHERE idcomputo = @idcomputo";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM suddivisione "
                                    + "WHERE idcomputo = @idcomputo";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM computopdf "
                                    + "WHERE idcomputo = @idcomputo";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM computo "
                                    + "WHERE id = @idcomputo";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                connection.Close();
            }
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public string duplicaComputo(int idcomputo, double? ricaricopercentuale)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                //MySqlDataReader reader;
                MySqlCommand command;

                // 1. Clona la testata computo
                command = connection.CreateCommand();
                command.CommandText = @"
                    INSERT INTO computo (codice, titolo, descrizione, idcliente, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina, idcomputooriginaleclonato, ricaricopercentuale) 
                    SELECT codice, concat(titolo, ' (clonato)') as titolo, descrizione, idcliente, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina, id, @ricaricopercentuale
                    FROM computo 
                    WHERE id = @idcomputo";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.Parameters.AddWithValue("@ricaricopercentuale", ricaricopercentuale);
                command.ExecuteNonQuery();

                 command = connection.CreateCommand();
                command.CommandText = "SELECT LAST_INSERT_ID();";
                Object IDComputoClonatoo =  command.ExecuteScalar();
                int IDComputoClonato = int.Parse(IDComputoClonatoo.ToString());

                // 2. Clona le suddivisioni A. duplica tutti i record, poi  B. aggiusta con una query gli idpadre
                command = connection.CreateCommand();
                command.CommandText = @"
                    INSERT INTO suddivisione (idcomputo, descrizione, posizione, idsuddivisioneoriginaleclonato) 
                    SELECT  @IDClonato, descrizione, posizione, id 
                    FROM suddivisione 
                    WHERE idcomputo = @idcomputo";
                command.Parameters.AddWithValue("@IDClonato", IDComputoClonato);
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();


                /*questa è la select che elabora gli stessi record della update
                select suddivisioneclonata.*, suddivisioneoriginale.idpadre as idpadrenelloriginale, suddivisioneclonata2.id as idpadreinclonata
                from suddivisione as suddivisioneclonata
                inner join suddivisione as suddivisioneoriginale on suddivisioneclonata.idsuddivisioneoriginaleclonato = suddivisioneoriginale.id and suddivisioneclonata.idcomputo = 42 and suddivisioneoriginale.idcomputo = 27 
                inner join suddivisione suddivisioneclonata2 on suddivisioneoriginale.idpadre = suddivisioneclonata2.idsuddivisioneoriginaleclonato and suddivisioneclonata2.idcomputo = 42 
                */

                /*questa è la update
                update suddivisione as suddivisioneclonata
                inner join suddivisione as suddivisioneoriginale on suddivisioneclonata.idsuddivisioneoriginaleclonato = suddivisioneoriginale.id and suddivisioneclonata.idcomputo = @IDComputoClonato and suddivisioneoriginale.id = @idcomputo
                inner join suddivisione suddivisioneclonata2 on suddivisioneoriginale.idpadre = suddivisioneclonata2.idsuddivisioneoriginaleclonato and suddivisioneclonata2.idcomputo = @IDComputoClonato 
                set suddivisioneclonata.idpadre = suddivisioneclonata2.id
                */

                // aggiusta le suddivisioni: valorizza correttamente gli idpadre
                command = connection.CreateCommand();
                command.CommandText = @"
                    update suddivisione as suddivisioneclonata 
                        inner join suddivisione as suddivisioneoriginale on suddivisioneclonata.idsuddivisioneoriginaleclonato = suddivisioneoriginale.id and suddivisioneclonata.idcomputo = @IDComputoClonato1 and suddivisioneoriginale.idcomputo = @idcomputo1
                        inner join suddivisione suddivisioneclonata2 on suddivisioneoriginale.idpadre = suddivisioneclonata2.idsuddivisioneoriginaleclonato and suddivisioneclonata2.idcomputo = @IDComputoClonato2 
                    set suddivisioneclonata.idpadre = suddivisioneclonata2.id";
                command.Parameters.AddWithValue("@IDComputoClonato1", IDComputoClonato);
                command.Parameters.AddWithValue("@idcomputo1", idcomputo);
                command.Parameters.AddWithValue("@IDComputoClonato2", IDComputoClonato);
                command.ExecuteNonQuery();

                // solo per debug questa query
                //command = connection.CreateCommand();
                //command.CommandText = "SELECT mysql_affected_rows();";
                //long quantesuddivisioniaggiornate = (long)command.ExecuteScalar();



                // 3. Clona le voci  A. duplica tutti i record, poi  B. aggiusta con una query gli idsuddivisione
                command = connection.CreateCommand();
                command.CommandText = @"
                    INSERT INTO voce (idcomputo, idvoceorigine, codice, titolo, descrizione, posizione, idvoceoriginaleclonata) 
                    SELECT @idcomputoclonato, idvoceorigine, codice, titolo, descrizione, posizione, id 
                    FROM voce
                    WHERE idcomputo = @idcomputooriginale";
                command.Parameters.AddWithValue("@idcomputoclonato", IDComputoClonato);
                command.Parameters.AddWithValue("@idcomputooriginale", idcomputo);
                command.ExecuteNonQuery();



                command = connection.CreateCommand();
                command.CommandText = @"
                    update voce as voceclonata 
                        inner join voce as voceoriginale on voceclonata.idvoceoriginaleclonata = voceoriginale.id and voceclonata.idcomputo = @IDComputoClonato1 and voceoriginale.idcomputo = @idcomputo1 
                        inner join suddivisione as suddivisioneclonata on suddivisioneclonata.idsuddivisioneoriginaleclonato = voceoriginale.idsuddivisione and suddivisioneclonata.idcomputo = @IDComputoClonato2 
                    set voceclonata.idsuddivisione = suddivisioneclonata.id";
                command.Parameters.AddWithValue("@IDComputoClonato1", IDComputoClonato);
                command.Parameters.AddWithValue("@idcomputo1", idcomputo);
                command.Parameters.AddWithValue("@IDComputoClonato2", IDComputoClonato);
                command.ExecuteNonQuery();

                // solo per debug questa query
                //command = connection.CreateCommand();
                //command.CommandText = "SELECT mysql_affected_rows()";
                //int quantevociaggiornate = (int)command.ExecuteScalar();


                // 3. Clona le misure  A. duplica tutti i record, poi  B. aggiusta con una query gli idvoce

                command = connection.CreateCommand();
                command.CommandText = @"
                    INSERT INTO misura (
                        idvoce,
                        idunitamisura, sottocodice, descrizione, 
                        prezzounitario, 
                        totalemisura,
                        totaleimporto, 
                        posizione, pathimmagine, nomeimmagine, idmisuraoriginaleclonata, idmisuraorigine) 
                    SELECT idvoce, idunitamisura, sottocodice, misura.descrizione as descrizione, 
                        prezzounitario * (100 + @ricaricopercentuale) / 100, 
                        totalemisura, 
                        totaleimporto * (100 + @ricaricopercentuale) / 100, 
                        misura.posizione, pathimmagine, nomeimmagine, misura.id as idmisuraoriginaleclonata, misura.id 
                    FROM misura inner join voce on misura.idvoce = voce.id 
                    WHERE voce.idcomputo = @idcomputo";
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.Parameters.AddWithValue("@ricaricopercentuale", ricaricopercentuale == null ? 0 : (double)ricaricopercentuale);
                command.ExecuteNonQuery();

                //command = connection.CreateCommand();
                //command.CommandText = @"
                //    update misura as misuraclonata 
                //        inner join misura as misuraoriginale on misuraclonata.idmisuraoriginaleclonata = misuraoriginale.id
                //        inner join voce as voceclonata on voceclonata.idvoceoriginaleclonata = misuraoriginale.idvoce and voceclonata.idcomputo = @IDComputoClonato1 
                //    set misuraclonata.idvoce = voceclonata.id";
                //command.Parameters.AddWithValue("@IDComputoClonato1", IDComputoClonato);
                //command.ExecuteNonQuery();
                command = connection.CreateCommand();
                command.CommandText = @"
                    UPDATE computo as computoclonato 
                    INNER JOIN voce as voceclonata on voceclonata.idcomputo =  computoclonato.id
                    INNER JOIN voce as voceoriginale on voceclonata.idvoceoriginaleclonata = voceoriginale.id AND voceoriginale.idcomputo = @idcomputo
                    INNER JOIN misura as misuraoriginale on misuraoriginale.idvoce = voceoriginale.id 

                    /* prendo la misura clonata che è ancora legata alla voce originale */
                    INNER JOIN misura as misuraclonata ON misuraclonata.idmisuraorigine = misuraoriginale.id AND misuraclonata.idvoce = voceoriginale.id
                   
                    SET misuraclonata.idvoce = voceclonata.id
                    where computoclonato.id = @IDComputoClonato";
                command.Parameters.AddWithValue("@IDComputoClonato", IDComputoClonato);
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                // solo per debug questa query
                //command = connection.CreateCommand();
                //command.CommandText = "SELECT mysql_affected_rows()";
                //int quantemisureaggiornate = (int)command.ExecuteScalar();

                connection.Close();
                }
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }



    // al click su duplica chiamo la funzione: duplicaSuddivisione(idSuddivisione, null)
    [WebMethod]
    public string duplicaSuddivisione(int idSuddivisione, object nuovasuddivisionepadre)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                using (MySqlConnection connection2 = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
                {
                    connection2.Open();

                    MySqlDataReader reader;
                    MySqlCommand command, command2;

                    // a DB posso avere un int o DBNull. al primo giro eseguo una query per ottenere il padre di questa suddivisione
                    if (nuovasuddivisionepadre == null)
                    {
                        command = connection.CreateCommand();
                        command.CommandText = "select idpadre from suddivisione where id = @idsuddivisione";
                        command.Parameters.AddWithValue("@idsuddivisione", idSuddivisione);
                        nuovasuddivisionepadre = command.ExecuteScalar();
                    }

                    // 2. Clona la suddivisione
                    command = connection.CreateCommand();
                    command.CommandText = @"insert into suddivisione (idcomputo, idpadre, descrizione, posizione, idsuddivisioneoriginaleclonato) 
                                            select idcomputo, @idnuovopadre, descrizione, posizione+1, id from suddivisione where id = @idsuddivisione";
                    command.Parameters.AddWithValue("@idsuddivisione", idSuddivisione);
                    command.Parameters.AddWithValue("@idnuovopadre", nuovasuddivisionepadre);
                    command.ExecuteNonQuery();

                    int IDNuovaSuddivisione = (int)command.LastInsertedId;

                    // rinormalizza la posizione delle suddivisioni
                    rinormalizzaPosizioneSuddivisioni(idSuddivisione);

                    // 3. Clona le voci
                    command = connection.CreateCommand();
                    command.CommandText = @"insert into voce (idcomputo, idsuddivisione, idvoceorigine, codice, titolo, descrizione, posizione, idvoceoriginaleclonata) 
                                            select  idcomputo, @idnuovasuddivisione, idvoceorigine, codice, titolo, descrizione, posizione, id from voce where idsuddivisione = @idsuddivisione";
                    command.Parameters.AddWithValue("@idnuovasuddivisione", IDNuovaSuddivisione);
                    command.Parameters.AddWithValue("@idsuddivisione", idSuddivisione);
                    command.ExecuteNonQuery();

                    // 3. Itera le voci clonate. Per ogni voce clonata, clona anche le misure
                    command = connection.CreateCommand();
                    command.CommandText = @"select id, idvoceoriginaleclonata from voce where voce.idSuddivisione = @idSuddivisione";
                    command.Parameters.AddWithValue("@idSuddivisione", IDNuovaSuddivisione);
                    reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        int idNuovaVoce = (int)reader["id"];
                        int idVecchiavoce = (int)reader["idvoceoriginaleclonata"];

                        command2 = connection2.CreateCommand();
                        command2.CommandText = @"
                            insert into misura (idvoce,   idunitamisura, sottocodice, descrizione,        prezzounitario, totalemisura, totaleimporto, posizione,        pathimmagine, nomeimmagine, idmisuraoriginaleclonata, idmisuraorigine ) 
                            select          @idnuovavoce, idunitamisura, sottocodice, misura.descrizione, prezzounitario, totalemisura, totaleimporto, misura.posizione, pathimmagine, nomeimmagine, misura.id, idmisuraorigine                 
                            from misura
                            where idvoce = @idvoce";
                        command2.Parameters.AddWithValue("@idnuovavoce", idNuovaVoce);
                        command2.Parameters.AddWithValue("@idvoce", idVecchiavoce);
                        command2.ExecuteNonQuery();
                    }
                    reader.Close();

                    // RICORSIONE SUI FIGLI
                    command = connection.CreateCommand();
                    command.CommandText = "select id from suddivisione where idpadre = @idsuddivisione";
                    command.Parameters.AddWithValue("@idsuddivisione", idSuddivisione);
                    reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        int idSuddivisioneFiglia = (int)reader["id"];
                        duplicaSuddivisione(idSuddivisioneFiglia, IDNuovaSuddivisione);
                    }
                    reader.Close();

                    connection2.Close();
                }
                connection.Close();
            }

        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }
    /*private static int getIDSuddivisioneClonata(int idVoceClonata, int idcomputoOriginale) {

        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");

        connection.Open();

        // Ottendo descrizione e posizione della suddivisione originale
        String descrizione = "";
        int posizione = -1;
        MySqlCommand command;
        command = connection.CreateCommand();
        command.CommandText = "select suddivisione.descrizione as descrizione, suddivisione.posizione as posizione from suddivisione inner join voce on voce.idsuddivisione = idsuddivisione.id where voce.id = @idvoce;";
        command.Parameters.AddWithValue("@idvoce", idVoceClonata);
        MySqlDataReader reader = command.ExecuteReader();
        if (! reader.Read()) {
            connection.Close();
            return -1;
        } else {
            descrizione = (string)reader["descrizione"];
            posizione = (int)reader["posizione"];
        }
        reader.Close();

        // Ottendo id della suddivisione clonata confrondanto descrizione e posizione della suddivisione originale
        int idSuddivisioneClonata = -1;
        command = connection.CreateCommand();
        command.CommandText = "select id from suddivisione  where descrizione = @descrizione, posizione = @posizione and idcomputo = @idcomputo;";
        command.Parameters.AddWithValue("@descrizione", descrizione);
        command.Parameters.AddWithValue("@posizione", posizione);
        command.Parameters.AddWithValue("@idcomputo", idcomputoOriginale);
        idSuddivisioneClonata =  (int) command.ExecuteScalar();
        connection.Close();

        return idSuddivisioneClonata;
    
    }*/

    /*[WebMethod]
    public string modificaCantiereCosto(int idcosto)
    {
        String jsonString = "";

        try {
            MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
            connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");

            connection.Open();

            MySqlCommand command; MySqlDataReader reader;

            // 1) dato idcosto, ottengo 3 dati idcostodamodificare, idcantiere, idcantieredamodificare
            command = connection.CreateCommand();
            command.CommandText = "SELECT costo.id as 'idcosto', costoinfattura.id as 'idcostodamodificare', costo.idcantiere as 'idcantiere', costoinfattura.idcantiere as 'idcantieredamodificare' "
                                + "FROM costo INNER JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id "
                                + "WHERE costo.idcantiere <> costoinfattura.idcantiere AND costo.id = @idcosto";
            command.Parameters.AddWithValue("@idcosto", idcosto);

            reader = command.ExecuteReader();
            while (reader.Read()) {
                int idcostodamodificare = (int)reader["idcostodamodificare"];
                int idcantiere = (int)reader["idcantiere"];
                int idcantieredamodificare = (int)reader["idcantieredamodificare"];

                // aggiorno nella tabella costo, la riga con id == idcostodamodificare. costo.idcantiere assume valore = idcantiere
                command = connection.CreateCommand();
                command.CommandText = "UPDATE costo SET idcantiere = @idcantiere WHERE id = idcostodamodificare ";
                command.Parameters.AddWithValue("@idcantiere", idcantiere);
                command.Parameters.AddWithValue("@idcostodamodificare", idcostodamodificare);
                command.ExecuteNonQuery();
            }
            reader.Close();

            connection.Close();

        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }*/

    [WebMethod]
    public string eliminaCantiere(int idcantiere)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command; MySqlDataReader reader;

                // Fase 1: Raccogliere tutti gli ID di BOLLAFATTURA che hanno righe che si riferiscono a quel cantiere
                command = connection.CreateCommand();
                command.CommandText = "SELECT DISTINCT(idbollafattura) as 'idbollafattura' FROM costo WHERE idcantiere = @idcantiere AND idbollafattura > 0"; // (idbollafattura > 0 perchè ci sono dati sporchi, verificare)
                command.Parameters.AddWithValue("@idcantiere", idcantiere);

                List<int> listaBollaFattura = new List<int>();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    listaBollaFattura.Add((int)reader["idbollafattura"]);
                }
                reader.Close();


                // SELECT idbollafattura FROM costo WHERE idcantiere = @idcantiere 
                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM costo WHERE idcantiere = @idcantiere";
                command.Parameters.AddWithValue("@idcantiere", idcantiere);

                command.ExecuteNonQuery();

                // Fase 2: Elimino le BOLLAFATTURA senza righe restringendomi agli ID raggruppati nel punto 1
                for (int i = 0; i < listaBollaFattura.Count; i++)
                {
                    /*SELECT bollafattura.id
                    FROM bollafattura left join costo on bollafattura.id = costo.idbollafattura 
                    WHERE bollafattura.id = 45 AND costo.id IS NULL*/
                    // se si sono svuotate cancello la riga
                    int idbollafattura = listaBollaFattura[i];
                    command = connection.CreateCommand();
                    command.CommandText = "DELETE bollafattura "
                                        + "FROM bollafattura left join costo on bollafattura.id = costo.idbollafattura "
                                        + "WHERE bollafattura.id = @idbollafattura AND costo.id IS NULL";
                    command.Parameters.AddWithValue("@idbollafattura", idbollafattura);

                    command.ExecuteNonQuery();
                }

                /*QUERY DI CONTROLLO: SELECT bollafattura.id
                FROM bollafattura LEFT JOIN costo ON bollafattura.id = costo.idbollafattura 
                WHERE costo.id IS NULL*/

                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM cantiere WHERE id = @idcantiere";
                command.Parameters.AddWithValue("@idcantiere", idcantiere);

                command.ExecuteNonQuery();

                connection.Close();
            }

        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public string nuovaVoce(object parametriQuery, object parametriQuery2)
    {
        String jsonString = "";
        // parametri per la nuova suddivisione
        Int32 idcomputo = 0;
        Int32 idpadre = 0;
        String descrizionesuddivisione = "";
        Int32 posizionesuddivisione = 99999;
        foreach (DictionaryEntry item in (IDictionary)parametriQuery)
        {
            String nomeParametro = item.Key.ToString();
            String valoreParametro = item.Value.ToString();
            if (nomeParametro == "idcomputo") idcomputo = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idpadre") idpadre = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "descrizione") descrizionesuddivisione = valoreParametro.ToString();
            //if (nomeParametro == "posizionesuddivisione") posizionesuddivisione = valoreParametro.ToString();
        }
        // parametri per la nuova voce
        // Int32 idcomputo = 0; ce l'ho già
        Int32 idsuddivisione = 0; // lo ottengo dopo l'insert del precedente
        Int32 idvoceorigine = 0;
        int? idvocetemplate = 0;
        String codice = "";
        String titolo = "";
        String descrizionevoce = "";
        Int32 posizionevoce = 99999;
        foreach (DictionaryEntry item in (IDictionary)parametriQuery2)
        {
            String nomeParametro = item.Key.ToString();
            String valoreParametro = item.Value.ToString();
            if (nomeParametro == "idcomputo") idcomputo = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idsuddivisione") idsuddivisione = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idvoceorigine") idvoceorigine = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "codice") codice = valoreParametro.ToString();
            if (nomeParametro == "idvocetemplate") idvocetemplate = valoreParametro == null ? null : (int?)Convert.ToInt32(valoreParametro);
            if (nomeParametro == "titolo") titolo = valoreParametro.ToString();
            if (nomeParametro == "descrizionevoce") descrizionevoce = valoreParametro.ToString();
            if (nomeParametro == "posizionevoce") posizionevoce = Convert.ToInt32(valoreParametro);
        }

        try
        {
            Int32 idVoce;

            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                // in caso di nuova suddivisione
                if (descrizionesuddivisione != "")
                {
                    MySqlCommand command = connection.CreateCommand();
                    command.CommandText = "INSERT INTO suddivisione (idcomputo, idpadre, descrizione, posizione)" +
                                          "VALUES (@idcomputo, @idpadre, @descrizione, @posizione)";

                    command.Parameters.AddWithValue("@idcomputo", idcomputo);
                    if (idpadre == 0) // idpadre non deve essere inserito se non presente così diventa valore di root
                        command.Parameters.AddWithValue("@idpadre", null);
                    else
                        command.Parameters.AddWithValue("@idpadre", idpadre);
                    command.Parameters.AddWithValue("@descrizione", descrizionesuddivisione);
                    command.Parameters.AddWithValue("@posizione", posizionesuddivisione);
                    command.ExecuteNonQuery();


                    // ottieni l'idsuddivisione dell'ultimo elemento inserito
                    command.CommandText = "Select @@Identity";
                    idsuddivisione = Convert.ToInt32(command.ExecuteScalar());

                    // rinormalizza la posizione delle suddivisioni
                    rinormalizzaPosizioneSuddivisioni(idsuddivisione);
                }

                MySqlCommand command2 = connection.CreateCommand();
                command2.CommandText = @"
                    INSERT INTO voce (idcomputo, idsuddivisione, idvoceorigine, codice, idvocetemplate, titolo, descrizione, posizione)
                    VALUES (@idcomputo, @idsuddivisione, @idvoceorigine, @codice, @idvocetemplate, @titolo, @descrizione, @posizione)
                ";

                command2.Parameters.AddWithValue("@idcomputo", idcomputo);
                command2.Parameters.AddWithValue("@idsuddivisione", idsuddivisione);
                command2.Parameters.AddWithValue("@idvoceorigine", idvoceorigine);
                command2.Parameters.AddWithValue("@codice", codice);
                command2.Parameters.AddWithValue("@idvocetemplate", idvocetemplate);
                command2.Parameters.AddWithValue("@titolo", titolo);
                command2.Parameters.AddWithValue("@descrizione", descrizionevoce);
                command2.Parameters.AddWithValue("@posizione", posizionevoce);
                command2.ExecuteNonQuery();

                // ottieni l'idsuddivisione dell'ultimo elemento inserito
                command2.CommandText = "Select @@Identity";
                idVoce = Convert.ToInt32(command2.ExecuteScalar());

                connection.Close();
            }

            // rinormalizza la posizione delle voci
            rinormalizzaPosizioneVoci(idsuddivisione);

            jsonString = JsonConvert.SerializeObject(idVoce);
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }


    [WebMethod]
    public string modificaVoce(object parametriQuery, object parametriQuery2)
    {
        String jsonString = "";
        // parametri per la nuova suddivisione
        Int32 idcomputo = 0;
        Int32 idpadre = 0;
        String descrizionesuddivisione = "";
        String posizione = "";
        foreach (DictionaryEntry item in (IDictionary)parametriQuery)
        {
            String nomeParametro = item.Key.ToString();
            String valoreParametro = item.Value.ToString();
            if (nomeParametro == "idcomputo") idcomputo = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idpadre") idpadre = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "descrizione") descrizionesuddivisione = valoreParametro.ToString();
            if (nomeParametro == "posizione") posizione = valoreParametro.ToString();
        }
        // parametri per la nuova voce
        Int32 idvoce = 0;
        // Int32 idcomputo = 0; ce l'ho già
        Int32 idsuddivisione = 0; // lo ottengo dopo l'insert del precedente
        Int32 idvoceorigine = 0;
        String codice = "";
        String titolo = "";
        String descrizionevoce = "";
        Int32 posizionevoce = 0;
        foreach (DictionaryEntry item in (IDictionary)parametriQuery2)
        {
            String nomeParametro = item.Key.ToString();
            String valoreParametro = item.Value.ToString();
            if (nomeParametro == "idvoce") idvoce = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idcomputo") idcomputo = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idsuddivisione") idsuddivisione = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "idvoceorigine") idvoceorigine = Convert.ToInt32(valoreParametro);
            if (nomeParametro == "codice") codice = valoreParametro.ToString();
            if (nomeParametro == "titolo") titolo = valoreParametro.ToString();
            if (nomeParametro == "descrizionevoce") descrizionevoce = valoreParametro.ToString();
            if (nomeParametro == "posizionevoce") posizionevoce = Convert.ToInt32(valoreParametro);
        }

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                // in caso di nuova suddivisione
                if (descrizionesuddivisione != "")
                {
                    MySqlCommand command = connection.CreateCommand();
                    command.CommandText = "INSERT INTO suddivisione (idcomputo, idpadre, descrizione, posizione)" +
                                          "VALUES (@idcomputo, @idpadre, @descrizione, @posizione)";

                    command.Parameters.AddWithValue("@idcomputo", idcomputo);
                    if (idpadre == 0) // idpadre non deve essere inserito se non presente così diventa valore di root
                        command.Parameters.AddWithValue("@idpadre", null);
                    else
                        command.Parameters.AddWithValue("@idpadre", idpadre);
                    command.Parameters.AddWithValue("@descrizione", descrizionesuddivisione);
                    command.Parameters.AddWithValue("@posizione", posizione);
                    command.ExecuteNonQuery();


                    // ottieni l'idsuddivisione dell'ultimo elemento inserito
                    command.CommandText = "Select @@Identity";
                    idsuddivisione = Convert.ToInt32(command.ExecuteScalar());
                }

                MySqlCommand command2 = connection.CreateCommand();
                command2.CommandText = "UPDATE voce " +
                                       "SET idcomputo = @idcomputo, " +
                                       "    idsuddivisione = @idsuddivisione, " +
                                       "    idvoceorigine = @idvoceorigine, " +
                                       "    codice = @codice, " +
                                       "    titolo = @titolo, " +
                                       "    descrizione = @descrizione, " +
                                       "    posizione = @posizione " +
                                       "WHERE id = @id";

                command2.Parameters.AddWithValue("@idcomputo", idcomputo);
                command2.Parameters.AddWithValue("@idsuddivisione", idsuddivisione);
                command2.Parameters.AddWithValue("@idvoceorigine", idvoceorigine);
                command2.Parameters.AddWithValue("@codice", codice);
                command2.Parameters.AddWithValue("@titolo", titolo);
                command2.Parameters.AddWithValue("@descrizione", descrizionevoce);
                command2.Parameters.AddWithValue("@posizione", posizionevoce);
                command2.Parameters.AddWithValue("@id", idvoce);
                command2.ExecuteNonQuery();

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }


    [WebMethod]
    public int duplicaVoce(int idvoceorigine)
    {
        // duplicare una voce mantiene idcomputo, idsuddivisione, (assegna idvoceorigine), codice, titolo, descrizione, posizione+1, 
        // poi dovrò rigenerare la posizione delle voci
        // infine copio tutte le righe associate alla voce di partenza, quindi clono la riga con la sola modifica della colonna idvoce.
        Int32 idvoce;
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            connection.Open();

            MySqlCommand command;
            MySqlDataReader reader;

            // duplico la voce
            command = connection.CreateCommand();
            command.CommandText = @"
                INSERT INTO voce (idcomputo, idsuddivisione, idvoceorigine, codice, titolo, descrizione, posizione)
                SELECT idcomputo, idsuddivisione, id, codice, titolo, descrizione, posizione+1
                FROM voce
                WHERE voce.id = @idvoceorigine";
            command.Parameters.AddWithValue("@idvoceorigine", idvoceorigine);

            command.ExecuteNonQuery();

            // ottengo l'id della nuova voce appena inserita
            /*command.CommandText = "Select @@Identity";
            Int32 idvoce = Convert.ToInt32(command.ExecuteScalar());*/
            idvoce = Convert.ToInt32(command.LastInsertedId);

            // ottengo l'idsuddivisione della nuova voce appena inserita
            command = connection.CreateCommand();
            command.CommandText = "SELECT idsuddivisione FROM voce WHERE id = @idvoce";
            command.Parameters.AddWithValue("@idvoce", idvoce);

            // idsuddivisione mi risulta che sia sempre !DBNull
            Int32 idsuddivisione = Convert.ToInt32(command.ExecuteScalar());

            // rigenero le posizioni della voce
            rinormalizzaPosizioneVoci(idsuddivisione);

            // ottengo una lista di tutte le misure associate alla voce di origine
            command = connection.CreateCommand();
            command.CommandText = "SELECT id FROM misura WHERE idvoce = @idvoceorigine";
            command.Parameters.AddWithValue("@idvoceorigine", idvoceorigine);

            List<int> listaMisure = new List<int>();
            reader = command.ExecuteReader();
            while (reader.Read()) {
                listaMisure.Add((int)reader["id"]);
            }
            reader.Close();

            // copio tutte le righe appartenenti alla voce creata
            for (int i = 0; i < listaMisure.Count; i++) {
                int idmisuraorigine = listaMisure[i];

                command = connection.CreateCommand();
                command.CommandText = @"
                    INSERT INTO misura (idvoce, idunitamisura, sottocodice, descrizione, prezzounitario, totalemisura, totaleimporto, posizione, pathimmagine, nomeimmagine, idmisuraorigine)
                    SELECT @idvoce, idunitamisura, sottocodice, descrizione, prezzounitario, totalemisura, totaleimporto, posizione, pathimmagine, nomeimmagine, @idmisuraorigine
                    FROM misura
                    WHERE misura.id = @idmisuraorigine";
                command.Parameters.AddWithValue("@idvoce", idvoce);
                command.Parameters.AddWithValue("@idmisuraorigine", idmisuraorigine);

                command.ExecuteNonQuery();
            }

            connection.Close();
        }

        return idvoce;
    }

    [WebMethod]
    public string trovaVoceSuccessiva(int idComputo)
    {
        string codice;
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            connection.Open();

            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "SELECT codice FROM voce WHERE idComputo = @idComputo ORDER BY id desc LIMIT 1";
            command.Parameters.AddWithValue("@idComputo", idComputo);

            Object primoElemento = (Object)command.ExecuteScalar();
            codice = (primoElemento == null) ? "" : primoElemento.ToString();

            if (codice.Contains("."))
            {
                String[] valori = codice.Split('.');
                if (valori.Length == 2)
                {
                    String stringa = valori[0];
                    Int32 numero = Convert.ToInt32(valori[1]);
                    codice = stringa + "." + (numero + 1).ToString();
                }
            }

            connection.Close();
        }

        return JsonConvert.SerializeObject(codice);
    }

    [WebMethod]
    public string trovaMisuraSuccessiva(int idVoce)
    {
        String jsonString = "";
        try
        {
            int sottocodice;
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT sottocodice FROM misura WHERE idVoce = @idVoce ORDER BY id desc LIMIT 1";
                command.Parameters.AddWithValue("@idVoce", idVoce);

                Object primoElemento = (Object)command.ExecuteScalar();
                sottocodice = (primoElemento == null) ? 0 : Convert.ToInt32(primoElemento);
                sottocodice = sottocodice + 1;

                connection.Close();
            }
            jsonString = JsonConvert.SerializeObject(sottocodice);
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    // SERVIVA PER LA PAGINA gestionale/computi/gestione-computo/gestione-computo.aspx NEL TAB MISURE, PERO' E' STATO SOSTITUITO DA NUOVO CODICE
    /*<%--<div class="btn btn-success" onclick="
        aggiornaImmagine('popupTabellaMisureModificaSoloImmagine', 'popupTabellaMisureModificaSoloImmagineFileUpload', 'iwebSQLUPDATE2');
      ">Aggiorna</div>--%>*/
    /*[WebMethod]
    public string aggiornaImmagine(string query, string parametri, string datiImmagine, string nomeImmagine)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        String jsonString = "";

        Int32 id = 0;
        if (parametri != "")
        {
            String[] listaParametri = parametri.Split(new string[] { "&&&" }, StringSplitOptions.None);
            for (int i = 0; i < listaParametri.Length; i++)
            {
                String parametroTemp = listaParametri[i].Split('=')[0];
                String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                if (parametroTemp == "@id")
                    id = Convert.ToInt32(valoreTemp);
            }
        }

        String percorsoFile = Server.MapPath("~/" + System.Configuration.ConfigurationManager.AppSettings["percorsoUploadImmaginiGestionale"].ToString());
        String nomeFile = 
            DateTime.Now.Year.ToString() + "_" +
            DateTime.Now.Month.ToString() + "_" +
            DateTime.Now.Day.ToString() + "_" +
            DateTime.Now.Hour.ToString() + "_" +
            DateTime.Now.Minute.ToString() + "_" +
            DateTime.Now.Second.ToString() + "_" +
            DateTime.Now.Millisecond.ToString() + "-" +
            id.ToString() +
            "-" + nomeImmagine;
        byte[] originale = Convert.FromBase64String(datiImmagine);

        try
        {
            //if (nomefile != "")
            //   File.Delete(percorsoFile + nomeFile);
            using (Stream outputFile = File.Open(percorsoFile + nomeFile, FileMode.Create, FileAccess.ReadWrite))
            {
                outputFile.Write(originale, 0, (int)originale.Length);
                outputFile.Close();
            }

            //STRINGA DI CONNESSIONE
            MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
            connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");

            connection.Open();

            MySqlCommand command = connection.CreateCommand();
            command.CommandText = query;

            if (parametri != "")
            {
                String[] listaParametri = parametri.Split(new string[] { "&&&" }, StringSplitOptions.None);
                for (int i = 0; i < listaParametri.Length; i++)
                {
                    String parametroTemp = listaParametri[i].Split('=')[0];
                    String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                    if (parametroTemp == "@pathimmagine")
                        valoreTemp = nomeFile; // non salvo il percorso
                    command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                }
            }
            command.ExecuteNonQuery();

            connection.Close();
            jsonString = JsonConvert.SerializeObject(nomeFile);
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }*/

    // le posizioni funzionano di 10 in 10
    // spostaMisuraSopra(...);
    // spostaMisuraSotto(...);
    [WebMethod]
    public string spostaMisuraSopra(int IDMisuraDaSpostare)
    {
        return spostaMisura(IDMisuraDaSpostare, 0 - 11);
    }

    [WebMethod]
    public string spostaMisuraSotto(int IDMisuraDaSpostare)
    {
        return spostaMisura(IDMisuraDaSpostare, 11);
    }

    private string spostaMisura(int IDMisuraDaSpostare, int spostamento)
    {
        String jsonString = "";
        Int32 idvoce = 0;

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                //update misure set posizione = posizione - 11 where IDMisura = @IDMisuraDaSpostare
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "update misura set posizione = posizione + @spostamento where ID = @IDMisuraDaSpostare";
                command.Parameters.AddWithValue("@spostamento", spostamento);
                command.Parameters.AddWithValue("@IDMisuraDaSpostare", IDMisuraDaSpostare);

                command.ExecuteNonQuery();

                //select IDVOCE from misure where IDMisuraDaSpostare = @IDMisuraDaSpostare
                MySqlCommand command2 = connection.CreateCommand();
                command2.CommandText = "select idvoce from misura where ID = @IDMisuraDaSpostare";
                command2.Parameters.AddWithValue("@IDMisuraDaSpostare", IDMisuraDaSpostare);

                idvoce = Convert.ToInt32(command2.ExecuteScalar());

                connection.Close();
            }
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        if (jsonString == "")
            jsonString = rinormalizzaPosizioneMisure(idvoce);

        return jsonString;
    }

    [WebMethod]
    public string rinormalizzaPosizioneMisure(int idvoce)
    {
        String jsonString = "";
        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                // select ID from misura where IDVoce = @IDVOCE order by posizione
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "select ID from misura where idvoce = @idvoce order by posizione";
                command.Parameters.AddWithValue("@idvoce", idvoce);

                int IDMisura = 0;
                List<int> list = new List<int>();
                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    //nomeCampo = reader.GetName(i);
                    // valoreCampo = reader[i];
                    IDMisura = (int)reader["ID"];
                    list.Add(IDMisura);
                }
                reader.Close();

                for (int i = 0; i < list.Count; i++)
                {
                    int posizioneCalcolata = i * 10;
                    int idmisura = list[i];

                    // update misura set posizione = i where IDMISURA = @idmisura
                    MySqlCommand command2 = connection.CreateCommand();
                    command2.CommandText = "update misura set posizione = @posizioneCalcolata where id = @idmisura";
                    command2.Parameters.AddWithValue("@posizioneCalcolata", posizioneCalcolata);
                    command2.Parameters.AddWithValue("@idmisura", idmisura);

                    command2.ExecuteNonQuery();
                }

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    // rimappaSuddivisioneVoci(idsuddivisione da impostare, lista id voci da modificare)
    // esempio: rimappo le seguenti suddivisioni sotto la suddivisione 143. rimappaSuddivisioneVoci(143, [1023, 1024, 1025, 1028, 1034, 1035, 1037, 1038]);
    //  id  | idsuddivisione
    // 1023 | 140
    // 1024 | 140
    // 1025 | 140
    // 1028 | 141
    // 1034 | 142
    // 1035 | 142
    // 1037 | 143
    // 1038 | 143
    // prima ottengo le vecchie suddivisioni delle voci che vado a rimappare. Ottengo: [140, 141, 142] (escludo il 143 perchè è la suddivisione obiettivo)
    // a questo punto rimappo le voci sotto la nuova suddivisione.
    // con rinormalizzaPosizioneVoci(idsuddivisione) rimappo tutte le voci sotto le suddivisioni:  [140, 141, 142, 143] (aggiungo il 143 che è la suddivisione obiettivo)
    [WebMethod]
    public string rimappaSuddivisioneVoci(int idSuddivisione, object[] listaParametri)
    {
        String jsonString = "";

        try
        {
            List<int> lista_idsuddivisione_rinormalizzaPosizioneVoci = new List<int>();

            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlDataReader reader;
                MySqlCommand command;

                // ottengo tutte le suddivisioni delle voci che stanno venendo rimappate. Per ogni suddivisione trovata salvo le voci che rinormalizzerò dopo la rimappatura.
                command = connection.CreateCommand();

                String stringaParametri = "(";
                for (int i = 0; i < listaParametri.Length; i++)
                {
                    stringaParametri += "@parametro" + i + ","; // preparo la stringa
                    command.Parameters.AddWithValue("@parametro" + i, Convert.ToInt32(listaParametri[i])); // aggiungo i parametri
                }
                stringaParametri = stringaParametri.Substring(0, stringaParametri.Length - 1) + ")"; // tolgo l'ultima virgola e aggiungo ")"

                command.CommandText = "SELECT DISTINCT(idsuddivisione) FROM voce WHERE idSuddivisione <> @idSuddivisione AND id in " + stringaParametri;
                command.Parameters.AddWithValue("@idSuddivisione", idSuddivisione);

                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    lista_idsuddivisione_rinormalizzaPosizioneVoci.Add((int)reader["idsuddivisione"]);
                    //rinormalizzaPosizioneVoci((int)reader["idsuddivisione"]);
                }
                reader.Close();

                // rimappo le voci con la nuova suddivisione
                command = connection.CreateCommand();
                stringaParametri = "(";
                for (int i = 0; i < listaParametri.Length; i++)
                {
                    stringaParametri += "@parametro" + i + ",";
                    command.Parameters.AddWithValue("@parametro" + i, listaParametri[i].ToString());
                }
                stringaParametri = stringaParametri.Substring(0, stringaParametri.Length - 1) + ")"; // tolgo l'ultima virgola e aggiungo ")"

                command.CommandText = "UPDATE voce SET idsuddivisione = @idsuddivisione, posizione = posizione+99999 WHERE id in" + stringaParametri;
                command.Parameters.AddWithValue("@idsuddivisione", idSuddivisione);
                command.ExecuteNonQuery();

                connection.Close();
            }

            // aggiungo all'elenco la nuova suddivisione
            lista_idsuddivisione_rinormalizzaPosizioneVoci.Add(idSuddivisione);

            // rinormalizza la posizione delle voci
            for (int i = 0; i < lista_idsuddivisione_rinormalizzaPosizioneVoci.Count ; i++) {
                rinormalizzaPosizioneVoci(lista_idsuddivisione_rinormalizzaPosizioneVoci[i]);
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    /*[WebMethod]
    public string eliminaENormalizzaMisura(string query, string parametri, int idvoce)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        int idmisura = Convert.ToInt32(parametri.Split('=')[1]);

        string jsonString = sparaQueryExecuteNonQuery(query, parametri);

        if (jsonString.Contains("tutto ok"))
        {
            jsonString = rinormalizzaPosizioneMisure(idvoce);
        }

        return jsonString;
    }*/

    [WebMethod]
    public string eliminaENormalizzaMisura(int idmisura, int idvoce)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command; object objTemp;

                // ottengo il nome dell'immagine da cancellare
                command = connection.CreateCommand();
                command.CommandText = "SELECT pathimmagine FROM misura WHERE id = @id";
                command.Parameters.AddWithValue("@id", idmisura);

                objTemp = command.ExecuteScalar();
                String nomefile = objTemp == null ? "" : objTemp.ToString();

                // ottengo il percorso del file dell'immagine
                String percorsofile = Server.MapPath("~/" + System.Configuration.ConfigurationManager.AppSettings["percorsoUploadGestionaleScansioni"].ToString());

                // elimino il file
                if (nomefile != "")
                    File.Delete(percorsofile + nomefile);

                command = connection.CreateCommand();
                command.CommandText = "DELETE FROM misura WHERE id = @id";
                command.Parameters.AddWithValue("@id", idmisura);
                command.ExecuteNonQuery();

                connection.Close();
            }

            jsonString = rinormalizzaPosizioneMisure(idvoce);

        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    private String sparaQueryExecuteNonQuery(string query, string parametri)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = query;

                if (parametri != "")
                {
                    String[] listaParametri = parametri.Split(new string[] { "&&&" }, StringSplitOptions.None);
                    for (int i = 0; i < listaParametri.Length; i++)
                    {
                        String parametroTemp = listaParametri[i].Split('=')[0];
                        String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                        command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                    }
                }
                command.ExecuteNonQuery();

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public string inserisciENormalizzaMisura(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        String jsonString = "";

        Int32 idvoce = 0;
        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = query;

                if (parametri != "")
                {
                    String[] listaParametri = parametri.Split(new string[] { "&&&" }, StringSplitOptions.None);
                    for (int i = 0; i < listaParametri.Length; i++)
                    {
                        String parametroTemp = listaParametri[i].Split('=')[0];
                        String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                        command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                    }
                }
                command.ExecuteNonQuery();

                // ottieni l'IDUtente dell'ultimo elemento inserito
                command.CommandText = "Select @@Identity";
                object obj = command.ExecuteScalar();
                int idmisura = Convert.ToInt32(obj);

                // numero abbastanza grande che l'ordinamento su quel campo lo veda come ultimo elemento
                command.CommandText = "UPDATE misura SET posizione = 100000 WHERE id = @id";
                command.Parameters.Clear();
                command.Parameters.AddWithValue("@id", idmisura);
                command.ExecuteNonQuery();

                command.CommandText = "SELECT idvoce FROM misura WHERE id = @id";
                command.Parameters.Clear();
                command.Parameters.AddWithValue("@id", idmisura);
                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                { // nomeCampo = reader.GetName(i); valoreCampo = reader[i];
                    idvoce = (int)reader["idvoce"];
                }
                reader.Close();

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        // ho letto idvoce
        if (jsonString.Contains("tutto ok"))
            jsonString = rinormalizzaPosizioneMisure(idvoce);

        return jsonString;
    }

    [WebMethod]
    public string ottieniSuddivisioniComputo(int idComputo) {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM suddivisione WHERE idcomputo = @idcomputo";
                command.Parameters.AddWithValue("@idComputo", idComputo);

                // reader per leggere L'utente selezionato
                MySqlDataReader reader = command.ExecuteReader();
                List<Dictionary<String, object>> tabella = new List<Dictionary<String, object>>();
                Dictionary<String, object> tempRiga;

                while (reader.Read())
                {
                    String nomeCampo = "";
                    Object valoreCampo = "";
                    tempRiga = new Dictionary<String, object>();
                    for (int i = 0; i < reader.FieldCount; ++i)
                    {
                        nomeCampo = reader.GetName(i);
                        valoreCampo = reader[i];
                        tempRiga.Add(nomeCampo, valoreCampo);
                    }
                    tabella.Add(tempRiga);
                }
                reader.Close();

                // aggiorna jsonString
                jsonString = JsonConvert.SerializeObject(tabella);

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public string spostaSuddivisioneSinistra(int idSuddivisione)
    {   // sinistra significa:
        // x = cerco la riga che ha id = @idSuddivisione e idcomputo = @idcomputo.
        // y = cerco la riga che ha id = x.idpadre e idcomputo = @computo.
        // aggiorno x.idpadre, che assumerà come valore: y.idpadre.
        String jsonString = "";
        int idpadreDiQuestaRiga = 0;
        int idpadreDiRigaPadre = 0;

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM suddivisione WHERE id = @id";
                command.Parameters.AddWithValue("@id", idSuddivisione);
                // reader per leggere L'utente selezionato
                MySqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    idpadreDiQuestaRiga = reader["idpadre"] == null ? 0 : Convert.ToInt32(reader["idpadre"]);
                }
                reader.Close();

                if (idpadreDiQuestaRiga != 0)
                {
                    MySqlCommand command2 = connection.CreateCommand();
                    command2.CommandText = "SELECT * FROM suddivisione WHERE id = @id";
                    command2.Parameters.AddWithValue("@id", idpadreDiQuestaRiga);
                    // reader per leggere L'utente selezionato
                    MySqlDataReader reader2 = command2.ExecuteReader();
                    if (reader2.Read())
                    {
                        idpadreDiRigaPadre = reader2["idpadre"] == DBNull.Value ? 0 : Convert.ToInt32(reader2["idpadre"]);
                    }
                    reader2.Close();

                    MySqlCommand command3 = connection.CreateCommand();
                    command3.CommandText = "UPDATE suddivisione SET idpadre = @idpadre, posizione = @posizione WHERE id = @id";
                    if (idpadreDiRigaPadre == 0)
                        command3.Parameters.AddWithValue("@idpadre", DBNull.Value);
                    else
                        command3.Parameters.AddWithValue("@idpadre", idpadreDiRigaPadre);
                    command3.Parameters.AddWithValue("@posizione", 100000);
                    command3.Parameters.AddWithValue("@id", idSuddivisione);
                    command3.ExecuteNonQuery();
                }
                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        if (jsonString.Contains("tutto ok"))
            jsonString = rinormalizzaPosizioneSuddivisioni(idSuddivisione);

        return jsonString;
    }

    [WebMethod]
    public string spostaSuddivisioneDestra(int idSuddivisione)
    {
        // destra significa:
        // cerco l'elemento con posizione = posizione di questa riga - 10.
        // quello diventa il nuovo padre
        String jsonString = "";
        int posizioneDiQuestaRiga = 0;
        int idpadreDiQuestaRiga = 0;
        int idcomputoDiQuestaRiga = 0;
        int idDiRigaPadre = 0;

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM suddivisione WHERE id = @id";
                command.Parameters.AddWithValue("@id", idSuddivisione);
                // reader per leggere L'utente selezionato
                MySqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    idcomputoDiQuestaRiga = reader["idcomputo"] == null ? 0 : Convert.ToInt32(reader["idcomputo"]);
                    idpadreDiQuestaRiga = reader["idpadre"] == DBNull.Value ? 0 : Convert.ToInt32(reader["idpadre"]);
                    posizioneDiQuestaRiga = reader["posizione"] == null ? 0 : Convert.ToInt32(reader["posizione"]);
                }
                reader.Close();

                MySqlCommand command2 = connection.CreateCommand();
                if (idpadreDiQuestaRiga == 0)
                {
                    command2.CommandText = "SELECT * FROM suddivisione WHERE idcomputo = @idcomputo AND idpadre is null AND posizione = @posizione";
                    command2.Parameters.AddWithValue("@idcomputo", idcomputoDiQuestaRiga);
                    command2.Parameters.AddWithValue("@posizione", posizioneDiQuestaRiga - 10);
                }
                else
                {
                    command2.CommandText = "SELECT * FROM suddivisione WHERE idcomputo = @idcomputo AND idpadre = @idpadre AND posizione = @posizione";
                    command2.Parameters.AddWithValue("@idcomputo", idcomputoDiQuestaRiga);
                    command2.Parameters.AddWithValue("@idpadre", idpadreDiQuestaRiga);
                    command2.Parameters.AddWithValue("@posizione", posizioneDiQuestaRiga - 10);
                }
                // reader per leggere L'utente selezionato
                MySqlDataReader reader2 = command2.ExecuteReader();
                if (reader2.Read())
                {
                    idDiRigaPadre = reader2["id"] == DBNull.Value ? 0 : Convert.ToInt32(reader2["id"]);
                }
                reader2.Close();

                if (idDiRigaPadre != 0)
                {
                    MySqlCommand command3 = connection.CreateCommand();
                    // posizione va messo alla fine
                    command3.CommandText = "UPDATE suddivisione SET idpadre = @idpadre, posizione = @posizione WHERE id = @id";
                    command3.Parameters.AddWithValue("@idpadre", idDiRigaPadre);
                    command3.Parameters.AddWithValue("@posizione", 100000);
                    command3.Parameters.AddWithValue("@id", idSuddivisione);
                    command3.ExecuteNonQuery();
                }

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        if (jsonString.Contains("tutto ok"))
        {
            jsonString = rinormalizzaPosizioneSuddivisioni(idSuddivisione);
            jsonString = rinormalizzaPosizioneSuddivisioni(idDiRigaPadre);
        }

        return jsonString;
    }

    [WebMethod]
    public string spostaSuddivisioneSopra(int idSuddivisione)
    {
        return spostaSuddivisione(idSuddivisione, 0 - 11);
    }

    [WebMethod]
    public string spostaSuddivisioneSotto(int idSuddivisione)
    {
        return spostaSuddivisione(idSuddivisione, 11);
    }

    private string spostaSuddivisione(int idSuddivisione, int spostamento)
    {
        String jsonString = "tutto ok";

        Int32 idcomputo = 0;

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                //update misure set posizione = posizione - 11 where IDMisura = @IDMisuraDaSpostare
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "update suddivisione set posizione = posizione + @spostamento where id = @idSuddivisione";
                command.Parameters.AddWithValue("@spostamento", spostamento);
                command.Parameters.AddWithValue("@idSuddivisione", idSuddivisione);

                command.ExecuteNonQuery();

                MySqlCommand command2 = connection.CreateCommand();
                command2.CommandText = "select idcomputo from suddivisione where id = @idSuddivisione";
                command2.Parameters.AddWithValue("@idSuddivisione", idSuddivisione);

                idcomputo = Convert.ToInt32(command2.ExecuteScalar());

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        if (jsonString.Contains("tutto ok"))
            jsonString = rinormalizzaPosizioneSuddivisioni(idSuddivisione);

        return jsonString;
    }
    private string rinormalizzaPosizioneSuddivisioni(int idsuddivisione)
    {
        Int32 idcomputo = 0;
        object idpadre = null;
        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "select idcomputo, idpadre from suddivisione where id = @idsuddivisione";
                command.Parameters.AddWithValue("@idsuddivisione", idsuddivisione);
                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    idcomputo = (int)reader["idcomputo"];
                    if (reader["idpadre"] != DBNull.Value)
                        idpadre = Convert.ToInt32(reader["idpadre"]);
                }
                connection.Close();
            }
        }
        catch (Exception ex)
        {
            String jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }
        return rinormalizzaPosizioneSuddivisioni(idcomputo, idpadre);
    }
    private string rinormalizzaPosizioneSuddivisioni(int idcomputo, object idpadre)
    {
        String jsonString = "";
        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                // select ID from misura where IDVoce = @IDVOCE order by posizione
                MySqlCommand command = connection.CreateCommand();
                if (idpadre == null)
                {
                    command.CommandText = "select ID from suddivisione where idcomputo = @idcomputo AND idpadre is null order by posizione";
                    command.Parameters.AddWithValue("@idcomputo", idcomputo);
                }
                else
                {
                    command.CommandText = "select ID from suddivisione where idcomputo = @idcomputo AND idpadre = @idpadre order by posizione";
                    command.Parameters.AddWithValue("@idcomputo", idcomputo);
                    command.Parameters.AddWithValue("@idpadre", idpadre);
                }

                int idSuddivisione = 0;
                List<int> list = new List<int>();
                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    //nomeCampo = reader.GetName(i);
                    // valoreCampo = reader[i];
                    idSuddivisione = (int)reader["ID"];
                    list.Add(idSuddivisione);
                }
                reader.Close();

                for (int i = 0; i < list.Count; i++)
                {
                    int posizioneCalcolata = i * 10;
                    idSuddivisione = list[i];

                    // update misura set posizione = i where IDMISURA = @idmisura
                    MySqlCommand command2 = connection.CreateCommand();
                    command2.CommandText = "update suddivisione set posizione = @posizioneCalcolata where id = @idSuddivisione";
                    command2.Parameters.AddWithValue("@posizioneCalcolata", posizioneCalcolata);
                    command2.Parameters.AddWithValue("@idSuddivisione", idSuddivisione);

                    command2.ExecuteNonQuery();
                }

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public String ottieniVociAssociateAlComputo(object idSuddivisione)
    {
        String jsonString = "[\"tutto ok\"]";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                // select ID from misura where IDVoce = @IDVOCE order by posizione
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM voce WHERE idsuddivisione = @idsuddivisione";
                command.Parameters.AddWithValue("@idSuddivisione", idSuddivisione);

                // reader per leggere L'utente selezionato
                MySqlDataReader reader = command.ExecuteReader();
                List<Dictionary<String, object>> tabella = new List<Dictionary<String, object>>();
                Dictionary<String, object> tempRiga;

                while (reader.Read())
                {
                    String nomeCampo = "";
                    Object valoreCampo = "";
                    tempRiga = new Dictionary<String, object>();
                    for (int i = 0; i < reader.FieldCount; ++i)
                    {
                        // se ho "cliente.id" mi prende solo "id", come lo risolvo?
                        nomeCampo = reader.GetName(i);
                        valoreCampo = reader[i];
                        tempRiga.Add(nomeCampo, valoreCampo);
                    }
                    tabella.Add(tempRiga);
                }
                reader.Close();

                // aggiorna jsonString
                jsonString = JsonConvert.SerializeObject(tabella);

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }
        
        return jsonString;
    }






    // le posizioni funzionano di 10 in 10
    // spostaMisuraSopra(...);
    // spostaMisuraSotto(...);
    [WebMethod]
    public string spostaVoceSopra(int IDVoceDaSpostare)
    {
        return spostaVoce(IDVoceDaSpostare, 0 - 11);
    }

    [WebMethod]
    public string spostaVoceSotto(int IDVoceDaSpostare)
    {
        return spostaVoce(IDVoceDaSpostare, 11);
    }

    private string spostaVoce(int IDVoceDaSpostare, int spostamento)
    {
        String jsonString = "";

        try
        {
            int idsuddivisione = 0;
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();
                MySqlDataReader reader;

                // aggiorna la voce alla nuova posizione
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "UPDATE voce SET posizione = posizione + @spostamento WHERE id = @IDVoceDaSpostare";
                command.Parameters.AddWithValue("@spostamento", spostamento);
                command.Parameters.AddWithValue("@IDVoceDaSpostare", IDVoceDaSpostare);
                command.ExecuteNonQuery();

                command = connection.CreateCommand();
                command.CommandText = "SELECT idcomputo, idsuddivisione FROM voce WHERE id = @IDVoceDaSpostare";
                command.Parameters.AddWithValue("@IDVoceDaSpostare", IDVoceDaSpostare);

                //int idcomputo = 0;
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    //idcomputo = (int)reader["idcomputo"];
                    idsuddivisione = (int)reader["idsuddivisione"];
                }
                reader.Close();

                connection.Close();
            }

            // rinormalizza tutte le voci con un certo idcomputo e idsuddivisione
            jsonString = rinormalizzaPosizioneVoci(idsuddivisione);
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }
    [WebMethod]
    public string rinormalizzaPosizioneVoci(int idsuddivisione)
    {
        String jsonString = "";
        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                // select ID from misura where IDVoce = @IDVOCE order by posizione
                MySqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT id FROM voce WHERE idsuddivisione = @idsuddivisione ORDER BY posizione";
                command.Parameters.AddWithValue("@idsuddivisione", idsuddivisione);

                // salvo in un array temporaneo tutte le voci con idcomputo e idsuddivisione passati come parametro
                int idVoce = 0;
                List<int> list = new List<int>();
                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    idVoce = (int)reader["ID"];
                    list.Add(idVoce);
                }
                reader.Close();

                // ricalcolo la posizione per ogni elemento
                for (int i = 0; i < list.Count; i++)
                {
                    int posizioneCalcolata = i * 10;
                    idVoce = list[i];

                    // update misura set posizione = i where IDMISURA = @idmisura
                    MySqlCommand command2 = connection.CreateCommand();
                    command2.CommandText = "UPDATE voce SET posizione = @posizioneCalcolata WHERE id = @idVoce";
                    command2.Parameters.AddWithValue("@posizioneCalcolata", posizioneCalcolata);
                    command2.Parameters.AddWithValue("@idVoce", idVoce);

                    command2.ExecuteNonQuery();
                }

                connection.Close();
            }

            jsonString = JsonConvert.SerializeObject("tutto ok");
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }






    [WebMethod]
    public string stampaPDF(int idStampa)
    {
        Random rnd = new Random();
        string nomeFile = DateTime.Now.Year.ToString()
            + DateTime.Now.Month.ToString()
            + DateTime.Now.Day.ToString()
            + DateTime.Now.Hour.ToString()
            + DateTime.Now.Minute.ToString()
            + DateTime.Now.Second.ToString()
            + DateTime.Now.Millisecond.ToString()
            + "-"
            + rnd.Next().ToString() + ".pdf";

        String percorsoFilePDF = System.Configuration.ConfigurationManager.AppSettings["percorsoUploadPDFGestionale"].ToString();
        percorsoFilePDF += nomeFile;
        percorsoFilePDF = Server.MapPath(percorsoFilePDF);

        string connectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");
        StampaPDF.stampaPDF(idStampa, percorsoFilePDF, Server.MapPath("/gestionale/immagini/"), Server.MapPath("/public/"), connectionString);
        return "[{\"nomeFile\":\"" + nomeFile + "\"}]";
        //return nomeFile;
    }

    [WebMethod]
    public string salvaPDFSuddivisioniEAggiornaComputo(int idStampa, object[] suddivisioni,
        string idcomputo, string condizioniultimapagina)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command;

                for (int i = 0; i < suddivisioni.Length; i++)
                {
                    Int32 idsuddivisione = Convert.ToInt32(suddivisioni[i]);

                    command = connection.CreateCommand();
                    command.CommandText = "INSERT INTO suddivisionepdf (idcomputopdf, idsuddivisione) VALUES (@idcomputopdf, @idsuddivisione)";
                    command.Parameters.AddWithValue("@idcomputopdf", idStampa);
                    command.Parameters.AddWithValue("@idsuddivisione", idsuddivisione);

                    command.ExecuteNonQuery();
                }

                command = connection.CreateCommand();
                command.CommandText = "UPDATE computo SET condizioniultimapagina = @condizioniultimapagina WHERE id = @idcomputo";
                command.Parameters.AddWithValue("@condizioniultimapagina", condizioniultimapagina);
                command.Parameters.AddWithValue("@idcomputo", idcomputo);
                command.ExecuteNonQuery();

                connection.Close();
            }
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }


    [WebMethod]
    public void duplicaDatiPDFSuddivisioniEComputo(int idcomputopdf)
    {
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            connection.Open();

            MySqlCommand command;

            command = connection.CreateCommand();
            command.CommandText = @"
                INSERT INTO computopdf (idcomputo, datacreazione, dataora, stampaprezzi, stampacopertina, stampasuddivisioni,
                        stampamisure, stampatotalenellesuddivisioni, stampatotalefinale, titolocomputo, stampalogo, 
                        stampanumeropagina, iva, indicaSoloTotale)
                SELECT idcomputo, datacreazione, Now(), stampaprezzi, stampacopertina, stampasuddivisioni,
                        stampamisure, stampatotalenellesuddivisioni, stampatotalefinale, titolocomputo, stampalogo, 
                        stampanumeropagina, iva, indicaSoloTotale
                FROM computopdf
                WHERE id = @idcomputopdf";
            command.Parameters.AddWithValue("@idcomputopdf", idcomputopdf);
            command.ExecuteNonQuery();

            long idcomputopdfnuovo = (long)command.LastInsertedId;


            command = connection.CreateCommand();
            command.CommandText = @"
                INSERT INTO suddivisionepdf (idcomputopdf, idsuddivisione) 
                SELECT @idcomputopdfnuovo, idsuddivisione
                FROM suddivisionepdf
                WHERE idcomputopdf = @idcomputopdf";
            command.Parameters.AddWithValue("@idcomputopdf", idcomputopdf);
            command.Parameters.AddWithValue("@idcomputopdfnuovo", idcomputopdfnuovo);

            command.ExecuteNonQuery();
            connection.Close();
        }
    }




    [WebMethod]
    public string eliminaUnitaDiMisura(int id)
    {
        // query:
        // SELECT COUNT(id) as 'risultato' FROM misura WHERE idunitamisura = @id
        // SELECT COUNT(id) as 'risultato' FROM prodotto WHERE idunitadimisura = @id
        String jsonString = "";
        Int32 elTrovati = 0;
        object temp = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand commandCount;
                MySqlDataReader reader;

                // conto gli elementi con questa unita' di misura nella tabella misura
                commandCount = connection.CreateCommand();
                commandCount.CommandText = "SELECT COUNT(id) as 'risultato' FROM misura WHERE idunitamisura = @id";
                commandCount.Parameters.AddWithValue("@id", id);

                reader = commandCount.ExecuteReader();
                if (reader.Read())
                    elTrovati += Convert.ToInt32(reader["risultato"]);
                reader.Close();

                // conto gli elementi con questa unita' di misura nella tabella prodotto
                commandCount = connection.CreateCommand();
                commandCount.CommandText = "SELECT COUNT(id) as 'risultato' FROM prodotto WHERE idunitadimisura = @id";
                commandCount.Parameters.AddWithValue("@id", id);

                reader = commandCount.ExecuteReader();
                if (reader.Read())
                    elTrovati += Convert.ToInt32(reader["risultato"]);
                reader.Close();

                // se non ho trovato righe con questa unita di misura posso cancellare questa riga
                if (elTrovati == 0)
                {
                    MySqlCommand command = connection.CreateCommand();
                    command.CommandText = "DELETE FROM unitadimisura WHERE id = @id";
                    command.Parameters.AddWithValue("@id", id);
                    command.ExecuteNonQuery();

                    jsonString = "[{\"risultato\":" + 0 + "}]";
                }
                jsonString = "[{\"risultato\":" + elTrovati.ToString() + "}]";

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }


    [WebMethod]
    public String inserisciCantiere(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        String codice = parametri.Split(new string[] { "codice=" }, StringSplitOptions.None)[1].Split(new string[] { "&&&" }, StringSplitOptions.None)[0];
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlDataReader reader;
                MySqlCommand command;
                command = connection.CreateCommand();
                command.CommandText = "SELECT id FROM cantiere WHERE codice = @codice";
                command.Parameters.AddWithValue("@codice", codice);

                //bool trovato = command.ExecuteScalar() != DBNull.Value;
                bool trovato = false;
                reader = command.ExecuteReader();
                if (reader.Read())
                    trovato = true;
                reader.Close();

                // ho trovato un codice già presente, ritorno il codice errore
                if (trovato)
                {
                    jsonString = "[{\"risultato\":\"Codice esistente\"}]";
                }
                else
                {
                    // non ho trovato il codice, posso eseguire il regolare inserimento
                    command = connection.CreateCommand();
                    command.CommandText = query;

                    if (parametri != "")
                    {
                        String[] listaParametri = parametri.Split(new string[] { "&&&" }, StringSplitOptions.None);
                        for (int i = 0; i < listaParametri.Length; i++)
                        {
                            String parametroTemp = listaParametri[i].Split('=')[0];
                            String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                            command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                        }
                    }
                    command.ExecuteNonQuery();
                    jsonString = "[{\"risultato\":\"Inserimento effettuato\"}]";
                }

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public String modificaCantiere(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        String codice = parametri.Split(new string[] { "codice=" }, StringSplitOptions.None)[1].Split(new string[] { "&&&" }, StringSplitOptions.None)[0];
        String stringaIDCantiere = parametri.Split(new string[] { "id=" }, StringSplitOptions.None)[1].Split(new string[] { "&&&" }, StringSplitOptions.None)[0];
        Int32 idCantiere = Convert.ToInt32(stringaIDCantiere);
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlDataReader reader;
                MySqlCommand command;
                command = connection.CreateCommand();
                command.CommandText = "SELECT id FROM cantiere WHERE codice = @codice AND id <> @id";
                command.Parameters.AddWithValue("@codice", codice);
                command.Parameters.AddWithValue("@id", idCantiere);

                //bool trovato = command.ExecuteScalar() != DBNull.Value;
                bool trovato = false;
                reader = command.ExecuteReader();
                if (reader.Read()) trovato = true;
                reader.Close();

                // ho trovato un codice già presente, ritorno il codice errore
                if (trovato)
                {
                    jsonString = "[{\"risultato\":\"Codice esistente\"}]";
                }
                else
                {
                    // non ho trovato il codice, posso eseguire il regolare inserimento
                    command = connection.CreateCommand();
                    command.CommandText = query;

                    if (parametri != "")
                    {
                        String[] listaParametri = parametri.Split(new string[] { "&&&" }, StringSplitOptions.None);
                        for (int i = 0; i < listaParametri.Length; i++)
                        {
                            String parametroTemp = listaParametri[i].Split('=')[0];
                            String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                            command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                        }
                    }
                    command.ExecuteNonQuery();
                    jsonString = "[{\"risultato\":\"Modifica effettuata\"}]";
                }

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public String aggiornaRigheBolleAperte(object[] listaparametri, string query1, string query2, int idbollafattura)
    {
        query1 = IwebCrypter.iwebcsDecifraSQL(query1);
        query2 = IwebCrypter.iwebcsDecifraSQL(query2);

        String parametri = "";
        String[] temp;
        Boolean aggiornaDatoProdotto = false;

        String errore = "";

        // per ogni riga con dati validi devo eseguire un inserimento sulla tabella costo (la riga aperta resta, ma viene aggiunta una riga chiusa collegata alla riga aperta)
        for (int i = 0; i < listaparametri.Length; i++)
        {
            parametri = listaparametri[i].ToString();
            temp = parametri.Split(new string[] { "cbAggiornaDatoProdotto=" }, StringSplitOptions.None);
            aggiornaDatoProdotto = Convert.ToBoolean(temp[1]);

            errore = sparaQueryExecuteNonQuery(query1, parametri);
            if (aggiornaDatoProdotto == true)
                errore = sparaQueryExecuteNonQuery(query2, parametri);
        }

        // verifico se tutte le righe sono state chiuse. Se vero, la bolla viene automaticamente chiusa
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            connection.Open();

            MySqlCommand command; object objTemp;

            command = connection.CreateCommand();
            // conto le righe aperte
            command.CommandText = "SELECT COUNT(*) "
                                + "FROM costo LEFT JOIN costo as costoinfattura ON costoinfattura.idcostobollariferita = costo.id "
                                + "WHERE costo.idbollafattura = @idbollafattura AND costo.idbollafattura <> 0 AND costoinfattura.id is null";
            command.Parameters.AddWithValue("@idbollafattura", idbollafattura);

            objTemp = command.ExecuteScalar();
            Int32 righeAperte = objTemp == null ? 0 : Convert.ToInt32(objTemp);

            // chiudi la bolla
            if (righeAperte == 0)
            {
                command = connection.CreateCommand();
                command.CommandText = "UPDATE bollafattura SET chiusa = 1 WHERE id = @idbollafattura";
                command.Parameters.AddWithValue("@idbollafattura", idbollafattura);
                command.ExecuteNonQuery();
            }

            connection.Close();
        }

        return "[{\"risultato\":\"Modifica effettuata\"}]";
    }

    [WebMethod]
    public String riapriBolla(int idbollafattura)
    {

        // verifico se tutte le righe sono state chiuse. Se vero, la bolla viene automaticamente chiusa
        using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            connection.Open();

            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "UPDATE bollafattura SET chiusa = 0 WHERE id = @idbollafattura";
            command.Parameters.AddWithValue("@idbollafattura", idbollafattura);
            command.ExecuteNonQuery();

            connection.Close();
        }

        return "[{\"risultato\":\"Modifica effettuata\"}]";
    }

    [WebMethod]
    public String ripartisciImportoSuCantieriAperti(double importo, int idprodotto, int idbollafattura, string descrizione)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlDataReader reader;
                MySqlCommand command;

                command = connection.CreateCommand();
                command.CommandText = "SELECT id FROM cantiere WHERE stato = 'Aperto'";

                List<int> listaIdCantiere = new List<int>();
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    listaIdCantiere.Add((int)reader["id"]);
                }
                reader.Close();

                // calcolo il singolo importo
                double singoloimporto = importo / listaIdCantiere.Count;

                for (int i = 0; i < listaIdCantiere.Count; i++)
                {
                    int idcantiere = listaIdCantiere[i];
                    DateTime datacosto = DateTime.Now;

                    command = connection.CreateCommand();
                    command.CommandText = "INSERT INTO costo (idbollafattura, idprodotto, idcantiere, idcostobollariferita, quantita, prezzo, sconto1, sconto2, datacosto, descrizione)"
                                        + "VALUES (@idbollafattura, @idprodotto, @idcantiere, 0, 1, @prezzo, 0, 0, @datacosto, @descrizione)";

                    command.Parameters.AddWithValue("@idbollafattura", idbollafattura);
                    command.Parameters.AddWithValue("@idprodotto", idprodotto);
                    command.Parameters.AddWithValue("@idcantiere", idcantiere);
                    command.Parameters.AddWithValue("@prezzo", singoloimporto);
                    command.Parameters.AddWithValue("@datacosto", datacosto);
                    command.Parameters.AddWithValue("@descrizione", descrizione);

                    command.ExecuteNonQuery();
                }

                jsonString = "[{\"risultato\":\"Modifica effettuata\"}]";

                connection.Close();
            }
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    // la funzione ritorna 0 o 1 (per ora)
    // ricevo come parametri giorno mese anno separatamente di proposito: anno è stato aggiunto, non si sa mai che venga tolto in futuro
    [WebMethod]
    public String verificaInserimentiDoppi(string numero, string giorno, string mese, string anno, string idfornitore)
    {
        String jsonString = "";

        try
        {
            List<int> listaIdDocumentiDoppi = new List<int>();

            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
            {
                connection.Open();

                MySqlCommand command;
                MySqlDataReader reader;

                command = connection.CreateCommand();
                command.CommandText = @"SELECT id 
                                    FROM bollafattura 
                                    WHERE idfornitore = @idfornitore AND 
                                          DAY(databollafattura) = @giorno AND
                                          MONTH(databollafattura) = @mese AND 
                                          YEAR(databollafattura) = @anno AND 
                                          numero = @numero";
                command.Parameters.AddWithValue("@idfornitore", idfornitore);
                command.Parameters.AddWithValue("@giorno", giorno);
                command.Parameters.AddWithValue("@mese", mese);
                command.Parameters.AddWithValue("@anno", anno);
                command.Parameters.AddWithValue("@numero", numero);

                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    listaIdDocumentiDoppi.Add((int)reader["id"]); // lista, nell'eventualità che mi serva la lista di id
                }
                reader.Close();

                connection.Close();
            }

            jsonString = "[{\"risultato\":\"" + (listaIdDocumentiDoppi.Count > 0 ? "1" : "0") + "\"}]";

        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }




    public void lanciaQuery(MySqlConnection mysqlconnection, string query, Dictionary<string, object> parametri) {
        MySqlCommand command = mysqlconnection.CreateCommand();
        command.CommandText = query;
        foreach (KeyValuePair<string, object> entry in parametri) command.Parameters.AddWithValue("@" + entry.Key, entry.Value);
        command.ExecuteNonQuery();
    }

    public long inserisciRecord(MySqlConnection mysqlconnection, string query, Dictionary<string, object> parametri) {

        MySqlCommand command = mysqlconnection.CreateCommand();
        command.CommandText = query;
        foreach (KeyValuePair<string, object> entry in parametri) command.Parameters.AddWithValue("@" + entry.Key, entry.Value);
        command.ExecuteNonQuery();
        return command.LastInsertedId;
    }
    public Dictionary<string, object> leggiRecordDaQuery(MySqlConnection mysqlconnection, string query, Dictionary<string, object> parametri) {

        List<Dictionary<string, object>> risultato = new List<Dictionary<string, object>>();
        Dictionary<string, object> record = null;

        MySqlCommand command = mysqlconnection.CreateCommand();
        command.CommandText = query;
        foreach (KeyValuePair<string, object> entry in parametri) command.Parameters.AddWithValue("@" + entry.Key, entry.Value);

        MySqlDataReader reader = command.ExecuteReader();
        if (reader.Read()) {
            // trasformo il record in un dictionary
            record = new Dictionary<string, object>();
            for (int i = 0; i < reader.FieldCount; i++) {
                record.Add(reader.GetName(i), reader[reader.GetName(i)]);
            }
        }
        reader.Close();
        return record;
    }
    public List<Dictionary<string, object>> leggiRecordsDaQuery(MySqlConnection mysqlconnection, string query, Dictionary<string, object> parametri) {

        List<Dictionary<string, object>> risultato = new List<Dictionary<string, object>>();
        Dictionary<string, object> record;

        MySqlCommand command = mysqlconnection.CreateCommand();
        command.CommandText = query;
        foreach (KeyValuePair<string, object> entry in parametri) command.Parameters.AddWithValue("@" + entry.Key, entry.Value);
        MySqlDataReader reader = command.ExecuteReader();
        while (reader.Read()) {
            // trasformo il record in un dictionary
            record = new Dictionary<string, object>();
            for (int i = 0; i < reader.FieldCount; i++) {
                record.Add(reader.GetName(i), reader[reader.GetName(i)]);
            }
            risultato.Add(record);
        }
        reader.Close();
        return risultato;
    }
    //public void aggiungiParametriNellaQuery(MySqlCommand command, Dictionary<string, object> parametri) {
    //    foreach (KeyValuePair<string, object> entry in parametri) command.Parameters.AddWithValue("@" + entry.Key, entry.Value);
    //}

    public Dictionary<string, object> combinaDictionary(Dictionary<string, object> dict1, Dictionary<string, object> dict2) {
        Dictionary<string, object> dictRisultato = new Dictionary<string, object>();
        foreach (Dictionary<string, object> dictI in new Dictionary<string, object>[] { dict1, dict2 }) {
            foreach (var item in dictI) {
                dictRisultato.Add(item.Key, item.Value);
            }
        }
        return dictRisultato;
    }
    public Dictionary<string, object> clonaDictionary(Dictionary<string, object> dict) {
        Dictionary<string, object> nuovoDict = new Dictionary<string, object>();
        foreach (var item in dict) {
            nuovoDict.Add(item.Key, item.Value);
        }
        return nuovoDict;
    }



    [WebMethod]
    public void clonaComputo(int idcomputosorg) {

        string p = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "Password");
        string stringaconnsorg = AppCode.GetDB.getDDBB(p);
        string stringaconndest = AppCode.GetDB.getDDBBasincrono(p);

        using (MySqlConnection connSorg = new MySqlConnection(stringaconnsorg)) {
            connSorg.Open();

            using (MySqlConnection connDest = new MySqlConnection(stringaconndest)) {
                connDest.Open();

                string query;
                Dictionary<string, object> parametriquery;

                // Leggo il record del computo sorgente
                query = @"
                    SELECT id, codice, titolo, descrizione, idcliente, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina, idcomputooriginaleclonato, ricaricopercentuale
                    FROM computo
                    WHERE id = @idcomputosorg";
                parametriquery = new Dictionary<string, object>() {
                    {"idcomputosorg", idcomputosorg}
                };
                Dictionary<string, object> recordcomputosorg = leggiRecordDaQuery(connSorg, query, parametriquery);

                // Leggo il record del cliente sorgente
                query = @"
                    SELECT id, nominativo, indirizzo, citta, provincia, telefono, email, cf, piva
                    FROM cliente
                    WHERE id = @idclientesorg";
                parametriquery = new Dictionary<string, object>() {
                    {"idclientesorg", recordcomputosorg["idcliente"]}
                };
                Dictionary<string, object> recordclientesorg = leggiRecordDaQuery(connSorg, query, parametriquery);

                // Inserisco il record del cliente destinazione
                query = @"
                    INSERT INTO cliente (nominativo, indirizzo, citta, provincia, telefono, email, cf, piva)
                    VALUES (@nominativo, @indirizzo, @citta, @provincia, @telefono, @email, @cf, @piva)";
                parametriquery = clonaDictionary(recordclientesorg);
                long idclientedest = inserisciRecord(connDest, query, parametriquery);

                // Inserisco il record del computo destinazione
                query = @"
                    INSERT INTO computo (codice, titolo, descrizione, idcliente, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina, idcomputooriginaleclonato, ricaricopercentuale)
                    VALUES (@codice, @titolo, @descrizione, @idcliente, @datadiconsegna, @stato, @tipo, @condizioniprimapagina, @condizioniultimapagina, null, @ricaricopercentuale)";
                parametriquery = clonaDictionary(recordcomputosorg);
                parametriquery["idcliente"] = idclientedest; // sovrascrivo l'id con quello di destinazione
                long idcomputodest = inserisciRecord(connDest, query, parametriquery);



                // ciclo esternamente sui computopdf sorgente e copio i dati nella destinazione
                Dictionary<long, long> idcomputopdfsorgtodest = new Dictionary<long, long>();
                long idcomputopdfsorg, idcomputopdfdest;
                query = @"
                    SELECT id, idcomputo, datacreazione, dataora, stampaprezzi, stampacopertina, stampasuddivisioni, stampamisure, stampatotalenellesuddivisioni,stampatotalefinale, titolocomputo, stampalogo, stampanumeropagina, iva, indicaSoloTotale
                    FROM computopdf
                    WHERE idcomputo = @idcomputosorg";
                parametriquery = new Dictionary<string, object>() {
                    {"idcomputosorg", idcomputosorg}
                };
                List<Dictionary<string, object>> recordscomputopdfsorg = leggiRecordsDaQuery(connSorg, query, parametriquery);
                for (int i = 0; i < recordscomputopdfsorg.Count; i++) {
                    Dictionary<string, object> recordcomputopdfsorg = recordscomputopdfsorg[i];
                    idcomputopdfsorg = (int)recordcomputopdfsorg["id"];

                    // Inserisco il record del computopdf destinazione
                    query = @"
                        INSERT INTO computopdf (idcomputo, datacreazione, dataora, stampaprezzi, stampacopertina, stampasuddivisioni, stampamisure, stampatotalenellesuddivisioni, stampatotalefinale, titolocomputo, stampalogo, stampanumeropagina, iva, indicaSoloTotale)
                        VALUES (@idcomputo, @datacreazione, @dataora, @stampaprezzi, @stampacopertina, @stampasuddivisioni, @stampamisure, @stampatotalenellesuddivisioni, @stampatotalefinale, @titolocomputo, @stampalogo, @stampanumeropagina, @iva, @indicaSoloTotale)";
                    parametriquery = clonaDictionary(recordcomputopdfsorg);
                    parametriquery["idcomputo"] = idcomputodest; // sovrascrivo l'id con quello di destinazione
                    idcomputopdfdest = inserisciRecord(connDest, query, parametriquery);

                    idcomputopdfsorgtodest.Add(idcomputopdfdest, idcomputopdfdest);
                }


                Dictionary<long, long> idsuddivisioneoldtonew = new Dictionary<long, long>();
                idsuddivisioneoldtonew = clonaSuddivisioni(idcomputosorg, idcomputodest, connSorg, connDest, null, idsuddivisioneoldtonew);

                clonaSuddivisioniPdf(connDest, idcomputopdfsorgtodest, idsuddivisioneoldtonew);

                // nel ciclo interno clono anche le misure 
                clonaVoci(idcomputosorg, idcomputodest, connSorg, connDest, idsuddivisioneoldtonew);

                //// ciclo esternamente sui suddivisionepdf sorgente e copio i dati nella destinazione
                //query = @"
                //    SELECT id, idsuddivisione
                //    FROM suddivisionepdf
                //    WHERE idcomputo = @idcomputosorg";
                //parametriquery = new Dictionary<string, object>() {
                //    {"idcomputosorg", idcomputosorg}
                //};
                //List<Dictionary<string, object>> recordssuddivisionepdfsorg = leggiRecordsDaQuery(connSorg, query, parametriquery);
                //for (int i = 0; i < recordssuddivisionepdfsorg.Count; i++) {
                //    Dictionary<string, object> recordsuddivisionepdfsorg = recordssuddivisionepdfsorg[i];

                //    int idsuddivisionepdf = (int)recordsuddivisionepdfsorg["idsuddivisionepdf"];
                //    int idsuddivisione = (int)recordsuddivisionepdfsorg["idsuddivisione"];

                //    // Inserisco il record del suddivisionepdf destinazione
                //    query = @"
                //        INSERT INTO suddivisionepdf (idcomputo, datacreazione, dataora, stampaprezzi, stampacopertina, stampasuddivisioni, stampamisure, stampatotalenellesuddivisioni, stampatotalefinale, titolocomputo, stampalogo, stampanumeropagina, iva, indicaSoloTotale)
                //        VALUES (@idcomputo, @datacreazione, @dataora, @stampaprezzi, @stampacopertina, @stampasuddivisioni, @stampamisure, @stampatotalenellesuddivisioni, @stampatotalefinale, @titolocomputo, @stampalogo, @stampanumeropagina, @iva, @indicaSoloTotale)";
                //    parametriquery = clonaDictionary(recordsuddivisionepdfsorg);
                //    parametriquery["idcomputo"] = idcomputodest; // sovrascrivo l'id con quello di destinazione
                //    parametriquery["idcomputo"] = idcomputodest; // sovrascrivo l'id con quello di destinazione
                //    inserisciRecord(connDest, query, parametriquery);
                //}

                //// Inserisco il record del suddivisionepdf destinazione
                //query = @"
                //        INSERT INTO suddivisionepdf (idcomputo, idsuddivisione)
                //        VALUES (@idcomputo, @idsuddivisione)";
                //parametriquery = new Dictionary<string, object>();
                //parametriquery["idcomputo"] = idcomputodest; // sovrascrivo l'id con quello di destinazione
                //parametriquery["idsuddivisione"] = idsuddivisionedest; // sovrascrivo l'id con quello di destinazione
                //long idsuddivisionepdf = inserisciRecord(connDest, query, parametriquery);


                //parametriquery = combinaDictionary(recordcomputo, new Dictionary<string, object>() {
                //    {"idcomputo", idcomputo}
                //});
                //parametriquery["idcomputo"] = idcomputo;

                connDest.Close();
            }
            connSorg.Close();
        }
    }

    public Dictionary<long, long> clonaSuddivisioni(long idcomputosorg, long idcomputodest, 
        MySqlConnection connSorg, MySqlConnection connDest,
        long? idsuddivisionepadreorigine, Dictionary<long, long> idsuddivisioneoldtonew) {

        string query;
        Dictionary<string, object> parametriquery;

        // ciclo esternamente sui suddivisione sorgente e copio i dati nella destinazione
        query = @"
            SELECT id, idcomputo, idpadre, descrizione, posizione, idsuddivisioneoriginaleclonato
            FROM suddivisione
            WHERE idcomputo = @idcomputosorg AND (
                    (@idsuddivisionepadreorigine is null AND idpadre is null) OR
                    idpadre = @idsuddivisionepadreorigine
                )";
        parametriquery = new Dictionary<string, object>() {
            {"idcomputosorg", idcomputosorg},
            {"idsuddivisionepadreorigine", idsuddivisionepadreorigine}
        };
        List<Dictionary<string, object>> recordssuddivisionesorg = leggiRecordsDaQuery(connSorg, query, parametriquery);

        //Dictionary<long, long?> mappaidsuddivisionesorgidsuddivisionepadresorg = new Dictionary<long, long?>();

        for (int i = 0; i < recordssuddivisionesorg.Count; i++) {
            Dictionary<string, object> recordsuddivisionesorg = recordssuddivisionesorg[i];

            //mappaidsuddivisionesorgidsuddivisionepadresorg.Add((long)recordsuddivisionesorg["id"], (long?)recordsuddivisionesorg["idpadre"]);

            long? idpadredestinazione;
            if (idsuddivisionepadreorigine != null)
                idpadredestinazione = idsuddivisioneoldtonew[(long)idsuddivisionepadreorigine];
            else
                idpadredestinazione = null;

            // Inserisco il record del suddivisione destinazione
            query = @"
                INSERT INTO suddivisione (idcomputo, idpadre, descrizione, posizione, idsuddivisioneoriginaleclonato)
                VALUES (@idcomputo, @idpadre, @descrizione, @posizione, @idsuddivisioneoriginaleclonato)";
            parametriquery = clonaDictionary(recordsuddivisionesorg);
            parametriquery["idcomputo"] = idcomputodest; // sovrascrivo l'id con quello di destinazione
            parametriquery["idpadre"] = idpadredestinazione; // sovrascrivo l'id con quello di destinazione
            long idsuddivisionedest = inserisciRecord(connDest, query, parametriquery);

            // (long)recordsuddivisionesorg["id"] contiene suddivisione.id del record di suddivisione di origine
            long idsuddivisioneorigine = (int)recordsuddivisionesorg["id"];
            long idsuddivisionedestinazione = idsuddivisionedest;
            idsuddivisioneoldtonew.Add(idsuddivisioneorigine, idsuddivisionedestinazione);

            clonaSuddivisioni(idcomputosorg, idcomputodest,
                connSorg, connDest,
                idsuddivisioneorigine, idsuddivisioneoldtonew);
        }

        return idsuddivisioneoldtonew;
    }

    public void clonaSuddivisioniPdf(MySqlConnection connDest,
        Dictionary<long, long> idcomputopdfsorgtodest, Dictionary<long, long> idsuddivisioneoldtonew) {

        string query;
        Dictionary<string, object> parametriquery;
        long idcomputosorg, idcomputodest, idsuddivisionesorg, idsuddivisionedest;

        foreach (var item1 in idcomputopdfsorgtodest) {
            idcomputosorg = item1.Key;
            idcomputodest = item1.Value;

            foreach (var item2 in idsuddivisioneoldtonew) {
                idsuddivisionesorg = item2.Key;
                idsuddivisionedest = item2.Value;

                // Inserisco il record del voce destinazione
                query = @"
                    INSERT INTO suddivisionepdf (idcomputopdf, idsuddivisione)
                    VALUES (@idcomputopdf, @idsuddivisione)";

                parametriquery = new Dictionary<string, object>();
                parametriquery["idcomputopdf"] = idcomputodest;
                parametriquery["idsuddivisione"] = idsuddivisionedest;

                inserisciRecord(connDest, query, parametriquery);
            }
        }

    }

    public Dictionary<long,long> clonaVoci(long idcomputosorg, long idcomputodest,
        MySqlConnection connSorg, MySqlConnection connDest,
        Dictionary<long, long> idsuddivisioneoldtonew) {

        Dictionary<long, long> idvocesorgtodest = new Dictionary<long, long>();

        string query;
        Dictionary<string, object> parametriquery;

        // ciclo esternamente sulle voce sorgente e copio i dati nella destinazione
        query = @"
            SELECT id, idcomputo, idsuddivisione, idvoceorigine, codice, titolo, descrizione, posizione
            FROM voce
            WHERE voce.idcomputo = @idcomputosorg;";
        parametriquery = new Dictionary<string, object>() {
            {"idcomputosorg", idcomputosorg}
        };
        List<Dictionary<string, object>> recordsvocesorg = leggiRecordsDaQuery(connSorg, query, parametriquery);
        long idvocesorg, idvocedest;
        long? idsuddivisionesorg, idsuddivisionedest;
        for (int j = 0; j < recordsvocesorg.Count; j++) {
            Dictionary<string, object> recordvocesorg = recordsvocesorg[j];

            idvocesorg = (int)recordvocesorg["id"];
            idsuddivisionesorg = recordvocesorg["idsuddivisione"] is DBNull ? null : (int?)recordvocesorg["idsuddivisione"];

            if (idsuddivisionesorg == null)
                idsuddivisionedest = null;
            else
                idsuddivisionedest = idsuddivisioneoldtonew[(long)idsuddivisionesorg];

            // Inserisco il record del voce destinazione
            query = @"
                INSERT INTO voce (idcomputo, idsuddivisione, idvoceorigine, codice, titolo, descrizione, posizione)
                VALUES (@idcomputo, @idsuddivisione, @idvoceorigine, @codice, @titolo, @descrizione, @posizione)";
            parametriquery = clonaDictionary(recordvocesorg);
            parametriquery["idcomputo"] = idcomputodest; // sovrascrivo l'id con quello di destinazione
            parametriquery["idsuddivisione"] = idsuddivisionedest; // sovrascrivo l'id con quello di destinazione
            // IDPADRE A DB L'HO VISTO SEMPRE NULL.
            // IN CASO COME LO COPIO?
            //parametriquery["idpadre"] = idpadrevocedest; // IDPADRE E' SEMPRE NULL
            idvocedest = inserisciRecord(connDest, query, parametriquery);

            idvocesorgtodest.Add(idvocesorg, idvocedest);

            // clono le misure
            clonaMisure(idvocesorg, idvocedest, connSorg, connDest);
        }

        return idvocesorgtodest;
    }

    public void clonaMisure(long idvocesorg, long idvocedest,
        MySqlConnection connSorg, MySqlConnection connDest) {

        string query;
        Dictionary<string, object> parametriquery;

        // ciclo esternamente sulle misure sorgente e copio i dati nella destinazione
        query = @"
            SELECT id, idvoce, idunitamisura, sottocodice, descrizione, 
                prezzounitario, totalemisura, totaleimporto,
                posizione, pathimmagine, nomeimmagine
            FROM misura
            WHERE idvoce = @idvocesorg";
        parametriquery = new Dictionary<string, object>() {
            {"idvocesorg", idvocesorg}
        };
        List<Dictionary<string, object>> recordsmisurasorg = leggiRecordsDaQuery(connSorg, query, parametriquery);
        for (int j = 0; j < recordsmisurasorg.Count; j++) {
            Dictionary<string, object> recordmisurasorg = recordsmisurasorg[j];

            // Inserisco il record del voce destinazione
            query = @"
                INSERT INTO misura (idvoce, idunitamisura, sottocodice, descrizione, 
                    prezzounitario, totalemisura, totaleimporto,
                    posizione, pathimmagine, nomeimmagine)
                VALUES (@idvoce, @idunitamisura, @sottocodice, @descrizione, 
                    @prezzounitario, @totalemisura, @totaleimporto,
                    @posizione, @pathimmagine, @nomeimmagine)";
            parametriquery = clonaDictionary(recordmisurasorg);
            parametriquery["idvoce"] = idvocedest; // sovrascrivo l'id con quello di destinazione
            inserisciRecord(connDest, query, parametriquery);
        }
    }

    [WebMethod] public void popupTabellaComputiInserimento_inserisci(
        int? idcliente,
        int? idcantiere,
        string tipo,
        string codice,
        string titolo,
        string descrizione,
        DateTime? datadiconsegna,
        string condizioniprimapagina,
        string condizioniultimapagina,
        string stato
        )
    {

        using (MySqlConnection conn = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            conn.Open();

            string query = @"
                INSERT INTO computo (idcliente, idcantiere, codice, titolo, descrizione, datadiconsegna, stato, tipo, condizioniprimapagina, condizioniultimapagina)
                VALUES (@idcliente, @idcantiere, @codice, @titolo, @descrizione, @datadiconsegna, @stato, @tipo, @condizioniprimapagina, @condizioniultimapagina)
            ";
            Dictionary<string, object> parametriquery = new Dictionary<string, object>() {
                {"idcliente", idcliente},
                {"idcantiere", idcantiere},
                {"tipo", tipo},
                {"codice", codice},
                {"titolo", titolo},
                {"descrizione", descrizione},
                {"datadiconsegna", datadiconsegna},
                {"condizioniprimapagina", condizioniprimapagina},
                {"condizioniultimapagina", condizioniultimapagina},
                {"stato", stato}
            };
            lanciaQuery(conn, query, parametriquery);

            conn.Close();
        }
    }
    [WebMethod] public void elencoComputi_popupTabellaComputiModifica_aggiorna(
        int? idcliente,
        int? idcantiere,
        string tipo,
        string codice,
        string titolo,
        string descrizione,
        DateTime? datadiconsegna,
        string condizioniprimapagina,
        string condizioniultimapagina,
        string stato,
        int idcomputo
        )
    {

        using (MySqlConnection conn = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            conn.Open();

            string query = @"
                UPDATE computo 
                SET idcliente = @idcliente, 
                    idcantiere = @idcantiere, 
                    tipo = @tipo, 
                    codice = @codice, 
                    titolo = @titolo, 
                    descrizione = @descrizione, 
                    datadiconsegna = @datadiconsegna, 
                    condizioniprimapagina = @condizioniprimapagina, 
                    condizioniultimapagina = @condizioniultimapagina, 
                    stato = @stato 
                WHERE computo.id = @idcomputo
            ";
            Dictionary<string, object> parametriquery = new Dictionary<string, object>() {
                {"idcliente", idcliente},
                {"idcantiere", idcantiere},
                {"tipo", tipo},
                {"codice", codice},
                {"titolo", titolo},
                {"descrizione", descrizione},
                {"datadiconsegna", datadiconsegna},
                {"condizioniprimapagina", condizioniprimapagina},
                {"condizioniultimapagina", condizioniultimapagina},
                {"stato", stato},
                {"idcomputo", idcomputo}
            };
            lanciaQuery(conn, query, parametriquery);

            conn.Close();
        }
    }
    [WebMethod] public void elencoComputi_popupTabellaComputiElimina_elimina(int idcomputo)
    {

        using (MySqlConnection conn = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            conn.Open();

            MySqlCommand command = conn.CreateCommand();
            command.CommandText = @"DELETE FROM computo WHERE id = @idcomputo";
            command.Parameters.AddWithValue("@idcomputo", idcomputo);
            command.ExecuteNonQuery();

            conn.Close();
        }
    }

    [WebMethod] public void C0001popupInserimentoVoceTemplate_salva(string codice, string nome)
    {

        using (MySqlConnection conn = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            conn.Open();

            MySqlCommand command = conn.CreateCommand();
            command.CommandText = @"INSERT INTO vocetemplate (codice, nome) VALUES (@codice, @nome)";
            command.Parameters.AddWithValue("@codice", codice);
            command.Parameters.AddWithValue("@nome", nome);
            command.ExecuteNonQuery();

            conn.Close();
        }
    }
    [WebMethod] public void C0001popupModificaVoceTemplate_salva(int idvocetemplate, string codice, string nome)
    {
        using (MySqlConnection conn = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            conn.Open();

            MySqlCommand command = conn.CreateCommand();
            command.CommandText = @"
                UPDATE vocetemplate
                SET
                    vocetemplate.codice = @codice,
                    vocetemplate.nome = @nome
                WHERE vocetemplate.id = @idvocetemplate";
            command.Parameters.AddWithValue("@codice", codice);
            command.Parameters.AddWithValue("@nome", nome);
            command.Parameters.AddWithValue("@idvocetemplate", idvocetemplate);
            command.ExecuteNonQuery();

            conn.Close();
        }
    }
    [WebMethod] public void C0001popupEliminaVoceTemplate_conferma(int idvocetemplate)
    {
        using (MySqlConnection conn = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString")))
        {
            conn.Open();

            MySqlCommand command = conn.CreateCommand();
            command.CommandText = @"DELETE vocetemplate FROM vocetemplate WHERE vocetemplate.id = @idvocetemplate";
            command.Parameters.AddWithValue("@idvocetemplate", idvocetemplate);
            command.ExecuteNonQuery();

            conn.Close();
        }
    }

}
