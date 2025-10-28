using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

//using System.Data.OleDb;
using MySqlConnector;

public partial class gestionale_accedi : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Logon_Click(object sender, EventArgs e)
    {
        String userData = "";

        //using (MySqlConnection connection = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringMySQL"].ConnectionString))
        string connectionString = Utility.SonoInLocale() ? AppCode.GetDB.conn1locale : AppCode.GetDB.conn1; // questa?
        using (MySqlConnection connection = new MySqlConnection(connectionString))
        {
            connection.Open();

            MySqlCommand command = connection.CreateCommand();
            command.CommandText = "SELECT * FROM utente WHERE email = @email";
            command.Parameters.AddWithValue("@email", UserEmail.Text);

            //command.Parameters.AddWithValue(parametroTemp, valoreTemp);
            //command.ExecuteNonQuery();
            // test@test.it
            MySqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                String password = reader["password"].ToString();
                if (password == UserPass.Text)
                {
                    String ruolo = (String)reader["ruolo"];
                    int IDUTENTE = (int)reader["ID"];
                    userData = "Email=[" + UserEmail.Text + "] ID=[" + IDUTENTE + "] Ruolo=[" + ruolo + "]";

                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1, // la versione
                      UserEmail.Text, // Questo è il nome del ticket
                      DateTime.Now,
                      DateTime.Now.AddMinutes(30), // Durata
                      Persist.Checked,
                      userData,
                      FormsAuthentication.FormsCookiePath);

                    // Encrypt the ticket.
                    string encTicket = FormsAuthentication.Encrypt(ticket);

                    // Create the cookie. FormsAuthentication.FormsCookieName il NAME è probabilmente quello definito nel WEB CONFIG
                    Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

                    // Redirect back to original URL.
                    Response.Redirect(FormsAuthentication.GetRedirectUrl(UserEmail.Text, Persist.Checked));
                }
                else
                {
                    Msg.Text = "Password errata.";
                }
            }
            else
            {
                Msg.Text = "Utente non presente.";
            }

            connection.Close();
        }
    }
}