using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

using System.IO;
using MySqlConnector;

// per il cookie di autenticazione usato in segatto
using System.Web.Security;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        sviluppo.Visible = sonoInLocale();
        //sviluppo.Visible = true;

        caricaClasseContenitore();
        if (!IsPostBack) {
            String urr = Request.Url.ToString().ToLower();
            if ((urr.EndsWith(".it")) || (urr.EndsWith(".it/"))) {
                //annunciinvetrina.Visible= true;
            }

            String percorsoFilePDF = System.Configuration.ConfigurationManager.AppSettings["percorsoUploadPDFGestionale"].ToString();
            //percorsoFilePDF = Server.MapPath(percorsoFilePDF);
            LiteralPercorsoUploadPDFGestionale.Text = "/" + percorsoFilePDF;

            String percorsoFileImmagini = System.Configuration.ConfigurationManager.AppSettings["percorsoUploadImmaginiGestionale"].ToString();
            //percorsoFileImmagini = Server.MapPath(percorsoFileImmagini);
            LiteralPercorsoUploadImmaginiGestionale.Text = "/" + percorsoFileImmagini;

            //String fullpathname = Request.Url.AbsoluteUri.ToLower();
            //PanelMaster.CssClass = Request.Url.AbsoluteUri.ToLower().Contains("localhost") == true ? "Locale" : "Server";
        }

        FormsIdentity fi = (FormsIdentity)Context.User.Identity;
        FormsAuthenticationTicket ticket = fi.Ticket;
        string a = Utility.getProprietaDaTicketAutenticazione(ticket, "IDUTENTE");

        if (Utility.getProprietaDaTicketAutenticazione(((FormsIdentity)Context.User.Identity).Ticket, "Password") == "gummy") {
            LiteralExtraStyle.Text = @"";
        } else {
            LiteralExtraStyle.Text = @"
                <style>
                    form > div.contenitoreMenu_a_2livelli  {
                        background-color: #F00; /*rgb(198, 207, 218);*/
                        color: rgb(43, 0, 0); /*rgb(43, 54, 67);*/
                        font-weight:bold;
                    }

                    form > div.contenitoreMenu_a_2livelli * {
                        background-color: #F00; /*rgb(198, 207, 218);*/
                        color: rgb(43, 0, 0); /*rgb(43, 54, 67);*/
                    }

                    form > div.contenitoreMenu_a_2livelli > div > ul > li > ul > li > a {
                        background-color: #E00 !important; /*rgb(43, 54, 67);*/
                        color: rgb(198, 207, 218);
                    }

                    form > div.contenitoreMenu_a_2livelli > div > ul > li:hover > a {
                        background-color: #F00 !important; /*rgb(43, 54, 67);*/
                        color: rgb(198, 207, 218);
                    }
                </style>";
        }
    }

    //protected Boolean sonoInLocale()
    //{
    //    String fullpathname = Request.Url.AbsoluteUri.ToLower();
    //    return fullpathname.Contains("localhost");
    //}
    protected bool sonoInLocale() {
        String fullpathname = HttpContext.Current.Request.Url.Authority.ToLower();
        return fullpathname.Contains("localhost");
    }

    protected void caricaClasseContenitore() { /* nota: tutti i file aspx devono avere nomi diversi */
        TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
        String temp = Request.Url.ToString();
        temp = temp.Split('/')[temp.Split('/').Length - 1].Split('?')[0].Replace(".aspx", "");
        temp = textInfo.ToTitleCase(temp).Replace("-", "");
        contenitorePaginaAspx.Attributes.Add("class", "contenitorePaginaAspx contenitorePaginaAspx_" + temp);
    }

    protected void ButtonAccedi_Command(object sender, CommandEventArgs e)
    {
        Response.Redirect("/sospensione.aspx", true);
    }


    protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        // Al log out cancello i PDF:
        String percorsofile = Server.MapPath("~/" + System.Configuration.ConfigurationManager.AppSettings["percorsoUploadPDFGestionale"].ToString());
        string[] filePaths = Directory.GetFiles(percorsofile);

        for (int i = 0; i < filePaths.Length; i++) {
            String file = filePaths[i];
            File.Delete(file);
        }
    }

}
