using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Web.Security;
using MySqlConnector;

public partial class login : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e)
    {
        Submit1.ToolTip = AppCode.GetDB.getDDBB(UserPass.Text);
    }

    protected void Logon_Click(object sender, EventArgs e)
    {
        String userData = "";

        //STRINGA DI CONNESSIONE
        using (MySqlConnection connection = new MySqlConnection(AppCode.GetDB.getDDBB(UserPass.Text)))
        {
            connection.Open();

            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "SELECT * FROM utente WHERE email = @email";
            command.Parameters.AddWithValue("@email", UserEmail.Text);

            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read()) {
                String password = reader["password"].ToString();
                if (password == UserPass.Text) {
                    String ruolo = (String)reader["ruolo"];
                    int IDUTENTE = (int)reader["ID"];
                    userData = "Email=[" + UserEmail.Text + "] ID=[" + IDUTENTE + "] Ruolo=[" + ruolo + "] ConnectionString=[" + AppCode.GetDB.getDDBB(UserPass.Text) + "] Password=[" + UserPass.Text + "]";
                    bool ispersistent = true;
                    Int32 timeout = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["timeoutInSecondiFormsAuthenticationTicket"]);
                    //  DateTime.Now.AddSeconds(timeout), // Durata
                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, // la versione
                      UserEmail.Text, // Questo è il nome del ticket
                      DateTime.Now,
                      DateTime.Now.AddSeconds(timeout), // Durata
                      ispersistent,
                      userData,
                      FormsAuthentication.FormsCookiePath);

                    // Encrypt the ticket.
                    string encTicket = FormsAuthentication.Encrypt(ticket);

                    // Create the cookie. FormsAuthentication.FormsCookieName il NAME è probabilmente quello definito nel WEB CONFIG
                    Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

                    // Redirect back to original URL.
                    Response.Redirect(FormsAuthentication.GetRedirectUrl(UserEmail.Text, ispersistent));
                } else {
                    Msg.Text = "Password errata.";
                }
            } else {
                Msg.Text = "Utente non presente.";
            }

            connection.Close();
        }
    }


    protected bool sonoInLocale() {
        String fullpathname = HttpContext.Current.Request.Url.Authority.ToLower();
        return fullpathname.Contains("localhost");
    }
}