using System;
using System.Collections.Generic;

using System.Web;
using System.Data.OleDb;
using System.IO;

public class PaginaCategoria
{
	public PaginaCategoria()
	{
	}

    public static String getPathCategoria(int idCategoria, int language)
    {
        String path = "";
        path = Pagina.getPathRelativoCategoria(idCategoria, language);
        if (language == Pagina.IT) path += CacheApp.getFileCatalogoCategoryIT(idCategoria) + ".aspx";
        if (language == Pagina.EN) path += CacheApp.getFileCatalogoCategoryEN(idCategoria) + ".aspx";
        if (language == Pagina.FR) path += CacheApp.getFileCatalogoCategoryFR(idCategoria) + ".aspx";
        if (language == Pagina.DE) path += CacheApp.getFileCatalogoCategoryDE(idCategoria) + ".aspx";
        return path;
    }

    public static Boolean generaPaginaCategoria(int idCategoria, byte Language)
    {
        Boolean generata = false;
        //PRENDO TUTTI I DATI DELLA CATEGORIA
        String percorso = "";
        String nomefile = "";

        using (OleDbConnection conn =
            new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {
            conn.Open();
            OleDbCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT * FROM [CMRC_Categories] WHERE [CategoryID] = " + idCategoria;
            OleDbDataReader read = cmd.ExecuteReader();
            if (read.Read())
            {
                if (Language == Pagina.IT)
                {
                    percorso = read["pathCategoria"].ToString();
                    nomefile = read["fileCatalogoCategoria"].ToString();
                }
                else if (Language == Pagina.EN)
                {
                    percorso = read["pathCategoria_EN"].ToString();
                    nomefile = read["fileCatalogoCategoria_EN"].ToString();
                }
                else if(Language==Pagina.DE)
                {
                    percorso = read["pathCategoria_DE"].ToString();
                    nomefile = read["fileCatalogoCategoria_DE"].ToString();
                }
                else if (Language == Pagina.FR)
                {
                    percorso = read["pathCategoria_FR"].ToString();
                    nomefile = read["fileCatalogoCategoria_FR"].ToString();
                }
            }
            conn.Close();
        }
        if (!(File.Exists(System.Configuration.ConfigurationManager.AppSettings["PathSite"] + percorso + nomefile+".aspx.cs") ||
            File.Exists(System.Configuration.ConfigurationManager.AppSettings["PathSite"] + percorso + nomefile +".cs")))
        {
            String nomeModello = "modelloCategoria";
            String pathModelloAspx = System.Configuration.ConfigurationManager.AppSettings["PathModelloCategoria"] + nomeModello + ".aspx";
            String pathModelloCs = System.Configuration.ConfigurationManager.AppSettings["PathModelloCategoria"] + nomeModello + ".aspx.cs";
            string fileAspx = File.ReadAllText(pathModelloAspx, System.Text.UTF8Encoding.UTF8).Replace(nomeModello + ".aspx.cs", nomefile + ".aspx.cs");
            //fileAspx = fileAspx.Replace("news_modello", "news_" + Regex.Replace(nomePagina.Split(separator)[0], "(?![0-9a-zA-Z]).", ""));

            //PIAZZO L'ID DELLA CATEGORIA AL POSTO GIUSTO SUL FILE.CS
            string fileCs = File.ReadAllText(pathModelloCs, System.Text.UTF8Encoding.UTF8).Replace("String CategoryID = \"\"","String CategoryID = \""+idCategoria+"\"");

            String pathFileAspx = System.Configuration.ConfigurationManager.AppSettings["PathSite"] + percorso + nomefile+".aspx";
            String pathFileCs = System.Configuration.ConfigurationManager.AppSettings["PathSite"] + percorso + nomefile + ".aspx.cs";
            
            File.Create(pathFileAspx).Close();
            File.Create(pathFileCs).Close();
            File.WriteAllText(pathFileAspx, fileAspx, System.Text.UTF8Encoding.UTF8);
            File.WriteAllText(pathFileCs, fileCs, System.Text.UTF8Encoding.UTF8);
            generata = true;
        }
        return generata;
    }

    /// <summary>
    /// Metodo che ritorna il microcodice per le breadcrumbs, completamente visibile all'interno di una pagina.
    /// consiglio di nasconderlo in un div con proprietà css display:none.
    /// Questo Codice Particolare ritorna le bbc di una categoria.
    /// Sulla SERP sarà visualizzato: www.urlsito.com >..> bbc
    /// </summary>
    public static String GetSnippetBriciole(int CategoryID, String urlSito, int Language)
    {
        String bbc = "";
        String UrlCategoria = "";
        if (Language == Pagina.IT)
        {
            bbc = CacheApp.getCategorySnippetBreadcrumbs(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryIT(CategoryID) + CacheApp.getFileCatalogoCategoryIT(CategoryID) + ".aspx";
        }
        else if (Language == Pagina.EN)
        {
            bbc = CacheApp.getCategorySnippetBreadcrumbs_EN(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryEN(CategoryID) + CacheApp.getFileCatalogoCategoryEN(CategoryID) + ".aspx";
        }
        else if (Language == Pagina.DE)
        {
            bbc = CacheApp.getCategorySnippetBreadcrumbs_DE(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryDE(CategoryID) + CacheApp.getFileCatalogoCategoryDE(CategoryID) + ".aspx";
        }
        else
        {
            bbc = CacheApp.getCategorySnippetBreadcrumbs_FR(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryFR(CategoryID) + CacheApp.getFileCatalogoCategoryFR(CategoryID) + ".aspx";
        }

        //INTESTAZIONE RICHSNIPPETBCC
        String RichSnippetBCC ="<div itemscope itemtype='http://data-vocabulary.org/Breadcrumb'>"+
        "<a href='" + urlSito +"' itemprop='url'>" +
		"<span itemprop='title'>...</span>"+
		"</a>"; 

        RichSnippetBCC+=">";

        RichSnippetBCC+="<div itemprop='child' itemscope itemtype='http://data-vocabulary.org/Breadcrumb'>"+
		"<a href='"+ UrlCategoria +"' itemprop='url'>"+
		"<span itemprop='title'>"+bbc+"</span>"+
		"</a>";

        //CHIUDO TUTTI I DIV APERTI
        RichSnippetBCC+="</div>";
        RichSnippetBCC += "</div>";

        return RichSnippetBCC;
    }
}