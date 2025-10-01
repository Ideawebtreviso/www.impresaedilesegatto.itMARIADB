using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;

using MySqlConnector;
using Newtonsoft.Json;

/// <summary>
/// Descrizione di riepilogo per AlberoComputo
/// </summary>
public class AlberoComputo
{ 
    //public static Suddivisione generaAlberoSuddivisioni() {

    //}
    //public static DatiCompu
}

public class OpzioniStampa
{
    public int idComputo { get; set; }
    public DateTime dataDiStampa { get; set; }
    public bool stampaLogo { get; set; }
    public bool stampaPrezzi { get; set; }
    public bool stampaCopertina { get; set; }
    public bool stampaSuddivisioni { get; set; }
    public bool stampaMisure { get; set; }
    public bool stampaTotaleNelleSuddivisioni { get; set; }
    public bool stampaTotaleFinale { get; set; }
    public bool stampaNumeroPagina { get; set; }
    public string titolocomputo { get; set; }
    public object iva { get; set; } // iva è un double che può essere null
    //public Suddivisione suddPrimoLvDaStampare { get; set; }
    public List<int> suddPrimoLvDaStampare { get; set; }

    private OpzioniStampa() { 
    }
    public OpzioniStampa(int idStampa, string connectionString)
    {
        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = connectionString;

        connection.Open();
        MySqlDataReader reader;
        MySqlCommand command;
        command = connection.CreateCommand();
        command.CommandText = "SELECT * FROM computopdf WHERE id = @id";
        command.Parameters.AddWithValue("@id", idStampa);

        reader = command.ExecuteReader();
        while (reader.Read()) {
            this.idComputo = (int)reader["idcomputo"];
            this.dataDiStampa = Convert.ToDateTime(reader["dataora"]);
            this.stampaLogo = Convert.ToBoolean(reader["stampalogo"]);
            this.stampaPrezzi = Convert.ToBoolean(reader["stampaprezzi"]);
            this.stampaCopertina = Convert.ToBoolean(reader["stampacopertina"]);
            this.stampaSuddivisioni = Convert.ToBoolean(reader["stampasuddivisioni"]);
            this.stampaMisure = Convert.ToBoolean(reader["stampamisure"]);
            this.stampaTotaleNelleSuddivisioni = Convert.ToBoolean(reader["stampatotalenellesuddivisioni"]);
            this.stampaTotaleFinale = Convert.ToBoolean(reader["stampatotalefinale"]);
            this.stampaNumeroPagina = Convert.ToBoolean(reader["stampanumeropagina"]);
            this.titolocomputo = reader["titolocomputo"].ToString();
            this.iva = reader["iva"];
        }
        reader.Close();

        //suddPrimoLvDaStampare
        suddPrimoLvDaStampare = new List<int>();
        command = connection.CreateCommand();
        command.CommandText = "SELECT idsuddivisione FROM suddivisionepdf WHERE idcomputopdf = @idcomputopdf";
        command.Parameters.AddWithValue("@idcomputopdf", idStampa);

        reader = command.ExecuteReader();
        while (reader.Read()) {
            int idsuddivisione = Convert.ToInt32(reader["idsuddivisione"]);
            this.suddPrimoLvDaStampare.Add(idsuddivisione);
        }
        reader.Close();

        connection.Close();
    }
}

// metodo per tornare i dati accettando l'ID come parametro
// metodo per la creazione di SuddivisioneRoot = Suddivisione getSuddivisioneRoot(int IDComputo)
public class DatiComputo
{
    public int id { get; set; }
    public string codice { get; set; }
    public string titolo { get; set; }
    public string descrizione { get; set; }
    public DateTime dataConsegna { get; set; }
    public string stato { get; set; }
    public string tipo { get; set; }
    public string condizioniprimapagina { get; set; }
    public string condizioniultimapagina { get; set; }
    public string nominativoCliente { get; set; }
    public string indirizzoCliente { get; set; }
    public string cittaCliente { get; set; }
    public string provinciaCliente { get; set; }
    public string telefonoCliente { get; set; }
    public string emailCliente { get; set; }
    public string cfCliente { get; set; }
    public string pivaCliente { get; set; }

