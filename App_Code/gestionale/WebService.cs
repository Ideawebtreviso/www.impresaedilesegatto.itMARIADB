using System;
using System.Collections.Generic;
using System.Collections;
//using System.Linq;
using System.Web;
using System.Web.Services;
using System.Text.RegularExpressions;

using MySqlConnector;
using Newtonsoft.Json;

// per l'upload
using System.IO;

// per il cookie di autenticazione
using System.Web.Security;
//connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");

//using System.ServiceModel.Web;
/// <summary>
/// Descrizione di riepilogo per WebService
/// </summary>

[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// Per consentire la chiamata di questo servizio Web dallo script utilizzando ASP.NET AJAX, rimuovere il commento dalla riga seguente. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    public WebService()
    {
        //Rimuovere il commento dalla riga seguente se si utilizzano componenti progettati 
        //InitializeComponent(); 
    }

    //[SoapHeader("Authentication", Required = true)]
    [WebMethod]
    public String sparaQueryReaderSemplice(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);

        // cerca pagesize da limit
        int pageSize = 10;
        if (query.Contains(" LIMIT ")) {
            String[] temp = query.Split(new string[] { " LIMIT " }, StringSplitOptions.None);
            pageSize = Convert.ToInt32(temp[1]);
        }

        return sparaQueryReaderPrivate(query, pageSize, 0, null, null, parametri);
    }

    [WebMethod]
    public String sparaQueryReader(string query, int pageSize, int pageNumber, object[] datiFiltri, String[] ordinamento, String parametriChiocciola)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);

        /*posso definire 1 filtro di ordinamento (su 1 campo alla volta) sulla tabella oppure definisco l'order by nella query con quanti campi voglio*/
        //ECCEZIONE su sparaQueryReader e su sparaQueryReaderTotale
        if (query.ToLower().Contains("order by"))
            if (query.ToLower().Contains("order by") && ordinamento != null && ordinamento.Length > 0)
            return "[{\"errore\":\"errore, non possono esistere contemporaneamente filtri order by nella query e come filtro da tabella\"}]";

        return sparaQueryReaderPrivate(query, pageSize, pageNumber, datiFiltri, ordinamento, parametriChiocciola);
    }

    [WebMethod]
    public String sparaQueryReaderAUTOCOMPLETAMENTO(string query, String parametriChiocciola)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);

        // cerca da limit e poi rimuovi limit
        int pageSize = 10;
        if (query.Contains(" LIMIT "))
        {
            String[] temp = query.Split(new string[] { " LIMIT " }, StringSplitOptions.None);
            pageSize = Convert.ToInt32(temp[1]);
        }

        return sparaQueryReaderPrivate(query, pageSize, 0, null, null, parametriChiocciola);
    }

    [WebMethod]
    public String sparaQueryReaderTotale(string nomeCampoSum, string query, int pageSize, int pageNumber, object[] datiFiltri, String[] ordinamento, string parametriExtra)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query).ToLower();

        //ECCEZIONE su sparaQueryReader e su sparaQueryReaderTotale
        if (query.ToLower().Contains("order by") && ordinamento != null && ordinamento.Length > 0)
            return "[{\"errore\":\"errore, non possono esistere contemporaneamente filtri order by nella query e come filtro da tabella\"}]";

        // nella query del totale tolgo la select e la sostituisco con la sola sum
        String[] temp = query.Split(new string[] { " from " }, StringSplitOptions.None);
        query = "SELECT SUM(" + nomeCampoSum + ") from " + temp[1];

        // nella query del totale devo ignorare eventuali group by e order by.
        if (query.Contains("order by"))
        {
            temp = query.Split(new string[] { "order by" }, StringSplitOptions.None);
            query = temp[0];
        }
        if (query.Contains("group by"))
        {
            temp = query.Split(new string[] { "group by" }, StringSplitOptions.None);
            query = temp[0];
        }

        return sparaQueryReaderPrivate(query, pageSize, pageNumber, datiFiltri, ordinamento, parametriExtra);
    }
