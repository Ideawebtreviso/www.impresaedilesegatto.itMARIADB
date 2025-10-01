using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descrizione di riepilogo per GetLanguage
/// </summary>
public class GetLanguage
{
    public const String PathEN = "/en/";
    public const String PathDE = "/de/";
    public const String PathFR = "/fr/";

	public GetLanguage()
	{
	}

    public static byte Get(String url)
    {
        url = url.ToLower();
        if (url.Contains(PathDE))
            return Pagina.DE;
        else if (url.Contains(PathEN))
            return Pagina.EN;
        else if (url.Contains(PathFR))
            return Pagina.FR;
        else
            return Pagina.IT;
    }
}