    private DatiComputo() { 
        
    }
    public DatiComputo(int idComputo, string connectionString)
    {
        MySqlConnection connection;
        MySqlCommand command;
        MySqlDataReader reader;

        connection = new MySqlConnection();
        connection.ConnectionString = connectionString;
        connection.Open();


        command = connection.CreateCommand();
        command.CommandText = "SELECT computo.codice as 'computo.codice', computo.titolo as 'computo.titolo', computo.descrizione as 'computo.descrizione', computo.datadiconsegna as 'computo.datadiconsegna', "
                            + "       computo.stato as 'computo.stato', computo.tipo as 'computo.tipo', computo.condizioniprimapagina as 'computo.condizioniprimapagina', computo.condizioniultimapagina as 'computo.condizioniultimapagina', "
                            + "       cliente.nominativo, cliente.indirizzo, cliente.citta, cliente.provincia, "
                            + "       cliente.telefono, cliente.email, cliente.cf, cliente.piva "
                            + "FROM computo LEFT JOIN cliente ON computo.idcliente = cliente.id "
                            + "WHERE computo.id = @idcomputo ";
        command.Parameters.AddWithValue("@idComputo", idComputo);

        reader = command.ExecuteReader();
        while (reader.Read()) {
            this.id = idComputo;
            this.codice = reader["computo.codice"].ToString();
            this.titolo = reader["computo.titolo"].ToString();
            this.descrizione = reader["computo.descrizione"].ToString();
            this.dataConsegna = Convert.ToDateTime(reader["computo.datadiconsegna"]);
            this.stato = reader["computo.stato"].ToString();
            this.tipo = reader["computo.tipo"].ToString();
            this.condizioniprimapagina = reader["computo.condizioniprimapagina"].ToString();
            this.condizioniultimapagina = reader["computo.condizioniultimapagina"].ToString();
            this.nominativoCliente = reader["nominativo"].ToString();
            this.indirizzoCliente = reader["indirizzo"].ToString();
            this.cittaCliente = reader["citta"].ToString();
            this.provinciaCliente = reader["provincia"].ToString();
            this.telefonoCliente = reader["telefono"].ToString();
            this.emailCliente = reader["email"].ToString();
            this.cfCliente = reader["cf"].ToString();
            this.pivaCliente = reader["piva"].ToString();
        }
        reader.Close();

    }
    /*private DatiComputo(int id, string codice, string titolo, string descrizione, DateTime dataConsegna, 
                        string stato, string tipo, string condizioniprimapagina, string condizioniultimapagina, 
                        string nominativoCliente, string indirizzoCliente, string cittaCliente, string provinciaCliente,
                        string telefonoCliente, string emailCliente, string cfCliente, string pivaCliente)
    {
        this.id = id;
        this.codice = codice;
        this.titolo = titolo;
        this.descrizione = descrizione;
        this.dataConsegna = dataConsegna;
        this.stato = stato;
        this.tipo = tipo;
        this.condizioniprimapagina = condizioniprimapagina;
        this.condizioniultimapagina = condizioniultimapagina;
        this.nominativoCliente = nominativoCliente;
        this.indirizzoCliente = indirizzoCliente;
        this.cittaCliente = cittaCliente;
        this.provinciaCliente = provinciaCliente;
        this.telefonoCliente = telefonoCliente;
        this.emailCliente = emailCliente;
        this.cfCliente = cfCliente;
        this.pivaCliente = pivaCliente;
    }*/
    //Other properties, methods, events...
}
public class Suddivisione
{
    public int id { get; set; }
    public object idPadre { get; set; }
    public string descrizione { get; set; }
    public int posizione { get; set; }
    public List<Voce> listaVoci { get; set; }
    public List<Suddivisione> figli { get; set; } /* suddivisioni figli */

