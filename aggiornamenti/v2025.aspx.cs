using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MySqlConnector;

public partial class aggiornamenti_v2025 : System.Web.UI.Page
{
    public void aggiornamentiSpecifici(MySqlConnection connection, MySqlCommand command)
    {
        Utility utility = new Utility();


        // fix bug date:
        command = connection.CreateCommand();
        command.CommandText = @"UPDATE computo SET datadiconsegna = '2000-01-01 00:00:00' WHERE datadiconsegna = '0000-00-00 00:00:00'";
        command.ExecuteNonQuery();

        command = connection.CreateCommand();
        command.CommandText = @"UPDATE computo SET datadiconsegna = '2000-01-01 00:00:00' WHERE datadiconsegna = '0001-01-01 00:00:00'";
        command.ExecuteNonQuery();

        utility.RinominaColonna(connection, "computo", "datadiconsegna", "datadiconsegna", "DATETIME NULL AFTER idcliente");

        command = connection.CreateCommand();
        command.CommandText = @"UPDATE computo SET datadiconsegna = null WHERE datadiconsegna = '2000-01-01 00:00:00'";
        command.ExecuteNonQuery();


        // punto 2 del preventivo
        utility.AggiungiColonna(connection, "computo", "idcantiere", "INT AFTER idcliente");


        // punto 3
        command.CommandText = "SHOW TABLES LIKE 'vocetemplate'";
        if (command.ExecuteScalar() == null)
        {
            command = connection.CreateCommand();
            command.CommandText = @"
                CREATE TABLE IF NOT EXISTS vocetemplate (
                    id INT NOT NULL AUTO_INCREMENT,
                    datacreazione DATETIME,
                    utentecreazione INT,
                    ipcreazione VARCHAR(50),
                    datamodifica DATETIME,
                    utentemodifica INT,
                    ipmodifica VARCHAR(50),

                    codice VARCHAR(255),
                    nome TEXT,

                    PRIMARY KEY (id)
                ) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
            command.ExecuteNonQuery();

            utility.AggiungiIndice(connection, "vocetemplate", "codice");
        }
        utility.AggiungiColonna(connection, "misura", "idvocetemplate", "INT");
        utility.AggiungiColonna(connection, "voce", "idvocetemplate", "INT"); // per traccia quando inserisco una voce. Non ha effetto nel programma, lo teniamo solo per informazione accessoria di storico.


        // punto 4 (stampa pdf)
        utility.AggiungiColonna(connection, "computopdf", "indicaSoloTotale", "BOOLEAN NOT NULL DEFAULT FALSE");


        // punto 5 (gestione di indirizzo su cantiere)
        utility.AggiungiColonna(connection, "cantiere", "indirizzo", "VARCHAR(250) AFTER codice");


        // punto 6 (data inizio e fine su cantiere)
        utility.AggiungiColonna(connection, "cantiere", "cantdatainizio", "DATETIME AFTER indirizzo");
        utility.AggiungiColonna(connection, "cantiere", "cantdatafine", "DATETIME AFTER cantdatainizio");


        // punto 8 del preventivo
        utility.AggiungiColonna(connection, "costo", "qtaoremastrino", "DECIMAL(10,3) AFTER sconto2");



    } // chiudo il metodo aggiornamentiSpecifici


    protected void Page_Load(object sender, EventArgs e)
    {
        // Se la querystring è "aggiornamentoRapido=1" oppure "aggiornamentoRapido=true" eseguo un aggiornamento rapido (= solo traduzioni)
        String stringaAggiornamentoRapido = Request.QueryString["aggiornamentoRapido"];
        bool aggiornamentoRapido = false;
        if (stringaAggiornamentoRapido != null && stringaAggiornamentoRapido != "")
        {
            aggiornamentoRapido = stringaAggiornamentoRapido == "1" || stringaAggiornamentoRapido == "true";
        }

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.SonoInLocale() ? AppCode.GetDB.conn1locale : AppCode.GetDB.conn1))
            {
                connection.Open();

                MySqlCommand command;
                command = connection.CreateCommand();

                // aggiornamento della versione con varie query e passaggi specifici
                aggiornamentiSpecifici(connection, command);

                connection.Close();
            }

            Response.Write("ok");
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message + "\n" + ex.StackTrace);
            Response.Write(ex.Message + "\n" + ex.Source + "\n\n" + ex.StackTrace + "\n\n" + ex.InnerException);
        }

        try
        {
            using (MySqlConnection connection = new MySqlConnection(Utility.SonoInLocale() ? AppCode.GetDB.conn2locale : AppCode.GetDB.conn2))
            {
                connection.Open();

                MySqlCommand command;
                command = connection.CreateCommand();

                // aggiornamento della versione con varie query e passaggi specifici
                aggiornamentiSpecifici(connection, command);

                connection.Close();
            }

            Response.Write("ok");
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message + "\n" + ex.StackTrace);
            Response.Write(ex.Message + "\n" + ex.Source + "\n\n" + ex.StackTrace + "\n\n" + ex.InnerException);
        }

    }


}
