using System;
using System.Collections.Generic;
using System.Web;
using System.Collections;
using System.Data.SqlClient;
using System.Data.OleDb;
/// <summary>
/// Descrizione di riepilogo per CacheApp
/// </summary>
public class CacheApp
{

    private static SortedList productID_to_catID = null;
    private static SortedList productID_to_ModelName_IT = null;
    private static SortedList productID_to_ModelName_EN = null;
    private static SortedList productID_to_Percorso = null;
    private static SortedList productID_to_PercorsoEN = null;
    private static SortedList productID_to_PercorsoDE = null;
    private static SortedList productID_to_PercorsoFR = null;
    private static SortedList productID_to_ModelNumber = null;

    //RC
    //**************************************************************
    private static SortedList productID_to_MetaTitolo = null;
    private static SortedList productID_to_MetaDescription = null;
    private static SortedList productID_to_MetaKeywords = null;

    private static SortedList productID_to_MetaTitolo_EN = null;
    private static SortedList productID_to_MetaDescription_EN = null;
    private static SortedList productID_to_MetaKeywords_EN = null;

    private static SortedList productID_to_MetaTitolo_DE = null;
    private static SortedList productID_to_MetaDescription_DE = null;
    private static SortedList productID_to_MetaKeywords_DE = null;

    private static SortedList productID_to_MetaTitolo_FR = null;
    private static SortedList productID_to_MetaDescription_FR = null;
    private static SortedList productID_to_MetaKeywords_FR = null;
    //**************************************************************


    private static SortedList Product_ID_to_BreadCrumbs = null;
    private static SortedList Product_ID_to_BreadCrumbs_EN = null;
    private static SortedList Product_ID_to_BreadCrumbs_DE = null;
    private static SortedList Product_ID_to_BreadCrumbs_FR = null;

    private static SortedList cat_ID_to_pathCategoria_IT = null;
    private static SortedList cat_ID_to_pathCategoria_EN = null;
    private static SortedList cat_ID_to_pathCategoria_FR = null;
    private static SortedList cat_ID_to_pathCategoria_DE = null;

    private static SortedList cat_ID_to_FileCatalogoCategoria_IT = null;
    private static SortedList cat_ID_to_FileCatalogoCategoria_EN = null;
    private static SortedList cat_ID_to_FileCatalogoCategoria_DE = null;
    private static SortedList cat_ID_to_FileCatalogoCategoria_FR = null;

    private static SortedList cat_ID_to_nomeCategoria_IT = null;
    private static SortedList cat_ID_to_nomeCategoria_EN = null;
    private static SortedList cat_ID_to_nomeCategoria_FR = null;
    private static SortedList cat_ID_to_nomeCategoria_DE = null;

    private static SortedList cat_ID_to_MetaTitolo = null;
    private static SortedList cat_ID_to_MetaDescription = null;
    private static SortedList cat_ID_to_MetaKeywords = null;

    //RC
    //***********************************************************************
    private static SortedList cat_ID_to_MetaTitolo_EN = null;
    private static SortedList cat_ID_to_MetaDescription_EN = null;
    private static SortedList cat_ID_to_MetaKeywords_EN = null;

    private static SortedList cat_ID_to_MetaTitolo_DE = null;
    private static SortedList cat_ID_to_MetaDescription_DE = null;
    private static SortedList cat_ID_to_MetaKeywords_DE = null;

    private static SortedList cat_ID_to_MetaTitolo_FR = null;
    private static SortedList cat_ID_to_MetaDescription_FR = null;
    private static SortedList cat_ID_to_MetaKeywords_FR = null;
    //***********************************************************************
    
    private static SortedList cat_ID_to_SnippetBreadcrumbs = null;
    private static SortedList cat_ID_to_SnippetBreadcrumbs_EN = null;
    private static SortedList cat_ID_to_SnippetBreadcrumbs_DE = null;
    private static SortedList cat_ID_to_SnippetBreadcrumbs_FR = null;
    
    private static SortedList cat_ID_to_Gruppo = null;


	public CacheApp()
	{
		//
		// TODO: aggiungere qui la logica del costruttore
		//
	}

    public static void AzzeraCache()
    {
        productID_to_catID = null;
        productID_to_ModelName_IT = null;
        productID_to_ModelName_EN = null;
        productID_to_ModelNumber = null;

        productID_to_MetaTitolo = null;
        productID_to_MetaTitolo_EN = null;
        productID_to_MetaTitolo_DE = null;
        productID_to_MetaTitolo_FR = null;

        productID_to_MetaDescription = null;
        productID_to_MetaDescription_EN = null;
        productID_to_MetaDescription_DE = null;
        productID_to_MetaDescription_FR = null;

        productID_to_MetaKeywords = null;
        productID_to_MetaKeywords_EN = null;
        productID_to_MetaKeywords_DE = null;
        productID_to_MetaKeywords_FR = null;

        productID_to_Percorso = null;
        productID_to_PercorsoEN = null;
        productID_to_PercorsoFR = null;
        productID_to_PercorsoDE = null;

        Product_ID_to_BreadCrumbs = null;
        Product_ID_to_BreadCrumbs_DE = null;
        Product_ID_to_BreadCrumbs_EN = null;
        Product_ID_to_BreadCrumbs_FR = null;

        cat_ID_to_pathCategoria_IT = null;
        cat_ID_to_pathCategoria_EN = null;
        cat_ID_to_FileCatalogoCategoria_DE = null;
        cat_ID_to_FileCatalogoCategoria_FR = null;

        cat_ID_to_FileCatalogoCategoria_IT = null;
        cat_ID_to_FileCatalogoCategoria_EN = null;

        cat_ID_to_nomeCategoria_IT = null;
        cat_ID_to_nomeCategoria_EN = null;
 
        cat_ID_to_MetaTitolo = null;
        cat_ID_to_MetaDescription = null;
        cat_ID_to_MetaKeywords = null;

        cat_ID_to_MetaTitolo_EN = null;
        cat_ID_to_MetaDescription_EN = null;
        cat_ID_to_MetaKeywords_EN = null;

        cat_ID_to_MetaTitolo_DE = null;
        cat_ID_to_MetaDescription_DE = null;
        cat_ID_to_MetaKeywords_DE = null;

        cat_ID_to_MetaTitolo_FR = null;
        cat_ID_to_MetaDescription_FR = null;
        cat_ID_to_MetaKeywords_FR = null;

        cat_ID_to_SnippetBreadcrumbs = null;
        cat_ID_to_SnippetBreadcrumbs = null;
        cat_ID_to_SnippetBreadcrumbs_EN = null;
        cat_ID_to_SnippetBreadcrumbs_DE = null;
        cat_ID_to_SnippetBreadcrumbs_FR = null;
        
        cat_ID_to_Gruppo = null;
    }

