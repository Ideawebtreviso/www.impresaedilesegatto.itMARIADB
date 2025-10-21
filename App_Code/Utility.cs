using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Data.OleDb;

using MySqlConnector;

/// <summary>
/// Descrizione di riepilogo per Utility
/// </summary>
public class Utility
{
    protected static string BR_MAIL = Environment.NewLine + "\r\n";



	public Utility()
	{
		//
		// TODO: aggiungere qui la logica del costruttore
		//
	}

    public static String getProprietaDaTicketAutenticazione(FormsAuthenticationTicket ticket, String nomeProprieta) {
        int begin = ticket.UserData.IndexOf(nomeProprieta) + nomeProprieta.Length + 2;
        int end = ticket.UserData.IndexOf("]", begin);
        string value = ticket.UserData.Substring(begin, end - begin);
        return value;
    }
    // per ottenere la lista di parametri del ticket
    // string[] listaParametri = Utility.getNomiProprietaDaTicketAutenticazione(ticket);
    // Label.Text = string.Join(", ",listaParametri); // -> per trasformare l'array in stringa
    public static string[] getNomiProprietaDaTicketAutenticazione(FormsAuthenticationTicket ticket)
    {
        string[] listaParametri = ticket.UserData.Remove(ticket.UserData.Length - 1).Split(']');
        for (int i = 0; i < listaParametri.Length; i++) {
            listaParametri[i] = listaParametri[i].Split(new string[] { "=[" }, StringSplitOptions.None)[0];
        }
        return listaParametri;
    }



    // METODI SOSTITUTIVI ALLE STORED PROCEDURE:
    // AggiungiColonna(connection, "anagrafica", "idtest", "INT AFTER ipmodifica");
    // RimuoviColonna(connection, "anagrafica", "idtest");
    // AggiungiIndice(connection, "anagrafica", "idtest");
    // AggiungiIndiceTesto(connection, "anagrafica", "idtest");
    // AggiungiIndiceUnico(connection, "anagrafica", "idtest");
    // RimuoviIndice(connection, "anagrafica", "idtest");
    // EsisteColonna(connection, "anagrafica", "idtest");
    // RinominaColonna(connection, "anagrafica", "idtest", "idtestnuovo", "INT AFTER ipmodifica");
    /*
    // COLONNE:
    SHOW COLUMNS FROM anagrafica like 'idtest';
    ALTER TABLE anagrafica ADD idtest INT AFTER idcliente;
    ALTER TABLE anagrafica DROP COLUMN idtest;

    // INDICI:
    SHOW INDEX FROM anagrafica WHERE key_name = 'idtest';
    CREATE INDEX idx_idtest ON anagrafica (idtest);
    CREATE FULLTEXT INDEX idx_idtest_fulltext ON anagrafica (idtest);
    CREATE UNIQUE INDEX idx_idtest_unique ON anagrafica (idtest);
    ALTER TABLE anagrafica DROP INDEX idtest;
    */
    // AggiungiColonna(connection, "anagrafica", "idtest", "INT AFTER ipmodifica");
    public void AggiungiColonna(MySqlConnection connection, string given_table, string given_column, string given_extra)
    {
        MySqlCommand command = connection.CreateCommand();

        command.CommandText = "SHOW COLUMNS FROM " + given_table + " LIKE '" + given_column + "'";
        if (command.ExecuteScalar() == null)
        {
            command = connection.CreateCommand();
            command.CommandTimeout = 60 * 20;
            command.CommandText = @"ALTER TABLE " + given_table + " ADD " + given_column + " " + given_extra;
            command.ExecuteNonQuery();
        }
    }
    // RimuoviColonna(connection, "anagrafica", "idtest");
    public void RimuoviColonna(MySqlConnection connection, string given_table, string given_column)
    {
        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SHOW COLUMNS FROM " + given_table + " LIKE '" + given_column + "'";
        if (command.ExecuteScalar() != null)
        {
            command = connection.CreateCommand();
            command.CommandText = @"ALTER TABLE " + given_table + " DROP COLUMN " + given_column;
            command.ExecuteNonQuery();
        }
    }