/*
    [WebMethod]
    public String sparaQueryReaderTotaleSpecifica(string nomeCampoSum, string query, int pageSize, int pageNumber, object[] datiFiltri, String[] ordinamento, string parametriExtra)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query).ToLower();

        // nella query del totale tolgo la select e la sostituisco con la sola sum
        String[] temp = query.Split(new string[] { " from " }, StringSplitOptions.None);
        query = "SELECT SUM(" + nomeCampoSum + ") from " + temp[1];

        // nella query del totale devo ignorare eventuali group by e order by.
        if (query.Contains("order by")) {
            temp = query.Split(new string[] { "order by" }, StringSplitOptions.None);
            query = temp[0];
        }
        if (query.Contains("group by")) {
            temp = query.Split(new string[] { "group by" }, StringSplitOptions.None);
            query = temp[0];
        }

        return sparaQueryReaderPrivate(query, pageSize, pageNumber, datiFiltri, ordinamento, parametriExtra);
    }*/

    [WebMethod]
    public String sparaQueryReaderRigaSelezionata(string query, string parametriChiocciola, string parametriExtra)
    { //parametriChiocciola: "@idcomputo=22" ; parametriExtra: "@voce.id=2"
        query = IwebCrypter.iwebcsDecifraSQL(query);

        // ottengo la sottostringa della where dalla query
        String queryWhere = "";
        if (query.ToLower().Contains("where")) queryWhere = query.Substring(query.ToLower().IndexOf("where"));
        else queryWhere = "where 1=1";

        if (query.ToLower().Contains("group by")) queryWhere = queryWhere.Substring(0, queryWhere.ToLower().IndexOf("group by"));
        else if (query.ToLower().Contains("order by")) queryWhere = queryWhere.Substring(0, queryWhere.ToLower().IndexOf("order by"));

        // aggiungo i parametri alla where
        String[] listaParametri = parametriExtra.Split(new string[] { "&&&" }, StringSplitOptions.None);
        for (int i = 0; i < listaParametri.Length; i++)
        {
            String parametroTemp = listaParametri[i].Split('=')[0];
            String parametroTempSenzaChiocciola = parametroTemp.Substring(1);
            queryWhere += " AND " + parametroTempSenzaChiocciola + "=" + parametroTemp;
        }

        // rimpiazzo la vecchia where con quella nuova
        String nuovaQuery = query;
        if (query.ToLower().Contains("where")) nuovaQuery = query.Substring(0, query.ToLower().IndexOf("where"));
        nuovaQuery += queryWhere + " ";
        if (query.ToLower().Contains("group by")) 
            nuovaQuery += query.Substring(query.ToLower().IndexOf("group by"));
        else if (query.ToLower().Contains("order by")) 
            nuovaQuery += query.Substring(query.ToLower().IndexOf("order by"));

        //String jsonString = "[{\"errore\":\"" + nuovaQuery + "\"}]";
        //return jsonString;
        int pageSize = 1;
        int pageNumber = 0;
        object[] datiFiltri = null;
        String[] ordinamento = null;
        String jsonString = "[{\"errore\":\"errore\"}]";

        // 4 casi
        if (parametriExtra == "" && parametriChiocciola == "") parametriExtra = "";
        if (parametriExtra == "" && parametriChiocciola != "") parametriExtra = parametriChiocciola;
        //if (parametriExtra != "" && parametriChiocciola == "") parametriExtra = parametriExtra;
        if (parametriExtra != "" && parametriChiocciola != "") parametriExtra = parametriChiocciola + "&&&" + parametriExtra;

        jsonString = sparaQueryReaderPrivate(nuovaQuery, pageSize, pageNumber, datiFiltri, ordinamento, parametriExtra);
        return jsonString;
    }

    private String sparaQueryReaderPrivate(string query, int pageSize, int pageNumber, object[] datiFiltri, String[] ordinamento, String parametriExtra)
    {
        String jsonString = "[{\"errore\":\"errore\"}]";
        String queryESEGUITA = "";
        String queryCountESEGUITA = "";
        if (query.Contains("SELECT cantiere.id as 'cantiere.id',")) { log.clear(); } // log

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString"))) {

                connection.Open();
                MySqlCommand commandCount = connection.CreateCommand();
                MySqlCommand command = connection.CreateCommand();

                // spezzo la query in più parti
                String stringaSelect = "";
                if (query.ToLower().Contains("select"))
                    if (query.ToLower().Contains("from"))
                        stringaSelect = query.Substring(0, query.ToLower().IndexOf("from"));
                    else
                        stringaSelect = query;
                stringaSelect = stringaSelect.Trim();

                String stringaFrom = "";
                if (query.ToLower().Contains("from"))
                {
                    int charNum = query.ToLower().IndexOf("from");
                    if (query.ToLower().Contains("where"))
                        stringaFrom = query.Substring(charNum, query.ToLower().IndexOf("where") - charNum);
                    else if (query.ToLower().Contains("group by"))
                        stringaFrom = query.Substring(charNum, query.ToLower().IndexOf("group by") - charNum);
                    else if (query.ToLower().Contains("order by"))
                        stringaFrom = query.Substring(charNum, query.ToLower().IndexOf("order by") - charNum);
                    else if (query.ToLower().Contains("limit"))
                        stringaFrom = query.Substring(charNum, query.ToLower().IndexOf("limit") - charNum);
                    else
                        stringaFrom = query.Substring(charNum, query.Length - charNum);
                }
                stringaFrom = stringaFrom.Trim();

                String stringaWhere = "";
                if (query.ToLower().Contains("where"))
                {
                    int charNum = query.ToLower().IndexOf("where");
                    if (query.ToLower().Contains("group by"))
                        stringaWhere = query.Substring(charNum, query.ToLower().IndexOf("group by") - charNum);
                    else if (query.ToLower().Contains("order by"))
                        stringaWhere = query.Substring(charNum, query.ToLower().IndexOf("order by") - charNum);
                    else if (query.ToLower().Contains("limit"))
                        stringaWhere = query.Substring(charNum, query.ToLower().IndexOf("limit") - charNum);
                    else
                        stringaWhere = query.Substring(charNum, query.Length - charNum);
                }
                stringaWhere = stringaWhere.Trim();

                String stringaGroupBy = "";
                if (query.ToLower().Contains("group by"))
                {
                    int charNum = query.ToLower().IndexOf("group by");
                    if (query.ToLower().Contains("order by"))
                        stringaGroupBy = query.Substring(charNum, query.ToLower().IndexOf("order by") - charNum);
                    else if (query.ToLower().Contains("limit"))
                        stringaGroupBy = query.Substring(charNum, query.ToLower().IndexOf("limit") - charNum);
                    else
                        stringaGroupBy = query.Substring(charNum, query.Length - charNum);
                }
                stringaGroupBy = stringaGroupBy.Trim();

                String stringaOrderBy = "";
                // String stringaLimit = "";
                if (query.ToLower().Contains("order by"))
                {
                    int charNum = query.ToLower().IndexOf("order by");
                    if (query.ToLower().Contains("limit"))
                    {
                        stringaOrderBy = query.Substring(charNum, query.ToLower().IndexOf("limit") - charNum);
                        // charNum = query.ToLower().IndexOf("limit");
                        // stringaLimit = query.Substring(charNum, query.Length - charNum);
                    }
                    else
                        stringaOrderBy = query.Substring(charNum, query.Length - charNum);
                }
                stringaOrderBy = stringaOrderBy.Trim();


                // preparo la where per entrambe le query
                if (stringaWhere == "")
                    stringaWhere = "WHERE 1=1";
                stringaWhere += " ";
                String nomeCampoTemp = ""; String valoreCampoTemp = "";
                if (datiFiltri != null)
                {
                    for (int i = 0; i < datiFiltri.Length; ++i)
                    {
                        foreach (DictionaryEntry item in (IDictionary)datiFiltri[i])
                        {
                            String nome = (String)item.Key;
                            String valore = (String)item.Value;
                            // in js è stato creato: var filtro = { nomeCampo: "", valoreCampo: "", tipoFiltro: "" }; quindi viene rispettato l'ordine
                            if (nome == "nomeCampo")
                                nomeCampoTemp = valore;
                            if (nome == "valoreCampo")
                                valoreCampoTemp = valore;
                            // per ora prevedo solo il tipo data
                            if (nome == "tipoCampo")
                                if (valore == "data")
                                {
                                    valoreCampoTemp = valoreCampoTemp.Replace('/', '-'); // cambia eventuali slash in trattino
                                    valoreCampoTemp = valoreCampoTemp.Substring(6) + valoreCampoTemp.Substring(3, 2) + valoreCampoTemp.Substring(0, 2);
                                }
                            if (nome == "tipoFiltro")
                            {
                                // utilizzato "|||" come separatore per i valori multipli di select (usato qui e in mio-ajax.js)
                                String[] listaValoriUgualeAMolti = valoreCampoTemp.Split(new string[] { "|||" }, StringSplitOptions.None);

                                switch (valore)
                                {
                                    case "TestoSemplice":
                                        stringaWhere += " AND " + nomeCampoTemp + " like @" + nomeCampoTemp + "iweb" + i.ToString();
                                        valoreCampoTemp = "%" + valoreCampoTemp + "%";
                                        break;
                                    case "UgualeA":
                                        stringaWhere += " AND " + nomeCampoTemp + " in (@" + nomeCampoTemp + "iweb" + i.ToString() + ")";
                                        break;
                                    case "UgualeAMolti":
                                        // 1. preparo la stringa where
                                        stringaWhere += " AND " + nomeCampoTemp + " in ( ";
                                        for (int j = 0; j < listaValoriUgualeAMolti.Length; j++)
                                            stringaWhere += "@" + nomeCampoTemp + "iweb" + i.ToString() + j.ToString() + ",";
                                        // elimino l'ultimo carattere che è la virgola se ho aggiunto almeno un elemento, ed è uno spazio se ne ho aggiunti 0.
                                        stringaWhere = stringaWhere.Substring(0, stringaWhere.Length - 1);
                                        stringaWhere += ")";
                                        // 2. preparo i parametri
                                        for (int j = 0; j < listaValoriUgualeAMolti.Length; j++)
                                        {
                                            commandCount.Parameters.AddWithValue("@" + nomeCampoTemp + "iweb" + i.ToString() + j, listaValoriUgualeAMolti[j]);
                                            command.Parameters.AddWithValue("@" + nomeCampoTemp + "iweb" + i.ToString() + j, listaValoriUgualeAMolti[j]);
                                        }
                                        break;
                                    case "DiversoDa":
                                        stringaWhere += " AND " + nomeCampoTemp + " <> @" + nomeCampoTemp + "iweb" + i.ToString();
                                        break;
                                    case "MaggioreDi":
                                        stringaWhere += " AND " + nomeCampoTemp + " > @" + nomeCampoTemp + "iweb" + i.ToString();
                                        break;
                                    case "MaggioreUgualeDi":
                                        stringaWhere += " AND " + nomeCampoTemp + " >= @" + nomeCampoTemp + "iweb" + i.ToString();
                                        break;
                                    case "MinoreDi":
                                        stringaWhere += " AND " + nomeCampoTemp + " < @" + nomeCampoTemp + "iweb" + i.ToString();
                                        break;
                                    case "MinoreUgualeDi":
                                        stringaWhere += " AND " + nomeCampoTemp + " <= @" + nomeCampoTemp + "iweb" + i.ToString();
                                        break;
                                }
                                // in caso di "|||" i prossimi 2 parametri verranno aggiunti e non usati
                                commandCount.Parameters.AddWithValue("@" + nomeCampoTemp + "iweb" + i.ToString(), valoreCampoTemp);
                                command.Parameters.AddWithValue("@" + nomeCampoTemp + "iweb" + i.ToString(), valoreCampoTemp);
                            }
                        }
                    }
                }

                // preparo la ORDER BY
                if (ordinamento != null && ordinamento.Length > 0)
                    stringaOrderBy = "ORDER BY " + ordinamento[0] + " " + ordinamento[1];
                /*if (ordinamento != null && ordinamento.Length > 0)
                    if (stringaOrderBy == "")
                        stringaOrderBy = "ORDER BY " + ordinamento[0] + " " + ordinamento[1];
                    else
                        stringaOrderBy += "," + ordinamento[0] + " " + ordinamento[1];*/


                // conto gli elementi senza limit e offset
                // se la query originale ha un GROUP BY, accade che il COUNT(*) produce più record tanti quanti sono i raggruppamenti
                // QUINDI è necessario fare una queri innestata per contarli.
                if (stringaGroupBy == "")
                    commandCount.CommandText = "SELECT COUNT(*) as conteggio " + stringaFrom + " " + stringaWhere;
                else
                    commandCount.CommandText = "SELECT COUNT(*) FROM (SELECT COUNT(*) as conteggio " + stringaFrom + " " + stringaWhere + " " + stringaGroupBy + ") as tabella";

                // parametri con la chiocciola
                if (parametriExtra != "")
                {
                    String[] listaParametri = parametriExtra.Split(new string[] { "&&&" }, StringSplitOptions.None);
                    for (int i = 0; i < listaParametri.Length; i++)
                    {
                        String parametroTemp = listaParametri[i].Split('=')[0];
                        String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                        //String valoreTemp = listaParametri[i].Split('=')[1];
                        commandCount.Parameters.AddWithValue(parametroTemp, valoreTemp);
                    }
                }
                queryCountESEGUITA = commandCount.CommandText;
                if (query.Contains("SELECT cantiere.id as 'cantiere.id',")) {
                    log.log2("STO PER eseguiRE count query:\n");
                    log.log2(queryCountESEGUITA);
                    for (int i = 0; i < commandCount.Parameters.Count; i++) {
                        log.log2(commandCount.Parameters[i].ParameterName + "=" + commandCount.Parameters[i].Value + ";");
                    }
                    log.log2("\n");
                } // log
                int elementiContati = Convert.ToInt32(commandCount.ExecuteScalar());
                if (query.Contains("SELECT cantiere.id as 'cantiere.id',")) { log.log2("eseguita count query"); } // log

                // select con limit e offset
                command.CommandText = stringaSelect + " " + stringaFrom + " " + stringaWhere + " " + stringaGroupBy + " " + stringaOrderBy;
                command.CommandText += " LIMIT @limit OFFSET @offset";

                command.Parameters.AddWithValue("@limit", pageSize);
                command.Parameters.AddWithValue("@offset", (pageSize * pageNumber));

                // parametri con la chiocciola
                if (parametriExtra != "")
                {
                    String[] listaParametri = parametriExtra.Split(new string[] { "&&&" }, StringSplitOptions.None);
                    for (int i = 0; i < listaParametri.Length; i++)
                    {
                        String parametroTemp = listaParametri[i].Split('=')[0];
                        String valoreTemp = listaParametri[i].Replace(parametroTemp + "=", "");
                        //String valoreTemp = listaParametri[i].Split('=')[1];
                        if (!command.Parameters.Contains(parametroTemp)) // di test
                            command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                    }
                }

                // reader per leggere L'utente selezionato
                queryESEGUITA = command.CommandText;
                if (query.Contains("SELECT cantiere.id as 'cantiere.id',")) { log.log2("sto per eseguire la seconda query"); } // log
                MySqlDataReader reader = command.ExecuteReader();
                List<Dictionary<String, object>> tabella = new List<Dictionary<String, object>>();
                Dictionary<String, object> tempRiga;
                if (query.Contains("SELECT cantiere.id as 'cantiere.id',")) { log.log2("eseguita seconda query"); } // log

                // creo una prima riga con dati utili per la costruzione della tabella (header)
                tempRiga = new Dictionary<String, object>();
                tempRiga.Add("elementiContati", elementiContati);
                tabella.Add(tempRiga);

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
                if (query.Contains("SELECT cantiere.id as 'cantiere.id',")) { log.log2("fine query"); } // log

                connection.Close();
            }
        }
        catch (Exception ex)
        {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace + "\nQuery: " + queryESEGUITA + "\n Query Count: " + queryCountESEGUITA) + "}]";
        
        }

        return jsonString;
    }

    [WebMethod]
    public String sparaQueryInsertIdentity(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        String jsonString = "";

        try {
            Int32 Identity;

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
                        if (valoreTemp == "##INSERTDBNULL##")
                            command.Parameters.AddWithValue(parametroTemp, DBNull.Value); // aggiunto per la pagina stampa (campo iva, double, nullable)
                        else
                            command.Parameters.AddWithValue(parametroTemp, valoreTemp);
                    }
                }
                command.ExecuteNonQuery();

                // ottieni l'Identity dell'ultimo elemento inserito
                command.CommandText = "SELECT @@Identity";
                object objTemp = command.ExecuteScalar();
                Identity = objTemp == null ? 0 : Convert.ToInt32(objTemp);

                // If has last inserted id, add a parameter to hold it.
                //if (command.LastInsertedId != null)
                //    command.Parameters.AddWithValue(new MySqlParameter("newId", command.LastInsertedId));
                // Return the id of the new record. Convert from Int64 to Int32 (int).
                //return Convert.ToInt32(command.Parameters["@newId"].Value);
                connection.Close();
            }

            jsonString = "[{\"risultato\":" + Identity.ToString() + "}]";
        } catch (Exception ex) {
            jsonString = "[{\"errore\":" + JsonConvert.SerializeObject(ex.Message + "\n" + ex.StackTrace) + "}]";
        }

        return jsonString;
    }

    [WebMethod]
    public String sparaQueryInsert(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        return sparaQueryExecuteNonQuery(query, parametri);
    }

    [WebMethod]
    public String sparaQueryUpdate(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        return sparaQueryExecuteNonQuery(query, parametri);
    }

    [WebMethod]
    public String sparaQueryDelete(string query, string parametri)
    {
        query = IwebCrypter.iwebcsDecifraSQL(query);
        return sparaQueryExecuteNonQuery(query, parametri);
    }

    private String sparaQueryExecuteNonQuery(string query, string parametri)
    {
        String jsonString = "";

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString"))) {
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
    public String fileUpload(string nomeFile, String datiFile)
    {
        Random rnd = new Random();

        String[] temp = nomeFile.Split(new string[] { "." }, StringSplitOptions.None);
        string estensione = temp[temp.Length - 1];

        // del nomeFile che viene passato considero solo l'estensione
        nomeFile = DateTime.Now.Year.ToString()
                 + DateTime.Now.Month.ToString()
                 + DateTime.Now.Day.ToString()
                 + DateTime.Now.Hour.ToString()
                 + DateTime.Now.Minute.ToString()
                 + DateTime.Now.Second.ToString()
                 + DateTime.Now.Millisecond.ToString()
                 + "-"
                 + rnd.Next(1000).ToString()
                 + "." + estensione;

        String percorsoFile = System.Configuration.ConfigurationManager.AppSettings["percorsoUploadGestionaleScansioni"].ToString();
        percorsoFile += nomeFile;
        percorsoFile = Server.MapPath(percorsoFile);

        //String nomeFile = "D:\\Sites\\Temp\\" + Request["nomefile"];
        String contenuto = datiFile;
        byte[] originale = Convert.FromBase64String(contenuto);

        File.Delete(percorsoFile);
        using (Stream outputFile = File.Open(percorsoFile, FileMode.Create, FileAccess.ReadWrite)) {
            outputFile.Write(originale, 0, (int)originale.Length);
            outputFile.Close();
        }

        return nomeFile;
    }

    [WebMethod]
    public string chiamataPeriodicaAggiornamentoDatiPagina()
    {
        FormsIdentity fi = (FormsIdentity)Context.User.Identity;
        FormsAuthenticationTicket ticket = fi.Ticket;
        string idAnagraficaUtenteLoggato = Utility.getProprietaDaTicketAutenticazione(ticket, "IDAnagrafica");
        Dictionary<string, object> risultato = new Dictionary<string, object>();

        risultato.Add("test", idAnagraficaUtenteLoggato);

        return JsonConvert.SerializeObject(risultato);
    }

}