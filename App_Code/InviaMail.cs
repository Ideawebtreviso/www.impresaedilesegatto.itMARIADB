using System;
using System.Collections.Generic;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web.Security;
using System.IO;

/// <summary>
/// Descrizione di riepilogo per InviaMail
/// </summary>
public class InviaMail
{
	public InviaMail()
	{
		//
		// TODO: aggiungere qui la logica del costruttore
		//
	}
    public static void inviaMail(String mailmittente, String nomeMittente,  String destinatario, String oggetto, String corpo)
    {
        // Command line argument must the the SMTP host.
        SmtpClient client = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["SMTPServer"].ToString());
        NetworkCredential netCred = new NetworkCredential();
        netCred.UserName = System.Configuration.ConfigurationManager.AppSettings["SMTPServerUsername"].ToString();
        netCred.Password = System.Configuration.ConfigurationManager.AppSettings["SMTPServerPassword"].ToString();
        client.Credentials = netCred;

        // Email per amministratore sistema
        MailAddress from = new MailAddress(mailmittente, nomeMittente, System.Text.Encoding.UTF8);
        MailAddress to = new MailAddress(destinatario);
        MailMessage message = new MailMessage(from, to);
        message.Subject = oggetto;
        message.Body = corpo;
        message.BodyEncoding = System.Text.Encoding.ASCII;
        //message.SubjectEncoding = System.Text.Encoding.Default;
        client.Send(message);
        message.Dispose();


    }
    public static void inviaMail(String mailmittente, String nomeMittente, String destinatario, String oggetto, String corpo, FileInfo allegato)
    {

        // Command line argument must the the SMTP host.
        SmtpClient client = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["SMTPServer"].ToString());
        NetworkCredential netCred = new NetworkCredential();
        netCred.UserName = System.Configuration.ConfigurationManager.AppSettings["SMTPServerUsername"].ToString();
        netCred.Password = System.Configuration.ConfigurationManager.AppSettings["SMTPServerPassword"].ToString();
        client.Credentials = netCred;

        // Email per amministratore sistema
        MailAddress from = new MailAddress(mailmittente, nomeMittente, System.Text.Encoding.UTF8);
        MailAddress to = new MailAddress(destinatario);
        MailMessage message = new MailMessage(from, to);
        message.Subject = oggetto;
        message.Body = corpo;
        message.BodyEncoding = System.Text.Encoding.ASCII;
        Attachment a = new Attachment(allegato.FullName);
        message.Attachments.Add(a);
        //message.SubjectEncoding = System.Text.Encoding.Default;
        client.Send(message);
        message.Dispose();


    }
    public static void inviaMail(String mailmittente, String nomeMittente, String destinatario, String oggetto, String corpo, FileInfo[] allegati)
    {
        // Command line argument must the the SMTP host.
        SmtpClient client = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["SMTPServer"].ToString());
        NetworkCredential netCred = new NetworkCredential();
        netCred.UserName = System.Configuration.ConfigurationManager.AppSettings["SMTPServerUsername"].ToString();
        netCred.Password = System.Configuration.ConfigurationManager.AppSettings["SMTPServerPassword"].ToString();
        client.Credentials = netCred;

        // Email per amministratore sistema
        MailAddress from = new MailAddress(mailmittente, nomeMittente, System.Text.Encoding.UTF8);
        MailAddress to = new MailAddress(destinatario);
        MailMessage message = new MailMessage(from, to);
        message.Subject = oggetto;
        message.Body = corpo;
        message.BodyEncoding = System.Text.Encoding.ASCII;
        foreach (FileInfo ff in allegati) {
            Attachment a = new Attachment(ff.FullName);
            message.Attachments.Add(a);
        }

        //message.SubjectEncoding = System.Text.Encoding.Default;
        client.Send(message);
        message.Dispose();


    }
}
