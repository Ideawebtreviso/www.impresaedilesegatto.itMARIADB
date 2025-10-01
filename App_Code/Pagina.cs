using System;
using System.Collections.Generic;
using System.Web;
using System.Text.RegularExpressions;
using System.IO;
using System.Data.OleDb;

/// <summary>
/// Descrizione di riepilogo per PagineDinamiche
/// </summary>
public class Pagina
{
    public const int IT = 0;
    public const int EN = 1;
    public const int DE = 2;
    public const int FR = 3;

    public static bool isENEnabled = false;
    public static bool creaPagina(int idProdotto, int language)
    {
        bool creato;
        string nomePagina = getNomePagina(idProdotto, language);
        int idCategoria = getIdCategoria(idProdotto);
        string pathPagina = System.Configuration.ConfigurationManager.AppSettings["PathSite"].ToString() + getPathRelativoCategoria(idCategoria, language);
        string pathModello = System.Configuration.ConfigurationManager.AppSettings["PathModello"].ToString();
        string nomeModello = "modello";
        char[] separator = new char[1];
        separator[0] = '-';

        string pathModelloAspx = pathModello + nomeModello + ".aspx";
        string pathModelloCs = pathModelloAspx + ".cs";
        string pathFileAspx = pathPagina + nomePagina + ".aspx";
        string pathFileCs = pathFileAspx + ".cs";
        if (File.Exists(pathFileAspx) || File.Exists(pathFileCs))
        {
            //File.Delete(pathFileAspx);
            creato = false;
           

        }
        /*if (File.Exists(pathFileCs))
        {
            File.Delete(pathFileCs);
        }*/
        else
        {
            string fileAspx = File.ReadAllText(pathModelloAspx, System.Text.UTF8Encoding.UTF8).Replace(nomeModello + ".aspx.cs", nomePagina + ".aspx.cs");
            //fileAspx = fileAspx.Replace("news_modello", "news_" + Regex.Replace(nomePagina.Split(separator)[0], "(?![0-9a-zA-Z]).", ""));
            string fileCs = File.ReadAllText(pathModelloCs, System.Text.UTF8Encoding.UTF8); //.Replace("news_modello", "news_" + Regex.Replace(nomePagina.Split(separator)[0], "(?![0-9a-zA-Z]).", ""));
            File.Create(pathFileAspx).Close();
            File.Create(pathFileCs).Close();
            File.WriteAllText(pathFileAspx, fileAspx, System.Text.UTF8Encoding.UTF8);
            File.WriteAllText(pathFileCs, fileCs, System.Text.UTF8Encoding.UTF8);
            creato = true;
        }
        return creato;
    }
    public static string getNomePagina(int idProdotto, int language)
    {
        if (language == IT)
            return CacheApp.getPercorso(idProdotto);
        else if (language == EN)
            return CacheApp.getPercorsoEN(idProdotto);
        else if (language == DE)
            return CacheApp.getPercorsoDE(idProdotto);
        else
            return CacheApp.getPercorsoFR(idProdotto);
        /* VERSIONE PRECEDENTE
        int idCategoria = getIdCategoria(idProdotto);
        string titolo = getTitolo(idProdotto, language);
        string fileCatalogoCategoria = getFileCatalogoCategoria(idCategoria, language);
        string nomeFile = fileCatalogoCategoria + "-";
        if (titolo != "")
        {
            nomeFile += ((string)titolo).Replace(" ", "-").Replace(",", "").Replace(":", "").Replace(";", "").Replace("&", "").Replace("%", "").Replace(".", "").Replace("?", "").Replace("\\", "").Replace("/", "").Replace("\"","");
            nomeFile += "-";
        }
        else
        {
            nomeFile += "prodotto-";
        }
        return nomeFile += idProdotto;
         * */
    }
    public static string getNavigateUrl(int idProdotto, int language)
    {
        int idCategoria = getIdCategoria(idProdotto);
        return getPathRelativoCategoria(idCategoria, language) + getNomePagina(idProdotto, language) + ".aspx?ProductID=" + idProdotto + "&CategoryID=" + idCategoria;
    }
    public static int getIdCategoria(int idProdotto)
    {
        return CacheApp.getCatID(idProdotto);

        //int idCategoria = -1;
        //using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        //{

        //    try
        //    {
        //        connection.Open();
        //        OleDbCommand command = connection.CreateCommand();
        //        command.CommandText = "SELECT CategoryID from [CMRC_Products] where ProductID = " + idProdotto;
        //        OleDbDataReader reader = command.ExecuteReader();
        //        if (reader.Read())
        //        {
        //            if (reader["CategoryID"] != null && reader["CategoryID"] != DBNull.Value && reader["CategoryID"].ToString() != "")
        //                idCategoria = int.Parse(reader["CategoryID"].ToString());
        //        }
        //        connection.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        log.lg(ex.ToString());
        //    }
        //}
        //return idCategoria;
    }
    public static int getIdCategoriaFromDB(int idProdotto)
    {

        int idCategoria = -1;
        using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {


                connection.Open();
                OleDbCommand command = connection.CreateCommand();
                command.CommandText = "SELECT CategoryID from [CMRC_Products] where ProductID = " + idProdotto;
                OleDbDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    if (reader["CategoryID"] != null && reader["CategoryID"] != DBNull.Value && reader["CategoryID"].ToString() != "")
                        idCategoria = int.Parse(reader["CategoryID"].ToString());
                }
                connection.Close();
        }
        return idCategoria;
    }
    public static string getNomeCategoria(int idCategoria)
    {
        string nomeCategoria = "";
        nomeCategoria = CacheApp.getCategoryNameIT(idCategoria);
        return nomeCategoria;
        //using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        //{

        //    try
        //    {
        //        connection.Open();
        //        OleDbCommand command = connection.CreateCommand();
        //        command.CommandText = "SELECT CategoryName from [CMRC_Categories] where CategoryID = " + idCategoria;
        //        OleDbDataReader reader = command.ExecuteReader();
        //        if (reader.Read())
        //        {
        //            if (reader["CategoryName"] != null && reader["CategoryName"] != DBNull.Value && reader["CategoryName"].ToString() != "")
        //                nomeCategoria = reader["CategoryName"].ToString();
        //        }
        //        connection.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        log.lg(ex.ToString());
        //    }
        //}
        //return nomeCategoria;
    }
    public static string getTitolo(int idProdotto, int language)
    {
        string titolo = "";
        if (language == IT) titolo = CacheApp.getModelNameIT(idProdotto);
        if (language == EN) titolo = CacheApp.getModelNameEN(idProdotto);
        return titolo;

        //using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        //{
            
        //    try
        //    {
        //        connection.Open();
        //        OleDbCommand command = connection.CreateCommand();
        //        if(language == IT)
        //        command.CommandText = "SELECT CategoryID, ModelName from [CMRC_Products] where ProductID = " + idProdotto;
        //        else if(language == EN)
        //            command.CommandText = "SELECT CategoryID, ModelName_EN as ModelName from [CMRC_Products] where ProductID = " + idProdotto;
        //        OleDbDataReader reader = command.ExecuteReader();
        //        if (reader.Read())
        //        {
        //            if (reader["ModelName"] != null && reader["ModelName"] != DBNull.Value && reader["ModelName"].ToString() != "")
        //                titolo = reader["ModelName"].ToString();
        //        }
        //        connection.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        log.lg(ex.ToString());
        //    }
        //}
        //return titolo;
    }
    public static string getFileCatalogoCategoria(int idCategoria, int language)
    {
        string fileCatalogoCategoria = "";
        if (language == IT) fileCatalogoCategoria = CacheApp.getFileCatalogoCategoryIT(idCategoria);
        if (language == EN) fileCatalogoCategoria = CacheApp.getFileCatalogoCategoryEN(idCategoria);
        return fileCatalogoCategoria;
        //using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        //{
        //    try
        //    {
        //        connection.Open();
        //        OleDbCommand command = connection.CreateCommand();
        //            if(language == IT)
        //        command.CommandText = "SELECT fileCatalogoCategoria from [CMRC_Categories] where CategoryID = " + idCategoria;
        //        else if(language == EN)
        //                command.CommandText = "SELECT fileCatalogoCategoria_EN as fileCatalogoCategoria from [CMRC_Categories] where CategoryID = " + idCategoria;
        //        OleDbDataReader reader = command.ExecuteReader();
        //        if (reader.Read())
        //        {
        //            if (reader["fileCatalogoCategoria"] != null && reader["fileCatalogoCategoria"] != DBNull.Value && reader["fileCatalogoCategoria"].ToString() != "")
        //                fileCatalogoCategoria = reader["fileCatalogoCategoria"].ToString();
        //        }
        //        connection.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        log.lg(ex.ToString());
        //    }
        //}
        //return fileCatalogoCategoria;
    }
    public static string getPathRelativoCategoria(int idCategoria, int language)
    {
        string path = "";
        if (language == IT) return CacheApp.getPathCategoryIT(idCategoria);
        if (language == EN) return CacheApp.getPathCategoryEN(idCategoria);
        if (language == FR) return CacheApp.getPathCategoryFR(idCategoria);
        if (language == DE) return CacheApp.getPathCategoryDE(idCategoria);
        return path;
        //using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        //{
        //    try
        //    {
        //        connection.Open();
        //        OleDbCommand command = connection.CreateCommand();
        //        if(language == IT)
        //        command.CommandText = "SELECT pathCategoria from [CMRC_Categories] where CategoryID = " + idCategoria;
        //        else if(language == EN)
        //            command.CommandText = "SELECT pathCategoria_EN as pathCategoria from [CMRC_Categories] where CategoryID = " + idCategoria;
        //        OleDbDataReader reader = command.ExecuteReader();
        //        if (reader.Read())
        //        {
        //            path = reader["pathCategoria"].ToString();
        //        }
        //        reader.Close();
        //        connection.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        log.lg(ex.ToString());
        //    }
        //}
        //return path;
    }
    public static string getPathAssolutoCategoria(int idCategoria, int language)
    {
        return System.Configuration.ConfigurationManager.AppSettings["PathSite"].ToString() + getPathRelativoCategoria(idCategoria, language);
    }

    /// <summary>
    /// Metodo che ritorna il microcodice per le breadcrumbs, completamente visibile all'interno di una pagina.
    /// consiglio di nasconderlo in un div con proprietà css display:none.
    /// Questo Codice Particolare ritorna le bbc di una categoria.
    /// Sulla SERP sarà visualizzato: www.urlsito.com >..> bbcCategoria > bbcOggetto
    /// </summary>
    public static String GetSnippetBriciole(int ProductID, String urlSito, int language)
    {
        int CategoryID = CacheApp.getCatID(ProductID);

        //String bbcCategoria = CacheApp.getCategorySnippetBreadcrumbs(CategoryID);
        //String UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryIT(CategoryID) + CacheApp.getFileCatalogoCategoryIT(CategoryID) + ".aspx";

        //String bbc = CacheApp.get_Product_ID_toSnippetBreadcrumbs(ProductID);
        //String UrlProdotto = urlSito + "/" + CacheApp.getPathCategoryIT(CategoryID) + CacheApp.getPercorso(ProductID) + ".aspx" + "?ProductID=" + ProductID + "&CategoryID=" + CategoryID;

        String bbcCategoria = "";
        //IL NOME DEL FILE ALL'INTERNO DELLE VARIE CARTELLE DI CATEGORIA è IL MEDESIMO. VADO A PRENDERE
        //getPercorso(CATEGORYID) (che prende il nome del file)  PER OGNI LINGUA, CAMBIA PERò IL PERCORSO.
        String UrlCategoria = "";

        String bbc = "";
        String UrlProdotto = "";

        if (language == IT)
        {
            bbcCategoria = CacheApp.getCategorySnippetBreadcrumbs(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryIT(CategoryID) + CacheApp.getFileCatalogoCategoryIT(CategoryID) + ".aspx";

            bbc = CacheApp.get_Product_ID_toSnippetBreadcrumbs(ProductID);
            UrlProdotto = urlSito + "/" + CacheApp.getPathCategoryIT(CategoryID) + CacheApp.getPercorso(ProductID) + ".aspx" + "?ProductID=" + ProductID + "&CategoryID=" + CategoryID;
        }
        else if (language == EN)
        {
            bbcCategoria = CacheApp.getCategorySnippetBreadcrumbs_EN(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryEN(CategoryID) + CacheApp.getFileCatalogoCategoryEN(CategoryID) + ".aspx";

            bbc = CacheApp.get_Product_ID_toSnippetBreadcrumbs_EN(ProductID);
            UrlProdotto = urlSito + "/" + CacheApp.getPathCategoryEN(CategoryID) + CacheApp.getPercorso(ProductID) + ".aspx" + "?ProductID=" + ProductID + "&CategoryID=" + CategoryID;
        }
        else if (language == DE)
        {
            bbcCategoria = CacheApp.getCategorySnippetBreadcrumbs_DE(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryDE(CategoryID) + CacheApp.getFileCatalogoCategoryDE(CategoryID) + ".aspx";

            bbc = CacheApp.get_Product_ID_toSnippetBreadcrumbs_DE(ProductID);
            UrlProdotto = urlSito + "/" + CacheApp.getPathCategoryDE(CategoryID) + CacheApp.getPercorso(ProductID) + ".aspx" + "?ProductID=" + ProductID + "&CategoryID=" + CategoryID;
        }
        else
        {
            bbcCategoria = CacheApp.getCategorySnippetBreadcrumbs_FR(CategoryID);
            UrlCategoria = urlSito + "/" + CacheApp.getPathCategoryFR(CategoryID) + CacheApp.getFileCatalogoCategoryFR(CategoryID) + ".aspx";

            bbc = CacheApp.get_Product_ID_toSnippetBreadcrumbs_FR(ProductID);
            UrlProdotto = urlSito + "/" + CacheApp.getPathCategoryFR(CategoryID) + CacheApp.getPercorso(ProductID) + ".aspx" + "?ProductID=" + ProductID + "&CategoryID=" + CategoryID;
        }

        //INTESTAZIONE RICHSNIPPETBCC
        String RichSnippetBCC = "<div itemscope itemtype='http://data-vocabulary.org/Breadcrumb'>" +
        "<a href='" + urlSito + "' itemprop='url'>" +
        "<span itemprop='title'>...</span>" +
        "</a>";

        //PEZZO DI LINK SULLA CATEGORIA
        RichSnippetBCC += ">";

        RichSnippetBCC += "<div itemprop='child' itemscope itemtype='http://data-vocabulary.org/Breadcrumb'>" +
        "<a href='" + UrlCategoria + "' itemprop='url'>" +
        "<span itemprop='title'>" + bbcCategoria + "</span>" +
        "</a>";

        //PEZZO DI LINK SUL PRODOTTO
        RichSnippetBCC += ">";

        RichSnippetBCC += "<div itemprop='child' itemscope itemtype='http://data-vocabulary.org/Breadcrumb'>" +
        "<a href='" + UrlProdotto + "' itemprop='url'>" +
        "<span itemprop='title'>" + bbc + "</span>" +
        "</a>";

        //CHIUDO TUTTI I DIV APERTI
        RichSnippetBCC += "</div>";
        RichSnippetBCC += "</div>";
        RichSnippetBCC += "</div>";

        return RichSnippetBCC;
    }
}