    public Suddivisione() {
        listaVoci = new List<Voce>();
        figli = new List<Suddivisione>();
    }
    public static Suddivisione getSuddivisioneRoot(int idComputo, string connectionString)
    {

        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = connectionString;
        connection.Open();

        MySqlCommand command;
        MySqlDataReader reader;



        // ottengo la lista di suddivisioni
        command = connection.CreateCommand();
        command.CommandText = "SELECT * FROM suddivisione WHERE idcomputo = @idcomputo ORDER BY posizione";
        command.Parameters.AddWithValue("@idComputo", idComputo);

        // andrò a riempirla in un secondo momento
        List<Suddivisione> listaSuddivisioni = new List<Suddivisione>();
        reader = command.ExecuteReader();
        while (reader.Read()) {
            listaSuddivisioni.Add(new Suddivisione((int)reader["id"],
                                                        reader["idpadre"],
                                                        reader["descrizione"].ToString(),
                                                        (int)reader["posizione"]));
        }
        reader.Close();

        // nodo root
        Suddivisione nodoRoot = new Suddivisione(0, null, "nodo root", 0);

        // funzione che genera l'albero dati la lista di nodi e il nodo di root
        elaboraalbero(listaSuddivisioni, nodoRoot);


        // ho ottenuto le suddivisioni
        // per ogni suddivisione ottengo le voci
        for (int i = 0; i < listaSuddivisioni.Count; i++) {
            int idsuddivisione = listaSuddivisioni[i].id;

            MySqlCommand command2 = connection.CreateCommand();
            command2.CommandText = "SELECT * FROM voce WHERE idcomputo = @idcomputo && idsuddivisione = @idsuddivisione ORDER BY posizione";
            command2.Parameters.AddWithValue("@idcomputo", idComputo);
            command2.Parameters.AddWithValue("@idsuddivisione", idsuddivisione);

            List<Voce> listaVoci = new List<Voce>();
            MySqlDataReader reader2 = command2.ExecuteReader();
            while (reader2.Read()) {
                Voce voce = new Voce((int)reader2["id"],
                                     reader2["idvoceorigine"],
                                     reader2["codice"].ToString(),
                                     reader2["titolo"].ToString(),
                                     reader2["descrizione"].ToString(),
                                     (int)reader2["posizione"]);
                listaVoci.Add(voce);
            }
            reader2.Close();

            // aggiungo le voci alla suddivisione
            listaSuddivisioni[i].aggiungiVoci(listaVoci);
        }

        // ho ottenuto le voci
        // per ogni voce ottengo le misure
        for (int i = 0; i < listaSuddivisioni.Count; i++) {
            List<Voce> listaVoci = listaSuddivisioni[i].listaVoci;
            for (int j = 0; j < listaVoci.Count; j++) {
                int idVoce = listaVoci[j].id;

                // per ogni voce aggiungi le sue misure.
                MySqlCommand command3 = connection.CreateCommand();
                command3.CommandText = "SELECT misura.id as 'misura.id', misura.idunitamisura as 'misura.idunitamisura', unitadimisura.codice as 'unitadimisura.codice', "
                                     + "       misura.sottocodice as 'misura.sottocodice', misura.descrizione as 'misura.descrizione', "
                                     + "       misura.prezzounitario as 'misura.prezzounitario', misura.totalemisura as 'misura.totalemisura', misura.totaleimporto as 'misura.totaleimporto', "
                                     + "       misura.posizione as 'misura.posizione' "
                                     + "FROM misura LEFT JOIN unitadimisura ON misura.idunitamisura = unitadimisura.id WHERE idvoce = @idvoce "
                                     + "ORDER BY posizione";
                command3.Parameters.AddWithValue("@idvoce", idVoce);

                List<Misura> listaMisure = new List<Misura>();
                MySqlDataReader reader3 = command3.ExecuteReader();
                while (reader3.Read()) {
                    Misura misura = new Misura((int)reader3["misura.id"], (int)reader3["misura.idunitamisura"], reader3["unitadimisura.codice"].ToString(),
                                               reader3["misura.sottocodice"].ToString(), reader3["misura.descrizione"].ToString(),
                                               Convert.ToDouble(reader3["misura.prezzounitario"]), Convert.ToDouble(reader3["misura.totalemisura"]), Convert.ToDouble(reader3["misura.totaleimporto"]),
                                               (int)reader3["misura.posizione"]);
                    listaMisure.Add(misura);
                }
                reader3.Close();

                // aggiungi la voce con le sue misure associate
                listaVoci[j].aggiungiMisure(listaMisure);
            }
        }

        return nodoRoot;

    }
    private static void elaboraalbero(List<Suddivisione> nodiTutti, Suddivisione nodoRoot)
    {
        // itera su tutti.
        for (int i = 0; i < nodiTutti.Count; i++) {
            // per ogni nodo cerca il padre ed aggancia il nodo al padre (caso particolare col null che aggancia a root)
            Suddivisione nodoPadre = getNodoPadre(nodiTutti[i], nodiTutti);

            /*                if (nodoPadre == null) nodoRoot.figli.push(nodiTutti[i]); // sostituire la push
                            else nodoPadre.figli.push(nodiTutti[i]); // sostituire la push */
            if (nodoPadre == null) pushSullaPosizioneCorretta(nodoRoot, nodiTutti[i]);
            else pushSullaPosizioneCorretta(nodoPadre, nodiTutti[i]);
        }
    }

    // function getNodoPadre(nodo figlio, nodo[] tutti){
    public static Suddivisione getNodoPadre(Suddivisione nodoFiglio, List<Suddivisione> nodiTutti)
    {
        for (int i = 0; i < nodiTutti.Count; i++) {
            if (nodoFiglio.idPadre != DBNull.Value && nodiTutti[i].id == (int)nodoFiglio.idPadre) return nodiTutti[i];
        }
        return null;
    }

