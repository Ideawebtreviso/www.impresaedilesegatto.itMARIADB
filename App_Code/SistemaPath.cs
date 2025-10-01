using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descrizione di riepilogo per SistemaPath
/// </summary>
public class SistemaPath
{
    //public static String dominio_sito = System.Configuration.ConfigurationManager.AppSettings["PathSite"].
    //    Substring(System.Configuration.ConfigurationManager.AppSettings["PathSite"].LastIndexOf("."),
    //    System.Configuration.ConfigurationManager.AppSettings["PathSite"].Length - 
    //    System.Configuration.ConfigurationManager.AppSettings["PathSite"].LastIndexOf(".")).
    //    Replace("\\","").Replace("/","");

	public SistemaPath()
	{
		//
		// TODO: aggiungere qui la logica del costruttore
		//
	}
    /// <summary>
    /// ritorna il numero di slash dell'url.
    /// </summary>
    /// <param name="terminariga">
    /// il dominio dell'url (.com, .org, .eu)
    /// </param>
    /// <returns></returns>
    public static int getSlashOccourrence(String terminariga)
    {
        String uri = HttpContext.Current.Request.Url.AbsoluteUri;
        int path = 0;

        try
        {
            String relpath = uri.Substring(uri.LastIndexOf(terminariga));
            foreach (char c in relpath)
            {
                if (c == '/')
                {
                    path++;
                }
            }
        }
        catch (Exception ex)
        {
        }
        return path;
    }
    /// <summary>
    /// ritorna la profondità di un url
    /// </summary>
    /// <param name="terminariga">
    /// il dominio dell'url (.com, .org, .eu)
    /// </param>
    /// <returns></returns>
    public static String getProfondita(String terminariga)
    {
        String profondita = "";
        int path = getSlashOccourrence(terminariga);
        for (int i = 1; i < path; ++i)
            profondita = "../" + profondita;
        return profondita;
    }

    /// <summary>
    /// Dato il percorso relativo ritorna il percorso assoluto
    /// </summary>
    /// <param name="percorsoRelativo"></param>
    /// <returns></returns>
    public static String sistemaPercorsoRelativo(String percorsoRelativo)
    {
        //return "http://www1.barchessaborin.it/" + percorsoRelativo.Replace("~", "");
        return "http://localhost:52381/www.paggiola.com" + percorsoRelativo.Replace("~", "");
    }
}