    public static void AzzeraDatiProdotti() {
        productID_to_catID = null;
        productID_to_ModelName_IT = null;
        productID_to_ModelName_EN = null;
        productID_to_ModelNumber = null;

        productID_to_MetaTitolo = null;
        productID_to_MetaTitolo_EN = null;
        productID_to_MetaTitolo_DE = null;
        productID_to_MetaTitolo_FR = null;

        productID_to_MetaDescription = null;
        productID_to_MetaDescription_EN = null;
        productID_to_MetaDescription_DE = null;
        productID_to_MetaDescription_FR = null;

        productID_to_MetaKeywords = null;
        productID_to_MetaKeywords_EN = null;
        productID_to_MetaKeywords_DE = null;
        productID_to_MetaKeywords_FR = null;

        productID_to_Percorso = null;
        productID_to_PercorsoEN = null;
        productID_to_PercorsoFR = null;
        productID_to_PercorsoDE = null;

        Product_ID_to_BreadCrumbs = null;
        Product_ID_to_BreadCrumbs_DE = null;
        Product_ID_to_BreadCrumbs_EN = null;
        Product_ID_to_BreadCrumbs_FR = null;
    }
    public static SortedList get_productID_to_catID()
    {
        if (CacheApp.productID_to_catID != null) return CacheApp.productID_to_catID;
        else
        {
            CacheApp.productID_to_catID = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, CategoryID  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            int idCAT;
            int idProduct;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_catID.Add(idProduct, idCAT);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_catID;   
    }
    public static SortedList get_cat_ID_to_pathCategoria_IT()
    {
        if (CacheApp.cat_ID_to_pathCategoria_IT != null) return CacheApp.cat_ID_to_pathCategoria_IT;
        else
        {
            CacheApp.cat_ID_to_pathCategoria_IT = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, pathCategoria  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String pathCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                pathCategory = reader["pathCategoria"] is DBNull ? "" : (String) reader["pathCategoria"];
                CacheApp.cat_ID_to_pathCategoria_IT.Add(idCAT, pathCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_pathCategoria_IT;
    }
    public static SortedList get_cat_ID_to_pathCategoria_EN()
    {
        if (CacheApp.cat_ID_to_pathCategoria_EN != null) return CacheApp.cat_ID_to_pathCategoria_EN;
        else
        {
            CacheApp.cat_ID_to_pathCategoria_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, pathCategoria_EN  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String pathCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                pathCategory = reader["pathCategoria_EN"] is DBNull ? "" : (String)reader["pathCategoria_EN"];
                CacheApp.cat_ID_to_pathCategoria_EN.Add(idCAT, pathCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_pathCategoria_EN;
    }
    public static SortedList get_cat_ID_to_pathCategoria_FR()
    {
        if (CacheApp.cat_ID_to_pathCategoria_FR != null) return CacheApp.cat_ID_to_pathCategoria_FR;
        else
        {
            CacheApp.cat_ID_to_pathCategoria_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, pathCategoria_FR  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String pathCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                pathCategory = reader["pathCategoria_FR"] is DBNull ? "" : (String)reader["pathCategoria_FR"];
                CacheApp.cat_ID_to_pathCategoria_FR.Add(idCAT, pathCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_pathCategoria_FR;
    }
    public static SortedList get_cat_ID_to_pathCategoria_DE()
    {
        if (CacheApp.cat_ID_to_pathCategoria_DE != null) return CacheApp.cat_ID_to_pathCategoria_DE;
        else
        {
            CacheApp.cat_ID_to_pathCategoria_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, pathCategoria_DE  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String pathCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                pathCategory = reader["pathCategoria_DE"] is DBNull ? "" : (String)reader["pathCategoria_DE"];
                CacheApp.cat_ID_to_pathCategoria_DE.Add(idCAT, pathCategory);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_pathCategoria_DE;
    }

    public static SortedList get_productID_to_Modelnumber()
    {
        if (CacheApp.productID_to_ModelNumber != null) return CacheApp.productID_to_ModelNumber;
        else
        {
            CacheApp.productID_to_ModelNumber = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, ModelNumber  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            int ModelNumber;
            int idProduct;
            while (reader.Read())
            {
                ModelNumber = (int)reader["ModelNumber"];
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_ModelNumber.Add(idProduct, ModelNumber);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_ModelNumber;
    }

    public static SortedList get_productID_to_MetaTitolo()
    {
        if (CacheApp.productID_to_MetaTitolo != null) return CacheApp.productID_to_MetaTitolo;
        else
        {
            CacheApp.productID_to_MetaTitolo = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaTitolo  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaTitolo="";
            int idProduct;
            while (reader.Read())
            {
                MetaTitolo = reader["MetaTitolo"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaTitolo.Add(idProduct, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaTitolo;
    }


    public static SortedList get_productID_to_MetaDescription()
    {
        if (CacheApp.productID_to_MetaDescription != null) return CacheApp.productID_to_MetaDescription;
        else
        {
            CacheApp.productID_to_MetaDescription = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaDescription  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaDescription = "";
            int idProduct;
            while (reader.Read())
            {
                MetaDescription = reader["MetaDescription"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaDescription.Add(idProduct, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaDescription;
    }

    public static SortedList get_productID_to_MetaKeywords()
    {
        if (CacheApp.productID_to_MetaKeywords != null) return CacheApp.productID_to_MetaKeywords;
        else
        {
            CacheApp.productID_to_MetaKeywords = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();

            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaKeywords  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaKeywords = "";
            int idProduct;
            while (reader.Read())
            {
                MetaKeywords = reader["MetaDescription"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaKeywords.Add(idProduct, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaKeywords;
    }

    public static SortedList get_productID_to_MetaTitolo_EN()
    {
        if (CacheApp.productID_to_MetaTitolo_EN != null) return CacheApp.productID_to_MetaTitolo_EN;
        else
        {
            CacheApp.productID_to_MetaTitolo_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaTitolo_EN  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaTitolo = "";
            int idProduct;
            while (reader.Read())
            {
                MetaTitolo = reader["MetaTitolo_EN"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaTitolo_EN.Add(idProduct, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaTitolo_EN;
    }


    public static SortedList get_productID_to_MetaDescription_EN()
    {
        if (CacheApp.productID_to_MetaDescription_EN != null) return CacheApp.productID_to_MetaDescription_EN;
        else
        {
            CacheApp.productID_to_MetaDescription_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaDescription_EN  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaDescription = "";
            int idProduct;
            while (reader.Read())
            {
                MetaDescription = reader["MetaDescription_EN"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaDescription_EN.Add(idProduct, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaDescription_EN;
    }

    public static SortedList get_productID_to_MetaKeywords_EN()
    {
        if (CacheApp.productID_to_MetaKeywords_EN != null) return CacheApp.productID_to_MetaKeywords_EN;
        else
        {
            CacheApp.productID_to_MetaKeywords_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();

            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaKeywords_EN  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaKeywords = "";
            int idProduct;
            while (reader.Read())
            {
                MetaKeywords = reader["MetaDescription_EN"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaKeywords_EN.Add(idProduct, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaKeywords_EN;
    }



    public static SortedList get_productID_to_MetaTitolo_DE()
    {
        if (CacheApp.productID_to_MetaTitolo_DE != null) return CacheApp.productID_to_MetaTitolo_DE;
        else
        {
            CacheApp.productID_to_MetaTitolo_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaTitolo_DE  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaTitolo = "";
            int idProduct;
            while (reader.Read())
            {
                MetaTitolo = reader["MetaTitolo_DE"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaTitolo_DE.Add(idProduct, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaTitolo_DE;
    }


    public static SortedList get_productID_to_MetaDescription_DE()
    {
        if (CacheApp.productID_to_MetaDescription_DE != null) return CacheApp.productID_to_MetaDescription_DE;
        else
        {
            CacheApp.productID_to_MetaDescription_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaDescription_DE  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaDescription = "";
            int idProduct;
            while (reader.Read())
            {
                MetaDescription = reader["MetaDescription_DE"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaDescription_DE.Add(idProduct, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaDescription_DE;
    }

    public static SortedList get_productID_to_MetaKeywords_DE()
    {
        if (CacheApp.productID_to_MetaKeywords_DE != null) return CacheApp.productID_to_MetaKeywords_DE;
        else
        {
            CacheApp.productID_to_MetaKeywords_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();

            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaKeywords_DE  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaKeywords = "";
            int idProduct;
            while (reader.Read())
            {
                MetaKeywords = reader["MetaDescription_DE"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaKeywords_DE.Add(idProduct, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaKeywords_DE;
    }

    public static SortedList get_productID_to_MetaTitolo_FR()
    {
        if (CacheApp.productID_to_MetaTitolo_FR != null) return CacheApp.productID_to_MetaTitolo_FR;
        else
        {
            CacheApp.productID_to_MetaTitolo_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaTitolo_FR  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaTitolo = "";
            int idProduct;
            while (reader.Read())
            {
                MetaTitolo = reader["MetaTitolo_FR"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaTitolo_FR.Add(idProduct, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaTitolo_FR;
    }


    public static SortedList get_productID_to_MetaDescription_FR()
    {
        if (CacheApp.productID_to_MetaDescription_FR != null) return CacheApp.productID_to_MetaDescription_FR;
        else
        {
            CacheApp.productID_to_MetaDescription_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaDescription_FR  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaDescription = "";
            int idProduct;
            while (reader.Read())
            {
                MetaDescription = reader["MetaDescription_FR"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaDescription_FR.Add(idProduct, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaDescription_FR;
    }

    public static SortedList get_productID_to_MetaKeywords_FR()
    {
        if (CacheApp.productID_to_MetaKeywords_FR != null) return CacheApp.productID_to_MetaKeywords_FR;
        else
        {
            CacheApp.productID_to_MetaKeywords_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();

            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT ProductID, MetaKeywords_FR  FROM CMRC_Products ";
            reader = command.ExecuteReader();
            String MetaKeywords = "";
            int idProduct;
            while (reader.Read())
            {
                MetaKeywords = reader["MetaDescription_FR"].ToString();
                idProduct = (int)reader["ProductID"];
                CacheApp.productID_to_MetaKeywords_FR.Add(idProduct, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.productID_to_MetaKeywords_FR;
    }


    public static SortedList get_cat_ID_to_FileCatalogoCategoria_IT()
    {
        if (CacheApp.cat_ID_to_FileCatalogoCategoria_IT != null) return CacheApp.cat_ID_to_FileCatalogoCategoria_IT;
        else
        {
            CacheApp.cat_ID_to_FileCatalogoCategoria_IT = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, fileCatalogoCategoria  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String fileCatalogoCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                fileCatalogoCategory = reader["fileCatalogoCategoria"] is DBNull ? "" : (String)reader["fileCatalogoCategoria"];
                CacheApp.cat_ID_to_FileCatalogoCategoria_IT.Add(idCAT, fileCatalogoCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_FileCatalogoCategoria_IT;
    }
    public static SortedList get_cat_ID_to_FileCatalogoCategoria_EN()
    {
        if (CacheApp.cat_ID_to_FileCatalogoCategoria_EN != null) return CacheApp.cat_ID_to_FileCatalogoCategoria_EN;
        else
        {
            CacheApp.cat_ID_to_FileCatalogoCategoria_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, fileCatalogoCategoria_EN  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String fileCatalogoCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                fileCatalogoCategory = reader["fileCatalogoCategoria_EN"] is DBNull ? "" : (String)reader["fileCatalogoCategoria_EN"];
                CacheApp.cat_ID_to_FileCatalogoCategoria_EN.Add(idCAT, fileCatalogoCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_FileCatalogoCategoria_EN;
    }
    public static SortedList get_cat_ID_to_FileCatalogoCategoria_DE()
    {
        if (CacheApp.cat_ID_to_FileCatalogoCategoria_DE != null) return CacheApp.cat_ID_to_FileCatalogoCategoria_DE;
        else
        {
            CacheApp.cat_ID_to_FileCatalogoCategoria_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, fileCatalogoCategoria_DE  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String fileCatalogoCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                fileCatalogoCategory = reader["fileCatalogoCategoria_DE"] is DBNull ? "" : (String)reader["fileCatalogoCategoria_DE"];
                CacheApp.cat_ID_to_FileCatalogoCategoria_DE.Add(idCAT, fileCatalogoCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_FileCatalogoCategoria_DE;
    }
    public static SortedList get_cat_ID_to_FileCatalogoCategoria_FR()
    {
        if (CacheApp.cat_ID_to_FileCatalogoCategoria_FR != null) return CacheApp.cat_ID_to_FileCatalogoCategoria_FR;
        else
        {
            CacheApp.cat_ID_to_FileCatalogoCategoria_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, fileCatalogoCategoria_FR  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String fileCatalogoCategory;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                fileCatalogoCategory = reader["fileCatalogoCategoria_FR"] is DBNull ? "" : (String)reader["fileCatalogoCategoria_FR"];
                CacheApp.cat_ID_to_FileCatalogoCategoria_FR.Add(idCAT, fileCatalogoCategory);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_FileCatalogoCategoria_FR;
    }

    public static SortedList get_cat_ID_to_nomeCategoria_IT()
    {
        if (CacheApp.cat_ID_to_nomeCategoria_IT != null) return CacheApp.cat_ID_to_nomeCategoria_IT;
        else
        {
            CacheApp.cat_ID_to_nomeCategoria_IT = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, CategoryName  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String CategoryName;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                CategoryName = reader["CategoryName"] is DBNull ? "" : (String)reader["CategoryName"];
                CacheApp.cat_ID_to_nomeCategoria_IT.Add(idCAT, CategoryName);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_nomeCategoria_IT;
    }
    public static SortedList get_cat_ID_to_nomeCategoria_EN()
    {
        if (CacheApp.cat_ID_to_nomeCategoria_EN != null) return CacheApp.cat_ID_to_nomeCategoria_EN;
        else
        {
            CacheApp.cat_ID_to_nomeCategoria_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, CategoryName_EN  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String CategoryName;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                CategoryName = reader["CategoryName_EN"] is DBNull ? "" : (String)reader["CategoryName_EN"];
                CacheApp.cat_ID_to_nomeCategoria_EN.Add(idCAT, CategoryName);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_nomeCategoria_EN;
    }
    public static SortedList get_cat_ID_to_nomeCategoria_FR()
    {
        if (CacheApp.cat_ID_to_nomeCategoria_FR != null) return CacheApp.cat_ID_to_nomeCategoria_FR;
        else
        {
            CacheApp.cat_ID_to_nomeCategoria_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, CategoryName_FR  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String CategoryName;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                CategoryName = reader["CategoryName_FR"] is DBNull ? "" : (String)reader["CategoryName_FR"];
                CacheApp.cat_ID_to_nomeCategoria_FR.Add(idCAT, CategoryName);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_nomeCategoria_FR;
    }
    public static SortedList get_cat_ID_to_nomeCategoria_DE()
    {
        if (CacheApp.cat_ID_to_nomeCategoria_DE != null) return CacheApp.cat_ID_to_nomeCategoria_DE;
        else
        {
            CacheApp.cat_ID_to_nomeCategoria_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT CategoryID, CategoryName_DE  FROM CMRC_Categories";
            reader = command.ExecuteReader();
            int idCAT;
            String CategoryName;
            while (reader.Read())
            {
                idCAT = (int)reader["CategoryID"];
                CategoryName = reader["CategoryName_DE"] is DBNull ? "" : (String)reader["CategoryName_DE"];
                CacheApp.cat_ID_to_nomeCategoria_DE.Add(idCAT, CategoryName);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.cat_ID_to_nomeCategoria_DE;
    }
    public static SortedList get_productID_to_ModelName_IT()
    {
        if (CacheApp.productID_to_ModelName_IT != null) return CacheApp.productID_to_ModelName_IT;
        else
        {
            CacheApp.productID_to_ModelName_IT = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT productID, ModelName  FROM CMRC_Products";
            reader = command.ExecuteReader();
            int productID;
            String ModelName;
            while (reader.Read())
            {
                productID = (int)reader["productID"];
                ModelName = reader["ModelName"] is DBNull ? "" : (String)reader["ModelName"];
                CacheApp.productID_to_ModelName_IT.Add(productID, ModelName);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_ModelName_IT;
    }
    public static SortedList get_productID_to_ModelName_EN()
    {
        if (CacheApp.productID_to_ModelName_EN != null) return CacheApp.productID_to_ModelName_EN;
        else
        {
            CacheApp.productID_to_ModelName_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT productID, ModelName_EN  FROM CMRC_Products";
            reader = command.ExecuteReader();
            int productID;
            String ModelName;
            while (reader.Read())
            {
                productID = (int)reader["productID"];
                ModelName = reader["ModelName_EN"] is DBNull ? "" : (String)reader["ModelName_EN"];
                CacheApp.productID_to_ModelName_EN.Add(productID, ModelName);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_ModelName_EN;
    }

    public static SortedList get_productID_to_percorso()
    {
        if (CacheApp.productID_to_Percorso != null) return CacheApp.productID_to_Percorso;
        else
        {
            CacheApp.productID_to_Percorso = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT productID, percorso  FROM CMRC_Products";
            reader = command.ExecuteReader();
            int productID;
            String percorso;
            while (reader.Read())
            {
                productID = (int)reader["productID"];
                percorso = reader["percorso"] is DBNull ? "" : (String)reader["percorso"];
                CacheApp.productID_to_Percorso.Add(productID, percorso);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_Percorso;
    }

    public static SortedList get_productID_to_percorsoEN()
    {
        if (CacheApp.productID_to_PercorsoEN != null) return CacheApp.productID_to_PercorsoEN;
        else
        {
            CacheApp.productID_to_PercorsoEN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT productID, percorsoEN  FROM CMRC_Products";
            reader = command.ExecuteReader();
            int productID;
            String percorso;
            while (reader.Read())
            {
                productID = (int)reader["productID"];
                percorso = reader["percorsoEN"] is DBNull ? "" : (String)reader["percorsoEN"];
                CacheApp.productID_to_PercorsoEN.Add(productID, percorso);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_PercorsoEN;
    }


    public static SortedList get_productID_to_percorsoDE()
    {
        if (CacheApp.productID_to_PercorsoDE != null) return CacheApp.productID_to_PercorsoDE;
        else
        {
            CacheApp.productID_to_PercorsoDE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT productID, percorsoDE  FROM CMRC_Products";
            reader = command.ExecuteReader();
            int productID;
            String percorso;
            while (reader.Read())
            {
                productID = (int)reader["productID"];
                percorso = reader["percorsoDE"] is DBNull ? "" : (String)reader["percorsoDE"];
                CacheApp.productID_to_PercorsoDE.Add(productID, percorso);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_PercorsoDE;
    }


    public static SortedList get_productID_to_percorsoFR()
    {
        if (CacheApp.productID_to_PercorsoFR != null) return CacheApp.productID_to_PercorsoFR;
        else
        {
            CacheApp.productID_to_PercorsoFR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT productID, percorsoFR  FROM CMRC_Products";
            reader = command.ExecuteReader();
            int productID;
            String percorso;
            while (reader.Read())
            {
                productID = (int)reader["productID"];
                percorso = reader["percorsoFR"] is DBNull ? "" : (String)reader["percorsoFR"];
                CacheApp.productID_to_PercorsoFR.Add(productID, percorso);
            }
            reader.Close();
            connection.Close();
        }

        return CacheApp.productID_to_PercorsoFR;
    }


    public static SortedList get_cat_ID_to_MetaTitolo()
    {
        if (CacheApp.cat_ID_to_MetaTitolo != null) return CacheApp.cat_ID_to_MetaTitolo;
        else
        {
            CacheApp.cat_ID_to_MetaTitolo = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaTitolo] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaTitolo;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaTitolo = reader["MetaTitolo"] is DBNull ? "" : (String)reader["MetaTitolo"];
                CacheApp.cat_ID_to_MetaTitolo.Add(categoryID, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaTitolo;
    }
    public static SortedList get_cat_ID_to_MetaDescription()
    {
        if (CacheApp.cat_ID_to_MetaDescription != null) return CacheApp.cat_ID_to_MetaDescription;
        else
        {
            CacheApp.cat_ID_to_MetaDescription = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaDescription] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaDescription;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaDescription = reader["MetaDescription"] is DBNull ? "" : (String)reader["MetaDescription"];
                CacheApp.cat_ID_to_MetaDescription.Add(categoryID, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaDescription;
    }
    public static SortedList get_cat_ID_to_MetaKeywords()
    {
        if (CacheApp.cat_ID_to_MetaKeywords != null) return CacheApp.cat_ID_to_MetaKeywords;
        else
        {
            CacheApp.cat_ID_to_MetaKeywords = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaKeywords] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaKeywords;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaKeywords = reader["MetaKeywords"] is DBNull ? "" : (String)reader["MetaKeywords"];
                CacheApp.cat_ID_to_MetaKeywords.Add(categoryID, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaKeywords;
    }


    public static SortedList get_cat_ID_to_MetaTitolo_EN()
    {
        if (CacheApp.cat_ID_to_MetaTitolo_EN != null) return CacheApp.cat_ID_to_MetaTitolo_EN;
        else
        {
            CacheApp.cat_ID_to_MetaTitolo_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaTitolo_EN] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaTitolo;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaTitolo = reader["MetaTitolo_EN"] is DBNull ? "" : (String)reader["MetaTitolo_EN"];
                CacheApp.cat_ID_to_MetaTitolo_EN.Add(categoryID, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaTitolo_EN;
    }
    public static SortedList get_cat_ID_to_MetaDescription_EN()
    {
        if (CacheApp.cat_ID_to_MetaDescription_EN != null) return CacheApp.cat_ID_to_MetaDescription_EN;
        else
        {
            CacheApp.cat_ID_to_MetaDescription_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaDescription_EN] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaDescription;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaDescription = reader["MetaDescription_EN"] is DBNull ? "" : (String)reader["MetaDescription_EN"];
                CacheApp.cat_ID_to_MetaDescription_EN.Add(categoryID, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaDescription_EN;
    }
    public static SortedList get_cat_ID_to_MetaKeywords_EN()
    {
        if (CacheApp.cat_ID_to_MetaKeywords_EN != null) return CacheApp.cat_ID_to_MetaKeywords_EN;
        else
        {
            CacheApp.cat_ID_to_MetaKeywords_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaKeywords_EN] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaKeywords;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaKeywords = reader["MetaKeywords_EN"] is DBNull ? "" : (String)reader["MetaKeywords_EN"];
                CacheApp.cat_ID_to_MetaKeywords_EN.Add(categoryID, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaKeywords_EN;
    }

    public static SortedList get_cat_ID_to_MetaTitolo_FR()
    {
        if (CacheApp.cat_ID_to_MetaTitolo_FR != null) return CacheApp.cat_ID_to_MetaTitolo_FR;
        else
        {
            CacheApp.cat_ID_to_MetaTitolo_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaTitolo_FR] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaTitolo;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaTitolo = reader["MetaTitolo_FR"] is DBNull ? "" : (String)reader["MetaTitolo_FR"];
                CacheApp.cat_ID_to_MetaTitolo_FR.Add(categoryID, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaTitolo_FR;
    }
    public static SortedList get_cat_ID_to_MetaDescription_FR()
    {
        if (CacheApp.cat_ID_to_MetaDescription_FR != null) return CacheApp.cat_ID_to_MetaDescription_FR;
        else
        {
            CacheApp.cat_ID_to_MetaDescription_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaDescription_FR] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaDescription;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaDescription = reader["MetaDescription_FR"] is DBNull ? "" : (String)reader["MetaDescription_FR"];
                CacheApp.cat_ID_to_MetaDescription_FR.Add(categoryID, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaDescription_FR;
    }
    public static SortedList get_cat_ID_to_MetaKeywords_FR()
    {
        if (CacheApp.cat_ID_to_MetaKeywords_FR != null) return CacheApp.cat_ID_to_MetaKeywords_FR;
        else
        {
            CacheApp.cat_ID_to_MetaKeywords_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaKeywords_FR] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaKeywords;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaKeywords = reader["MetaKeywords_FR"] is DBNull ? "" : (String)reader["MetaKeywords_FR"];
                CacheApp.cat_ID_to_MetaKeywords_FR.Add(categoryID, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaKeywords_FR;
    }


    public static SortedList get_cat_ID_to_MetaTitolo_DE()
    {
        if (CacheApp.cat_ID_to_MetaTitolo_DE != null) return CacheApp.cat_ID_to_MetaTitolo_DE;
        else
        {
            CacheApp.cat_ID_to_MetaTitolo_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaTitolo_DE] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaTitolo;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaTitolo = reader["MetaTitolo_DE"] is DBNull ? "" : (String)reader["MetaTitolo_DE"];
                CacheApp.cat_ID_to_MetaTitolo_DE.Add(categoryID, MetaTitolo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaTitolo_DE;
    }
    public static SortedList get_cat_ID_to_MetaDescription_DE()
    {
        if (CacheApp.cat_ID_to_MetaDescription_DE != null) return CacheApp.cat_ID_to_MetaDescription_DE;
        else
        {
            CacheApp.cat_ID_to_MetaDescription_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaDescription_DE] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaDescription;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaDescription = reader["MetaDescription_DE"] is DBNull ? "" : (String)reader["MetaDescription_DE"];
                CacheApp.cat_ID_to_MetaDescription_DE.Add(categoryID, MetaDescription);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaDescription_DE;
    }
    public static SortedList get_cat_ID_to_MetaKeywords_DE()
    {
        if (CacheApp.cat_ID_to_MetaKeywords_DE != null) return CacheApp.cat_ID_to_MetaKeywords_DE;
        else
        {
            CacheApp.cat_ID_to_MetaKeywords_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [MetaKeywords_DE] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String MetaKeywords;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                MetaKeywords = reader["MetaKeywords_DE"] is DBNull ? "" : (String)reader["MetaKeywords_DE"];
                CacheApp.cat_ID_to_MetaKeywords_DE.Add(categoryID, MetaKeywords);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_MetaKeywords_DE;
    }



    public static SortedList get_cat_ID_to_SnippetBreadcrumbs()
    {
        if (CacheApp.cat_ID_to_SnippetBreadcrumbs != null) return CacheApp.cat_ID_to_SnippetBreadcrumbs;
        else
        {
            CacheApp.cat_ID_to_SnippetBreadcrumbs = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [SnippetBreadcrumbs] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String SnippetBreadcrumbs;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                SnippetBreadcrumbs = reader["SnippetBreadcrumbs"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs"];
                CacheApp.cat_ID_to_SnippetBreadcrumbs.Add(categoryID, SnippetBreadcrumbs);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_SnippetBreadcrumbs;
    }
    public static SortedList get_cat_ID_to_SnippetBreadcrumbs_EN()
    {
        if (CacheApp.cat_ID_to_SnippetBreadcrumbs_EN != null) return CacheApp.cat_ID_to_SnippetBreadcrumbs_EN;
        else
        {
            CacheApp.cat_ID_to_SnippetBreadcrumbs_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [SnippetBreadcrumbs_EN] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String SnippetBreadcrumbs;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                SnippetBreadcrumbs = reader["SnippetBreadcrumbs_EN"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs_EN"];
                CacheApp.cat_ID_to_SnippetBreadcrumbs_EN.Add(categoryID, SnippetBreadcrumbs);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_SnippetBreadcrumbs_EN;
    }
    public static SortedList get_cat_ID_to_SnippetBreadcrumbs_DE()
    {
        if (CacheApp.cat_ID_to_SnippetBreadcrumbs_DE != null) return CacheApp.cat_ID_to_SnippetBreadcrumbs_DE;
        else
        {
            CacheApp.cat_ID_to_SnippetBreadcrumbs_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [SnippetBreadcrumbs_DE] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String SnippetBreadcrumbs;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                SnippetBreadcrumbs = reader["SnippetBreadcrumbs_DE"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs_DE"];
                CacheApp.cat_ID_to_SnippetBreadcrumbs_DE.Add(categoryID, SnippetBreadcrumbs);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_SnippetBreadcrumbs_DE;
    }
    public static SortedList get_cat_ID_to_SnippetBreadcrumbs_FR()
    {
        if (CacheApp.cat_ID_to_SnippetBreadcrumbs_FR != null) return CacheApp.cat_ID_to_SnippetBreadcrumbs_FR;
        else
        {
            CacheApp.cat_ID_to_SnippetBreadcrumbs_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [SnippetBreadcrumbs_FR] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String SnippetBreadcrumbs;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                SnippetBreadcrumbs = reader["SnippetBreadcrumbs_FR"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs_FR"];
                CacheApp.cat_ID_to_SnippetBreadcrumbs_FR.Add(categoryID, SnippetBreadcrumbs);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_SnippetBreadcrumbs_FR;
    }
    public static SortedList get_cat_ID_to_Gruppo()
    {
        if (CacheApp.cat_ID_to_Gruppo != null) return CacheApp.cat_ID_to_Gruppo;
        else
        {
            CacheApp.cat_ID_to_Gruppo = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [CategoryID], [Gruppo] FROM [CMRC_Categories]";
            reader = command.ExecuteReader();
            int categoryID;
            String Gruppo;
            while (reader.Read())
            {
                categoryID = (int)reader["CategoryID"];
                Gruppo = reader["Gruppo"] is DBNull ? "" : (String)reader["Gruppo"];
                CacheApp.cat_ID_to_Gruppo.Add(categoryID, Gruppo);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.cat_ID_to_Gruppo;
    }
    public static SortedList get_Product_ID_to_BreadCrumbs()
    {
        if (CacheApp.Product_ID_to_BreadCrumbs != null) return CacheApp.Product_ID_to_BreadCrumbs;
        else
        {
            CacheApp.Product_ID_to_BreadCrumbs = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [ProductID], [SnippetBreadcrumbs] FROM [CMRC_Products]";
            reader = command.ExecuteReader();
            int ProductID;
            String bbc;
            while (reader.Read())
            {
                ProductID = (int)reader["ProductID"];
                bbc = reader["SnippetBreadcrumbs"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs"];
                CacheApp.Product_ID_to_BreadCrumbs.Add(ProductID, bbc);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.Product_ID_to_BreadCrumbs;
    }
    public static SortedList get_Product_ID_to_BreadCrumbs_EN()
    {
        if (CacheApp.Product_ID_to_BreadCrumbs_EN != null) return CacheApp.Product_ID_to_BreadCrumbs_EN;
        else
        {
            CacheApp.Product_ID_to_BreadCrumbs_EN = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [ProductID], [SnippetBreadcrumbs_EN] FROM [CMRC_Products]";
            reader = command.ExecuteReader();
            int ProductID;
            String bbc;
            while (reader.Read())
            {
                ProductID = (int)reader["ProductID"];
                bbc = reader["SnippetBreadcrumbs_EN"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs_EN"];
                CacheApp.Product_ID_to_BreadCrumbs_EN.Add(ProductID, bbc);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.Product_ID_to_BreadCrumbs_EN;
    }
    public static SortedList get_Product_ID_to_BreadCrumbs_DE()
    {
        if (CacheApp.Product_ID_to_BreadCrumbs_DE != null) return CacheApp.Product_ID_to_BreadCrumbs_DE;
        else
        {
            CacheApp.Product_ID_to_BreadCrumbs_DE = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [ProductID], [SnippetBreadcrumbs_DE] FROM [CMRC_Products]";
            reader = command.ExecuteReader();
            int ProductID;
            String bbc;
            while (reader.Read())
            {
                ProductID = (int)reader["ProductID"];
                bbc = reader["SnippetBreadcrumbs_DE"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs_DE"];
                CacheApp.Product_ID_to_BreadCrumbs_DE.Add(ProductID, bbc);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.Product_ID_to_BreadCrumbs_DE;
    }
    public static SortedList get_Product_ID_to_BreadCrumbs_FR()
    {
        if (CacheApp.Product_ID_to_BreadCrumbs_FR != null) return CacheApp.Product_ID_to_BreadCrumbs_FR;
        else
        {
            CacheApp.Product_ID_to_BreadCrumbs_FR = new SortedList();
            OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            OleDbCommand command = connection.CreateCommand();
            OleDbDataReader reader;

            connection.Open();


            // CREA IL CAMPO e gli aggiornamenti
            command = connection.CreateCommand();
            command.CommandText = "SELECT [ProductID], [SnippetBreadcrumbs_FR] FROM [CMRC_Products]";
            reader = command.ExecuteReader();
            int ProductID;
            String bbc;
            while (reader.Read())
            {
                ProductID = (int)reader["ProductID"];
                bbc = reader["SnippetBreadcrumbs_FR"] is DBNull ? "" : (String)reader["SnippetBreadcrumbs_FR"];
                CacheApp.Product_ID_to_BreadCrumbs_FR.Add(ProductID, bbc);
            }
            reader.Close();
            connection.Close();
        }
        return CacheApp.Product_ID_to_BreadCrumbs_FR;
    }













    public static int getCatID(int productID) {
        return (int)get_productID_to_catID().GetByIndex(get_productID_to_catID().IndexOfKey(productID));
    }

    public static String getPathCategoryIT(int CategoryID) {
        return (String)get_cat_ID_to_pathCategoria_IT().GetByIndex(get_cat_ID_to_pathCategoria_IT().IndexOfKey(CategoryID));
    }
    public static String getPathCategoryEN(int CategoryID){
        return (String)get_cat_ID_to_pathCategoria_EN().GetByIndex(get_cat_ID_to_pathCategoria_EN().IndexOfKey(CategoryID));
    }
    public static String getPathCategoryFR(int CategoryID){
        return (String)get_cat_ID_to_pathCategoria_FR().GetByIndex(get_cat_ID_to_pathCategoria_FR().IndexOfKey(CategoryID));
    }
    public static String getPathCategoryDE(int CategoryID){
        return (String)get_cat_ID_to_pathCategoria_DE().GetByIndex(get_cat_ID_to_pathCategoria_DE().IndexOfKey(CategoryID));
    }

    public static String getFileCatalogoCategoryIT(int CategoryID) {
        return (String)get_cat_ID_to_FileCatalogoCategoria_IT().GetByIndex(get_cat_ID_to_FileCatalogoCategoria_IT().IndexOfKey(CategoryID));
    }
    public static String getFileCatalogoCategoryEN(int CategoryID) {
        return (String)get_cat_ID_to_FileCatalogoCategoria_EN().GetByIndex(get_cat_ID_to_FileCatalogoCategoria_EN().IndexOfKey(CategoryID));
    }
    public static String getFileCatalogoCategoryDE(int CategoryID)
    {
        return (String)get_cat_ID_to_FileCatalogoCategoria_DE().GetByIndex(get_cat_ID_to_FileCatalogoCategoria_DE().IndexOfKey(CategoryID));
    }
    public static String getFileCatalogoCategoryFR(int CategoryID)
    {
        return (String)get_cat_ID_to_FileCatalogoCategoria_FR().GetByIndex(get_cat_ID_to_FileCatalogoCategoria_FR().IndexOfKey(CategoryID));
    }

    public static String getCategoryNameIT(int CategoryID) {
        return (String)get_cat_ID_to_nomeCategoria_IT().GetByIndex(get_cat_ID_to_nomeCategoria_IT().IndexOfKey(CategoryID));
    }
    public static String getCategoryNameEN(int CategoryID) {
        return (String)get_cat_ID_to_nomeCategoria_EN().GetByIndex(get_cat_ID_to_nomeCategoria_EN().IndexOfKey(CategoryID));
    }
    public static String getCategoryNameDE(int CategoryID) {
        return (String)get_cat_ID_to_nomeCategoria_DE().GetByIndex(get_cat_ID_to_nomeCategoria_DE().IndexOfKey(CategoryID));
    }
    public static String getCategoryNameFR(int CategoryID) {
        return (String)get_cat_ID_to_nomeCategoria_FR().GetByIndex(get_cat_ID_to_nomeCategoria_FR().IndexOfKey(CategoryID));
    }
    public static String getModelNameIT(int ProductID) {
        return (String)get_productID_to_ModelName_IT().GetByIndex(get_productID_to_ModelName_IT().IndexOfKey(ProductID));
    }
    public static String getModelNameEN(int ProductID) {
        return (String)get_productID_to_ModelName_EN().GetByIndex(get_productID_to_ModelName_EN().IndexOfKey(ProductID));
    }


    public static String getPercorso(int ProductID) {
        return (String)get_productID_to_percorso().GetByIndex(get_productID_to_percorso().IndexOfKey(ProductID));
    }
    public static String getPercorsoEN(int ProductID){
        return (String)get_productID_to_percorsoEN().GetByIndex(get_productID_to_percorso().IndexOfKey(ProductID));
    }
    public static String getPercorsoDE(int ProductID){
        return (String)get_productID_to_percorsoDE().GetByIndex(get_productID_to_percorso().IndexOfKey(ProductID));
    }
    public static String getPercorsoFR(int ProductID){
        return (String)get_productID_to_percorsoFR().GetByIndex(get_productID_to_percorso().IndexOfKey(ProductID));
    }


    public static String get_Product_ID_toMetaTitolo(int ProductID)
    {
        return (String)get_productID_to_MetaTitolo().GetByIndex(get_productID_to_MetaTitolo().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaDescription(int ProductID)
    {
        return (String)get_productID_to_MetaDescription().GetByIndex(get_productID_to_MetaDescription().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaKeywords(int ProductID)
    {
        return (String)get_productID_to_MetaKeywords().GetByIndex(get_productID_to_MetaKeywords().IndexOfKey(ProductID));
    }

    public static String get_Product_ID_toMetaTitolo_EN(int ProductID)
    {
        return (String)get_productID_to_MetaTitolo_EN().GetByIndex(get_productID_to_MetaTitolo_EN().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaDescription_EN(int ProductID)
    {
        return (String)get_productID_to_MetaDescription_EN().GetByIndex(get_productID_to_MetaDescription_EN().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaKeywords_EN(int ProductID)
    {
        return (String)get_productID_to_MetaKeywords_EN().GetByIndex(get_productID_to_MetaKeywords_EN().IndexOfKey(ProductID));
    }

    public static String get_Product_ID_toMetaTitolo_FR(int ProductID)
    {
        return (String)get_productID_to_MetaTitolo_FR().GetByIndex(get_productID_to_MetaTitolo_FR().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaDescription_FR(int ProductID)
    {
        return (String)get_productID_to_MetaDescription_FR().GetByIndex(get_productID_to_MetaDescription_FR().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaKeywords_FR(int ProductID)
    {
        return (String)get_productID_to_MetaKeywords_FR().GetByIndex(get_productID_to_MetaKeywords_FR().IndexOfKey(ProductID));
    }

    public static String get_Product_ID_toMetaTitolo_DE(int ProductID)
    {
        return (String)get_productID_to_MetaTitolo_DE().GetByIndex(get_productID_to_MetaTitolo_DE().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaDescription_DE(int ProductID)
    {
        return (String)get_productID_to_MetaDescription_DE().GetByIndex(get_productID_to_MetaDescription_DE().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toMetaKeywords_DE(int ProductID)
    {
        return (String)get_productID_to_MetaKeywords_DE().GetByIndex(get_productID_to_MetaKeywords_DE().IndexOfKey(ProductID));
    }

    public static String get_Product_ID_toSnippetBreadcrumbs(int ProductID)
    {
        return (String)get_Product_ID_to_BreadCrumbs().GetByIndex(get_Product_ID_to_BreadCrumbs().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toSnippetBreadcrumbs_EN(int ProductID)
    {
        return (String)get_Product_ID_to_BreadCrumbs_EN().GetByIndex(get_Product_ID_to_BreadCrumbs_EN().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toSnippetBreadcrumbs_DE(int ProductID) {
        return (String)get_Product_ID_to_BreadCrumbs_DE().GetByIndex(get_Product_ID_to_BreadCrumbs_DE().IndexOfKey(ProductID));
    }
    public static String get_Product_ID_toSnippetBreadcrumbs_FR(int ProductID)
    {
        return (String)get_Product_ID_to_BreadCrumbs_FR().GetByIndex(get_Product_ID_to_BreadCrumbs_FR().IndexOfKey(ProductID));
    }
    public static String get_productID_to_Modelnumber(int ProductID)
    {
        return (String)get_productID_to_Modelnumber().GetByIndex(get_productID_to_Modelnumber().IndexOfKey(ProductID));
    }

    public static String getCategoryMetaTitolo(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaTitolo().GetByIndex(get_cat_ID_to_MetaTitolo().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaDescription(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaDescription().GetByIndex(get_cat_ID_to_MetaDescription().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaKeywords(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaKeywords().GetByIndex(get_cat_ID_to_MetaKeywords().IndexOfKey(CategoryID));
    }

    public static String getCategoryMetaTitolo_EN(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaTitolo_EN().GetByIndex(get_cat_ID_to_MetaTitolo_EN().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaDescription_EN(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaDescription_EN().GetByIndex(get_cat_ID_to_MetaDescription_EN().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaKeywords_EN(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaKeywords_EN().GetByIndex(get_cat_ID_to_MetaKeywords_EN().IndexOfKey(CategoryID));
    }

    public static String getCategoryMetaTitolo_FR(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaTitolo_FR().GetByIndex(get_cat_ID_to_MetaTitolo_FR().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaDescription_FR(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaDescription_FR().GetByIndex(get_cat_ID_to_MetaDescription_FR().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaKeywords_FR(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaKeywords_FR().GetByIndex(get_cat_ID_to_MetaKeywords_FR().IndexOfKey(CategoryID));
    }

    public static String getCategoryMetaTitolo_DE(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaTitolo_DE().GetByIndex(get_cat_ID_to_MetaTitolo_DE().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaDescription_DE(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaDescription_DE().GetByIndex(get_cat_ID_to_MetaDescription_DE().IndexOfKey(CategoryID));
    }
    public static String getCategoryMetaKeywords_DE(int CategoryID)
    {
        return (String)get_cat_ID_to_MetaKeywords_DE().GetByIndex(get_cat_ID_to_MetaKeywords_DE().IndexOfKey(CategoryID));
    }
   
    public static String getCategorySnippetBreadcrumbs(int CategoryID)
    {
        return (String)get_cat_ID_to_SnippetBreadcrumbs().GetByIndex(get_cat_ID_to_SnippetBreadcrumbs().IndexOfKey(CategoryID));
    }
    public static String getCategorySnippetBreadcrumbs_EN(int CategoryID)
    {
        return (String)get_cat_ID_to_SnippetBreadcrumbs_EN().GetByIndex(get_cat_ID_to_SnippetBreadcrumbs_EN().IndexOfKey(CategoryID));
    }
    public static String getCategorySnippetBreadcrumbs_DE(int CategoryID)
    {
        return (String)get_cat_ID_to_SnippetBreadcrumbs_DE().GetByIndex(get_cat_ID_to_SnippetBreadcrumbs_DE().IndexOfKey(CategoryID));
    }
    public static String getCategorySnippetBreadcrumbs_FR(int CategoryID)
    {
        return (String)get_cat_ID_to_SnippetBreadcrumbs_FR().GetByIndex(get_cat_ID_to_SnippetBreadcrumbs_FR().IndexOfKey(CategoryID));
    }

    public static String get_catID_toGruppo(int CategoryID)
    {
        return (String)get_cat_ID_to_Gruppo().GetByIndex(get_cat_ID_to_Gruppo().IndexOfKey(CategoryID));
    }
}