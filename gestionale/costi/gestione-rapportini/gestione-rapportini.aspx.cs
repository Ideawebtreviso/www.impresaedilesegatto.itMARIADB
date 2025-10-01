using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

using MySqlConnector;

// per il cookie di autenticazione
using System.Web.Security;
//connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");

public partial class gestionale_costi_gestione_rapportini_gestione_rapportini : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int giornoDellaSettimana = (int)DateTime.Today.DayOfWeek;
        if (ViewState["TextBoxDataDa"] == null) {
            ViewState["TextBoxDataDa"] = DateTime.Today.AddDays(0 - (giornoDellaSettimana + 6)).ToShortDateString();
            ViewState["TextBoxDataA"] = DateTime.Today.AddDays(0 - giornoDellaSettimana).ToShortDateString();
            TextBoxDataDa.Text = ViewState["TextBoxDataDa"].ToString();
            TextBoxDataA.Text = ViewState["TextBoxDataA"].ToString();
        }

    }



    protected System.Drawing.Color MostraSoloSePrimaRiga()
    {
        String day = Eval("Giorno", "{0:ddd dd/MM/yyyy HH:mm}");
        if (/*(day.StartsWith("sab")) ||*/ (day.StartsWith("dom")))
        {
            return System.Drawing.Color.Red;
        }
        return System.Drawing.Color.Black;
    }

    protected void RepeaterGiorniHeader_PreRender(object sender, EventArgs e)
    {

        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");
        connection.Open();

        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SELECT giorno FROM calendario WHERE giorno >= @giornoDa AND giorno <= @giornoA";
        command.Parameters.AddWithValue("@giornoDa", Convert.ToDateTime(TextBoxDataDa.Text));
        command.Parameters.AddWithValue("@giornoA", Convert.ToDateTime(TextBoxDataA.Text));

        //command.ExecuteNonQuery();
        DataSet dsServer = new DataSet();
        MySqlDataAdapter sda = new MySqlDataAdapter(command);
        sda.Fill(dsServer);
        RepeaterGiorniHeader.DataSource = dsServer;
        RepeaterGiorniHeader.DataBind();

        connection.Close();
    }

    protected void Repeater1_PreRender(object sender, EventArgs e)
    {
        Repeater repeater = (Repeater)sender;
        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");
        connection.Open();

        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SELECT prodotto.id, prodotto.descrizione "
                            + "FROM prodotto LEFT JOIN fornitore ON prodotto.idfornitore = fornitore.id "
                            + "WHERE fornitore.tipofornitore = 'Manodopera' AND prodotto.valido = true";

        DataSet dsServer = new DataSet();
        MySqlDataAdapter sda = new MySqlDataAdapter(command);
        sda.Fill(dsServer);
        repeater.DataSource = dsServer;
        repeater.DataBind();

        connection.Close();
    }
    protected void Repeater2_PreRender(object sender, EventArgs e)
    {
        Repeater repeater = (Repeater)sender;
        Label LabelIDProdotto = (Label)repeater.Parent.FindControl("LabelIDProdotto");

        Int32 idprodotto = LabelIDProdotto.Text == "" ? 0 : Convert.ToInt32(LabelIDProdotto.Text);
        DateTime dataDa = Convert.ToDateTime(TextBoxDataDa.Text);
        DateTime dataA = Convert.ToDateTime(TextBoxDataA.Text);

        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");
        connection.Open();
/*
        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SELECT costo.* "
                            + "FROM costo LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
                            + "WHERE idprodotto = @idprodotto AND datacosto >= @giornoDa AND datacosto <= @giornoA";
        command.Parameters.AddWithValue("@idprodotto", idprodotto);
        command.Parameters.AddWithValue("@giornoDa", dataDa);
        command.Parameters.AddWithValue("@giornoA", dataA);
*/
        MySqlCommand command = connection.CreateCommand();
        command.CommandText = "SELECT giorno FROM calendario WHERE giorno >= @giornoDa AND giorno <= @giornoA";
        command.Parameters.AddWithValue("@giornoDa", Convert.ToDateTime(TextBoxDataDa.Text));
        command.Parameters.AddWithValue("@giornoA", Convert.ToDateTime(TextBoxDataA.Text));

        //command.ExecuteNonQuery();
        DataSet dsServer = new DataSet();
        MySqlDataAdapter sda = new MySqlDataAdapter(command);
        sda.Fill(dsServer);
        repeater.DataSource = dsServer;
        repeater.DataBind();

        connection.Close();
    }
    protected void LabelIDProdotto_PreRender(object sender, EventArgs e)
    {
        Label LabelIDProdotto = (Label)sender;
        LabelIDProdotto.Text = ((Label)LabelIDProdotto.Parent.Parent.Parent.FindControl("LabelIDProdotto")).Text;

    }
    protected void Repeater3_PreRender(object sender, EventArgs e)
    {
        Repeater repeater = (Repeater)sender;
        Label LabelIDProdotto = (Label)repeater.Parent.FindControl("LabelIDProdotto");
        Label LabelGiorno = (Label)repeater.Parent.FindControl("LabelGiorno");

        Int32 idprodotto = LabelIDProdotto.Text == "" ? 0 : Convert.ToInt32(LabelIDProdotto.Text);
        DateTime giorno = Convert.ToDateTime(LabelGiorno.Text);

        MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString); 
        connection.ConnectionString = Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "ConnectionString");
        connection.Open();

        MySqlCommand command = connection.CreateCommand();
        //                    + "       costo.datacosto, costo.descrizione as 'costodescrizione', "
        command.CommandText = "SELECT costo.id, costo.quantita, costo.prezzo, "
                            + "       cantiere.descrizione as 'cantieredescrizione', cantiere.codice as 'cantierecodice', "
                            + "       unitadimisura.codice as 'unitadimisuracodice' "
                            + "FROM costo LEFT JOIN prodotto ON costo.idprodotto = prodotto.id "
                            + "           LEFT JOIN cantiere on costo.idcantiere = cantiere.id "
                            + "           LEFT JOIN unitadimisura on prodotto.idunitadimisura = unitadimisura.id "
                            + "WHERE idprodotto = @idprodotto AND datacosto = @datacosto";
        command.Parameters.AddWithValue("@idprodotto", idprodotto);
        command.Parameters.AddWithValue("@datacosto", giorno);

        //command.ExecuteNonQuery();
        DataSet dsServer = new DataSet();
        MySqlDataAdapter sda = new MySqlDataAdapter(command);
        sda.Fill(dsServer);
        repeater.DataSource = dsServer;
        repeater.DataBind();

        connection.Close();
    }

    protected void ButtonFiltra_Command(object sender, CommandEventArgs e)
    {
        String dataDaStringa = TextBoxDataDa.Text;
        String dataAStringa = TextBoxDataA.Text;
        // le date devono avere un valore
        if (dataDaStringa != "" && dataAStringa != ""){
            DateTime dataDa = Convert.ToDateTime(dataDaStringa);
            DateTime dataA = Convert.ToDateTime(dataAStringa);
            TimeSpan ts = dataA - dataDa;
            // la seconda data deve essere maggiore della prima
            if (ts.Days > 0) {
                if (ts.Days >= 32)
                    dataA = dataDa.AddDays(30); // mostro massimo 31 giorni
                TextBoxDataDa.Text = dataDa.ToShortDateString();
                TextBoxDataA.Text = dataA.ToShortDateString();
                ViewState["TextBoxDataDa"] = dataDa.ToShortDateString();
                ViewState["TextBoxDataA"] = dataA.ToShortDateString();
            } else {
                dataA = dataDa.AddDays(0); // se la seconda data è precedente alla prima, cambiala per mostrare solo il primo giorno di dataDa
                TextBoxDataDa.Text = dataDa.ToShortDateString();
                TextBoxDataA.Text = dataA.ToShortDateString();
                ViewState["TextBoxDataDa"] = dataDa.ToShortDateString();
                ViewState["TextBoxDataA"] = dataA.ToShortDateString();
            }
        }
    }

    // nel ciclo del repeater 3 per ogni ciclo:
    protected void LabelQuantitaOre_PreRender(object sender, EventArgs e)
    {
        Label LabelQuantitaOre = (Label)sender;
        Double quantitaora = LabelQuantitaOre.Text == "" ? 0 : Convert.ToDouble(LabelQuantitaOre.Text);

        Label LabelTotOre = (Label)LabelQuantitaOre.Parent.Parent.Parent.FindControl("LabelTotOre");
        Double qtaTotale = LabelTotOre.Text == "" ? 0 : Convert.ToDouble(LabelTotOre.Text);

        qtaTotale += quantitaora;

        if (qtaTotale > 0) {
            // di default il div tot ore non è visibile, però se almeno un ora è stata calcolata, il div diventa visibile
            Panel PanelTotOre = (Panel)LabelQuantitaOre.Parent.Parent.Parent.FindControl("repeaterCellaPanelTotOre");
            PanelTotOre.Visible = true;
            LabelTotOre.Text = qtaTotale.ToString();
        }
    }

    // terminato il repeater 3:
    protected void LabelUnitaDiMisuraTotale_PreRender(object sender, EventArgs e)
    {
        Label LabelUnitaDiMisuraTotale = (Label)sender;
        Repeater rp3 = (Repeater)LabelUnitaDiMisuraTotale.Parent.FindControl("Repeater3");
        Label temp = (Label)rp3.Items[0].FindControl("LabelUnitaDiMisura");
        LabelUnitaDiMisuraTotale.Text = temp.Text;
    }
}