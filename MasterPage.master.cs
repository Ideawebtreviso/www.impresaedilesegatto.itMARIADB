using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;

public partial class MasterPageSegatto : System.Web.UI.MasterPage
{
    Boolean isIT = false;
    Boolean isEN = false;
    Boolean isFR = false;
    Boolean isDE = false;


    protected void Page_Load(object sender, EventArgs e)
    {
        HLCase.NavigateUrl =  getNavigazioneProdotti(163);
        HLAppartamenti.NavigateUrl = getNavigazioneProdotti(164);

        String url = Request.Url.AbsoluteUri.ToLower();


        if (url.Contains("/default.aspx"))
        {
            NavigaHome.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/stratigrafie-e-tecniche-costruttive"))
        {
            NavigaStratigrafie.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/progettazione-ufficio-tecnico/"))
        {
            NavigaProgettazioneUfficioTecnico.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/ristrutturare-casa-treviso.aspx"))
        {
            NavigaContatti.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/case-in-vendita-treviso/"))
        {
            NavigaCase.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/appartamenti-in-vendita-treviso/"))
        {
            NavigaAppartamenti.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/costruzioni-industriali/"))
        {
            NavigaCostruzioniIndustriali.Attributes["class"] = "menuSelezionato";
        }
        else if (url.Contains("/ristrutturazione-restauri/"))
        {
            HLRistrutturazioneerestauri.Attributes["class"] = "menuSelezionato";
        }





        else if (url.Contains("/storia-impresa-edile.aspx"))
        {
            HyperLinkStoria.Style.Add("color", "white");
        }
        else if (url.Contains("/referenze-impresa-edile/"))
        {
            HyperLinkReferenze.Style.Add("color", "white");
        }

        //ImgItaliano.Visible = false;
        //ImgInglese.Visible = false;
        //ImgFrancese.Visible = false;
        //ImgTedesco.Visible = false;

        //IT
        //if (GetLanguage.Get(Request.Url.AbsoluteUri)==Pagina.IT)
        //{
        //    HomeLink.Text = "HomePage";
        //    AziendaLink.Text = "L'Azienda";
        //    ProdottiLink.Text = "Prodotti";
        //    SettoriLink.Text = "Settori di Utilizzo";
        //    DoveLink.Text = "Dove Siamo";
        //    ContattiLink.Text = "Contatti";

        //    HomeLink.NavigateUrl = "~/";
        //    AziendaLink.NavigateUrl = "#";
        //    ProdottiLink.NavigateUrl = "#";
        //    SettoriLink.NavigateUrl = "#";
        //    DoveLink.NavigateUrl = "#";
        //    ContattiLink.NavigateUrl = "~/Contatti.aspx";

        //    //ImgItaliano.Visible = true;
        //}
        ////EN
        //else if (GetLanguage.Get(Request.Url.AbsoluteUri) == Pagina.EN)
        //{
        //    HomeLink.Text = "HomePage";
        //    AziendaLink.Text = "The Company";
        //    ProdottiLink.Text = "Products";
        //    SettoriLink.Text = "Sectors";
        //    DoveLink.Text = "Where we are";
        //    ContattiLink.Text = "Contacts";

        //    HomeLink.NavigateUrl = "~" + GetLanguage.PathEN;
        //    AziendaLink.NavigateUrl = "#";
        //    ProdottiLink.NavigateUrl = "#";
        //    SettoriLink.NavigateUrl = "#";
        //    DoveLink.NavigateUrl = "#";
        //    ContattiLink.NavigateUrl = "#";

        //    //ImgInglese.Visible = true;
        //}
        ////FR
        //else if (GetLanguage.Get(Request.Url.AbsoluteUri) == Pagina.FR)
        //{
        //    HomeLink.Text = "HomePage";
        //    AziendaLink.Text = "Enterprise";
        //    ProdottiLink.Text = "Produits";
        //    SettoriLink.Text = "Secteurs";
        //    DoveLink.Text = "Ous nous sommes";
        //    ContattiLink.Text = "Contact";

        //    HomeLink.NavigateUrl = "~" + GetLanguage.PathFR;
        //    AziendaLink.NavigateUrl = "#";
        //    ProdottiLink.NavigateUrl = "#";
        //    SettoriLink.NavigateUrl = "#";
        //    DoveLink.NavigateUrl = "#";
        //    ContattiLink.NavigateUrl = "#";

        //    //ImgFrancese.Visible = true;
        //}
        ////DE
        //else if (GetLanguage.Get(Request.Url.AbsoluteUri) == Pagina.DE)
        //{
        //    HomeLink.Text = "HomePage";
        //    AziendaLink.Text = "Firma";
        //    ProdottiLink.Text = "Produkte";
        //    SettoriLink.Text = "Branchen";
        //    DoveLink.Text = "Wir Sind";
        //    ContattiLink.Text = "Kontakt";

        //    HomeLink.NavigateUrl = "~" + GetLanguage.PathDE;
        //    AziendaLink.NavigateUrl = "#";
        //    ProdottiLink.NavigateUrl = "#";
        //    SettoriLink.NavigateUrl = "#";
        //    DoveLink.NavigateUrl = "#";
        //    ContattiLink.NavigateUrl = "#";

        //    //ImgTedesco.Visible = true;
        //}

        if (url.Contains("/default.aspx"))
        {
            PanelGalleria.Visible = true;
            DIVOfferte.Visible = true;
            HeaderSub.Visible = true;
        }
        else
        {
            PanelGalleria.Visible = false;
            DIVOfferte.Visible = false;
            HeaderSub.Visible = false;
        }

        // Verifica di dispositivo mobile
        if (Request.Headers["User-Agent"] != null &&
            Request.Browser != null &&
            Request.UserAgent != null)
        {
            if ((Request.Browser["IsMobileDevice"] == "true" ||
                Request.Browser["BlackBerry"] == "true" || Request.UserAgent.ToUpper().Contains("MIDP") ||
                Request.UserAgent.ToUpper().Contains("CLDC") ||
                Request.UserAgent.ToLower().Contains("iphone") ||
                Request.UserAgent.ToLower().Contains("ipad") ||
                Request.UserAgent.ToLower().Contains("android")))
            {
                PannelloMain.Style.Add("width", "1200px");
                PannelloMain.Style.Add("padding-left", "20px");
                PannelloMain.Style.Add("padding-right", "20px");
                pannellologo.Style.Add("width", "280px;");
                
            }
        }
        

        QuantiAnnidiEsperienza.Text = (DateTime.Now.Year - 1971).ToString();

        using (OleDbConnection conn = new
            OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT COUNT (*) FROM CMRC_Products WHERE Status = 'Valido'";
            OleDbDataReader read = cmd.ExecuteReader();
            if (read.Read())
            {
                TotaleUnitaAbitativeinVendita.Text = read[0].ToString();
            }
            read.Close();
            conn.Close();
        }
    }

    protected String getNavigazioneProdotti(int CategoryID)
    {
        String navigateurl = "";

        //LINK DI NAVIGAZIONE PER PRODOTTO CATEGORIA
        using (OleDbConnection conn = new
            OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = conn.CreateCommand();
            //if (isIT)
            cmd.CommandText = "SELECT CMRC_Categories.pathCategoria as PathCategoria, CMRC_Products.percorso as Percorso, CMRC_Products.ProductID as ProductID FROM CMRC_Categories INNER JOIN CMRC_Products ON CMRC_Categories.CategoryID = CMRC_Products.CategoryID WHERE CMRC_Products.ProductID = (SELECT TOP 1 ProductID FROM CMRC_Products WHERE CategoryID = " + CategoryID + " AND STATUS = 'Valido' AND VENDUTO = false ORDER BY POSIZIONE) AND CMRC_Products.CategoryID = " + CategoryID ;
            //else if (isEN)
            //    cmd.CommandText = "SELECT CMRC_Categories.pathCategoria_EN as PathCategoria, CMRC_Categories.fileCatalogoCategoria_EN as FileCatalogoCategoria FROM CMRC_Categories INNER JOIN CMRC_Products ON CMRC_Categories.CategoryID = CMRC_Products.CategoryID WHERE CMRC_Products.ProductID = (SELECT MAX(ProductID) FROM CMRC_Products) ";
            //else if (isFR)
            //    cmd.CommandText = "SELECT CMRC_Categories.pathCategoria_FR as PathCategoria, CMRC_Categories.fileCatalogoCategoria_FR as FileCatalogoCategoria FROM CMRC_Categories INNER JOIN CMRC_Products ON CMRC_Categories.CategoryID = CMRC_Products.CategoryID WHERE CMRC_Products.ProductID = (SELECT MAX(ProductID) FROM CMRC_Products)";
            //else if (isDE)
            //    cmd.CommandText = "SELECT CMRC_Categories.pathCategoria_DE as PathCategoria, CMRC_Categories.fileCatalogoCategoria_DE as FileCatalogoCategoria FROM CMRC_Categories INNER JOIN CMRC_Products ON CMRC_Categories.CategoryID = CMRC_Products.CategoryID WHERE CMRC_Products.ProductID = (SELECT MAX(ProductID) FROM CMRC_Products)";
            OleDbDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                int ProductID = Int32.Parse(reader["ProductID"].ToString());
                navigateurl = "~/" + reader["PathCategoria"].ToString() + reader["Percorso"].ToString() + ".aspx"+"?ProductID="+ProductID+"&CategoryID="+CategoryID;
            }
            reader.Close();
            conn.Close();
        }
        return navigateurl;
    }
}