using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Data.OleDb;


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

}