    private static void pushSullaPosizioneCorretta(Suddivisione nodopadre, Suddivisione nodofiglio)
    {
        int posizione = 0;
        if (nodopadre.figli != null)
            for (int i = 0; i < nodopadre.figli.Count; i++) {
                if (nodofiglio.posizione > nodopadre.figli[i].posizione)
                    posizione = i + 1;
            }
        nodopadre.figli.Insert(posizione, nodofiglio);
    }
    public Suddivisione(int id, object idPadre, string descrizione, int posizione)
    {
        this.id = id;
        this.idPadre = idPadre;
        this.descrizione = descrizione;
        this.posizione = posizione;
        this.figli = new List<Suddivisione>();
        this.listaVoci = new List<Voce>();
    }
    public void aggiungiVoci(List<Voce> listaVoci)
    {
        this.listaVoci = listaVoci;
    }
    //Other properties, methods, events...

    public static Double calcolaTotale(Suddivisione sudd)
    {
        Double totale = 0;
        foreach (Voce itemVoce in sudd.listaVoci)
            foreach (Misura itemMisura in itemVoce.listaMisure)
                totale += itemMisura.totaleimporto;
        return totale;
    }

    public static List<Suddivisione> getTutteLeSuddivisioniOrdinate(Suddivisione root) {
        List<Suddivisione> tutte = new List<Suddivisione>();
        tutte = ricorsioneSuiFigli(tutte, root);
        return tutte;
    }
    private static List<Suddivisione> ricorsioneSuiFigli(List<Suddivisione> tutte, Suddivisione corrente)
    {
        foreach (Suddivisione item in corrente.figli) tutte.Add(item);
        foreach(Suddivisione figlia in corrente.figli) ricorsioneSuiFigli(tutte, figlia);
        return tutte;
    }


    public static List<Voce> getTutteLeVociOrdinate(Suddivisione root) {
        List<Voce> tutte = new List<Voce>();
        tutte = ricorsioneSuiFigli(tutte, root);
        return tutte;
    }
    private static List<Voce> ricorsioneSuiFigli(List<Voce> tutte, Suddivisione corrente) {
        foreach (Voce item in corrente.listaVoci) tutte.Add(item);
        foreach(Suddivisione figlia in corrente.figli) ricorsioneSuiFigli(tutte, figlia);
        return tutte;
    }


    public bool isUltimoFiglio(Suddivisione suddDaComparare)
    {
        // return figli.Contains(suddDaComparare);
        return (figli.Count == 0 || figli[figli.Count - 1] == suddDaComparare);
    }

}
public class Voce
{
    public int id { get; set; }
    public object idvoceorigine { get; set; }
    public string codice { get; set; }
    public string titolo { get; set; }
    public string descrizione { get; set; }
    public int posizione { get; set; }
    public List<Misura> listaMisure { get; set; }

    public Voce() {
        listaMisure = new List<Misura>();
    }
    public Voce(int id, object idvoceorigine, string codice, string titolo, string descrizione, int posizione)
    {
        this.id = id;
        this.idvoceorigine = idvoceorigine;
        this.descrizione = descrizione;
        this.codice = codice;
        this.titolo = titolo;
        this.posizione = posizione;
    }
    public void aggiungiMisure(List<Misura> listaMisure)
    {
        this.listaMisure = listaMisure;
    }
    //Other properties, methods, events...
    public Double totaleVoci()
    {
        Double totale = 0;
        foreach (Misura item in listaMisure)
            totale += item.totaleimporto;
        return totale;
    }
}
public class Misura
{
    public int id { get; set; }
    public int idUnitaMisura { get; set; }
    public string nomeUnitaMisura { get; set; }
    public string sottocodice { get; set; }
    public string descrizione { get; set; }
    public double prezzounitario { get; set; }
    public double totalemisura { get; set; }
    public double totaleimporto { get; set; }
    public int posizione { get; set; }

    public Misura() { }
    public Misura(int id, int idUnitaMisura, string nomeUnitaMisura, 
        string sottocodice, string descrizione, 
        double prezzounitario, double totalemisura, double totaleimporto, 
        int posizione)
    {
        this.id = id;
        this.nomeUnitaMisura = nomeUnitaMisura;
        this.idUnitaMisura = idUnitaMisura;
        this.sottocodice = sottocodice;
        this.descrizione = descrizione;
        this.prezzounitario = prezzounitario;
        this.totalemisura = totalemisura;
        this.totaleimporto = totaleimporto;
        this.posizione = posizione;
    }
    //Other properties, methods, events...
}
