using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;

/// <summary>
/// Descrizione di riepilogo per BreadCrumbSettori
/// </summary>
public class BreadCrumbSettori
{
    TreeNodeCollection coll = new TreeNodeCollection();
    TreeNode root = null;
    private static BreadCrumbSettori bcc = null;

    public static BreadCrumbSettori getBreadCrumbSettori(Boolean attivaNavigazione, String codiceLingua)
    {
        //if (BreadCrumbSettori.bcc == null)
        {
            BreadCrumbSettori.bcc = new BreadCrumbSettori(attivaNavigazione, codiceLingua);
        }
        return BreadCrumbSettori.bcc;
    }
    private BreadCrumbSettori(Boolean attivaNavigazione, String codiceLingua)
	{

        // Crea una collezione di nodi senza gerarchia
        
        using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {
            try
            {
                connection.Open();
                OleDbCommand command = connection.CreateCommand();
                switch (codiceLingua) {
                    case "IT": command.CommandText = "SELECT [idsettore],[NomeSettore_IT], [parentID] from [Settori] order by [posizione]"; break;
                    case "EN": command.CommandText = "SELECT [idsettore],[NomeSettore_EN], [parentID] from [Settori] order by [posizione]"; break;
                    case "DE": command.CommandText = "SELECT [idsettore],[NomeSettore_DE], [parentID] from [Settori] order by [posizione]"; break;
                    case "L4": command.CommandText = "SELECT [idsettore],[NomeSettore_FR], [parentID] from [Settori] order by [posizione]"; break;
                    default: command.CommandText = "SELECT [idsettore],[NomeSettore_IT], [parentID]  from [Settori] order by [posizione]"; break;
                }
                OleDbDataReader reader = command.ExecuteReader();
                int idSettore = -1;
                int idParent = -1;
                String nome = "";
                while (reader.Read())
                {
                    idSettore = (int)reader["idsettore"];
                    if (!(reader[1] is  DBNull)) nome = (string)reader[1];
                    idParent = (int)reader[2];
                    TreeNode toAdd = new TreeNode();
                    //toAdd.Text = idCategory + " " + nome + " " + descrizione + " PARENT[" + idParent + "]";
                    toAdd.Text = nome;
                    toAdd.Value = idSettore.ToString();
                    toAdd.ToolTip = idParent.ToString(); // Uso la proprietà ToolTip per memorizzare il padre
                    if (attivaNavigazione) {
                        toAdd.NavigateUrl = "productslist.aspx?CategoryID=" + idSettore.ToString();
                    }
                    this.coll.Add(toAdd);

                }
                reader.Close();
                connection.Close();
            }
            catch (Exception ex) {
                log.lg(ex.ToString());
            }

            // Trova il nodo radice

            foreach (TreeNode tmp in this.coll)
            {
                if (tmp.Value == "1") {
                    this.root = tmp;
                    break;
                }
            }
            // Valorizza la gerarchia (per ogni nodo trovo il proprio padre e lo associo)
            foreach (TreeNode tmp in this.coll)
            {
                if (tmp.Value == "1") {
                    continue; 
                }
                TreeNode parent = BreadCrumbSettori.findParent(this.coll, tmp);
                if (parent != null) {
                    parent.ChildNodes.Add(tmp); 
                }
                else {
                    this.root.ChildNodes.Add(tmp); 
                }
            }


            // Associo all'albero il nodo root che ora ha tutta la gerarchia sottostante
        }
       
	}

    public static TreeNode findParent(TreeNodeCollection coll, TreeNode child) {
        foreach (TreeNode tmp in coll) {
            if (tmp.Value == child.ToolTip) {
                return tmp;
            }
        }
        return null;
    }
    public String getBreadCrumbs(int CategoryID) {

        String breadCrumbs = "";
        TreeNode currentNode = null;
        foreach (TreeNode tmp in this.coll) {
            if (tmp.Value == CategoryID.ToString()) {
                currentNode = tmp;
                break;
            }
        }
        if (currentNode == null) return breadCrumbs;
        //
        breadCrumbs = " : " + currentNode.Text;
        TreeNode parent = BreadCrumbSettori.findParent(this.coll, currentNode);
        // aggiungere la condizione && !((parent.Value == "1")) se si vuole evitare di scrivere catalogo
        while ((parent != null) && (parent != currentNode)) {
            currentNode = parent;
            //if (currentNode.Value =="1")
            {
                breadCrumbs = "" + currentNode.Text.ToUpper() + breadCrumbs;
            }
            /*else {
                breadCrumbs = " - " + currentNode.Text + breadCrumbs;
            }*/

            parent = BreadCrumbSettori.findParent(this.coll, currentNode);
        }
        return breadCrumbs.Replace("<br>", " ");

    }



    public String getCategory(int CategoryID) {

        foreach (TreeNode tmp in this.coll)
        {
            if (tmp.Value == CategoryID.ToString())
            {
                return tmp.Text;
            }
        }
        return "";
    }
}