    // AggiungiIndice(connection, "anagrafica", "idtest");
    public void AggiungiIndice(MySqlConnection connection, string given_table, string given_column)
    {
        MySqlCommand command = connection.CreateCommand();

        command.CommandText = "SHOW INDEX FROM " + given_table + " WHERE key_name = '" + given_column + "'";
        if (command.ExecuteScalar() == null)
        {
            command = connection.CreateCommand();
            command.CommandTimeout = 60 * 20;
            command.CommandText = @"CREATE INDEX " + given_column + " ON " + given_table + "(" + given_column + ")";
            command.ExecuteNonQuery();
        }
    }
    // AggiungiIndiceTesto(connection, "anagrafica", "idtest");
    public void AggiungiIndiceTesto(MySqlConnection connection, string given_table, string given_column)
    {
        MySqlCommand command = connection.CreateCommand();
        command.CommandTimeout = 60 * 20;
        command.CommandText = "SHOW INDEX FROM " + given_table + " WHERE key_name = '" + given_column + "'";
        if (command.ExecuteScalar() == null)
        {
            command = connection.CreateCommand();
            command.CommandText = @"CREATE FULLTEXT INDEX " + given_column + " ON " + given_table + "(" + given_column + ")";
            command.ExecuteNonQuery();
        }
    }
    // AggiungiIndiceUnico(connection, "anagrafica", "idtest");
    public void AggiungiIndiceUnico(MySqlConnection connection, string given_table, string given_column)
    {
        MySqlCommand command = connection.CreateCommand();
        command.CommandTimeout = 60 * 20;
        command.CommandText = "SHOW INDEX FROM " + given_table + " WHERE key_name = '" + given_column + "'";
        if (command.ExecuteScalar() == null)
        {
            command = connection.CreateCommand();
            command.CommandText = @"CREATE UNIQUE INDEX " + given_column + " ON " + given_table + "(" + given_column + ")";
            command.ExecuteNonQuery();
        }
    }
    // RimuoviIndice(connection, "anagrafica", "idtest");
    public void RimuoviIndice(MySqlConnection connection, string given_table, string given_column)
    {
        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SHOW INDEX FROM " + given_table + " WHERE key_name = '" + given_column + "'";
        if (command.ExecuteScalar() != null)
        {
            command = connection.CreateCommand();
            command.CommandText = @"ALTER TABLE " + given_table + " DROP INDEX " + given_column + "";
            command.ExecuteNonQuery();
        }
    }

    // EsisteColonna(connection, "anagrafica", "idtest");
    public bool EsisteColonna(MySqlConnection connection, string given_table, string given_column)
    {
        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SHOW COLUMNS FROM " + given_table + " like '" + given_column + "'";
        return command.ExecuteScalar() == null ? false : true;
    }


    // RinominaColonna(connection, "anagrafica", "idtest", "idtestnuovo", "INT AFTER ipmodifica");
    public void RinominaColonna(MySqlConnection connection, string given_table,
     string nomeColonnaPrimaDiModifica, string nomeColonnaDopoDiModifica, string tipocampo)
    {
        MySqlCommand command = connection.CreateCommand();

        bool esisteNomeColonnaPrimaDiModifica;
        try
        {
            command = connection.CreateCommand();
            command.CommandText = "SELECT `" + nomeColonnaPrimaDiModifica + "` FROM " + given_table;
            object valore = command.ExecuteScalar();
            esisteNomeColonnaPrimaDiModifica = true;
        }
        catch
        {
            esisteNomeColonnaPrimaDiModifica = false;
        }
        if (esisteNomeColonnaPrimaDiModifica == true)
        {
            command = connection.CreateCommand();
            command.CommandTimeout = 360;
            command.CommandText = "ALTER TABLE " + given_table + " CHANGE " + nomeColonnaPrimaDiModifica + " " + nomeColonnaDopoDiModifica + " " + tipocampo;
            //command.CommandText = @"RENAME TABLE `" + nomeColonnaPrimaDiModifica + "` TO `" + nomeColonnaDopoDiModifica + "`";
            command.ExecuteNonQuery();
        }
    }

}