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
/// Descrizione di riepilogo per AlberoCategorie
/// </summary>
public class BreadCrumbCategorie
{
    TreeNodeCollection coll = new TreeNodeCollection();
    TreeNode root = null;
    private static BreadCrumbCategorie bcc = null;

    public static BreadCrumbCategorie getBreadCrubmCategorie(Boolean attivaNavigazione, String codiceLingua)
    {
        //if (BreadCrumbCategorie.bcc == null)
        {
            BreadCrumbCategorie.bcc = new BreadCrumbCategorie(attivaNavigazione, codiceLingua);
        }
        return BreadCrumbCategorie.bcc;
    }
    private BreadCrumbCategorie(Boolean attivaNavigazione, String codiceLingua)
	{

        // Crea una collezione di nodi senza gerarchia
        
        using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {
            try
            {
                connection.Open();
                OleDbCommand command = connection.CreateCommand();
                switch (codiceLingua) {
                    case "IT": command.CommandText = "SELECT [CategoryID],[CategoryName], [CategoryDesc], [parentID] from [CMRC_Categories] order by [position]"; break;
                    case "EN": command.CommandText = "SELECT [CategoryID],[CategoryName_EN], [CategoryDesc_EN], [parentID] from [CMRC_Categories] order by [position]"; break;
                    case "DE": command.CommandText = "SELECT [CategoryID],[CategoryName_DE], [CategoryDesc_DE], [parentID] from [CMRC_Categories] order by [position]"; break;
                    case "L4": command.CommandText = "SELECT [CategoryID],[CategoryName_FR], [CategoryDesc_FR], [parentID] from [CMRC_Categories] order by [position]"; break;
                    default: command.CommandText = "SELECT [CategoryID],[CategoryName], [CategoryDesc], [parentID] from [CMRC_Categories] order by [position]"; break;
                }
                OleDbDataReader reader = command.ExecuteReader();
                int idCategory = -1;
                int idParent = -1;
                String nome = "";
                String descrizione = "";
                while (reader.Read())
                {
                    idCategory = (int) reader[0];
                    if (!(reader[1] is  DBNull)) nome = (string)reader[1];
                    if (!(reader[2] is DBNull)) descrizione = (string)reader[2];
                    idParent = (int)reader[3];
                    TreeNode toAdd = new TreeNode();
                    //toAdd.Text = idCategory + " " + nome + " " + descrizione + " PARENT[" + idParent + "]";
                    toAdd.Text = nome;
                    toAdd.Value = idCategory.ToString();
                    toAdd.ToolTip = idParent.ToString(); // Uso la proprietà ToolTip per memorizzare il padre
                    if (attivaNavigazione) {
                        toAdd.NavigateUrl = "productslist.aspx?CategoryID=" + idCategory.ToString();
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
                TreeNode parent = BreadCrumbCategorie.findParent(this.coll, tmp);
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
        breadCrumbs = " - " + currentNode.Text;
        TreeNode parent = BreadCrumbCategorie.findParent(this.coll, currentNode);
        // aggiungere la condizione && !((parent.Value == "1")) se si vuole evitare di scrivere catalogo
        while ((parent != null) && (parent != currentNode)) {
            currentNode = parent;
            if (currentNode.Value =="1")
            {
                breadCrumbs = "" + currentNode.Text.ToUpper() + breadCrumbs;
            }
            else {
                breadCrumbs = " - " + currentNode.Text + breadCrumbs;
            }

            parent = BreadCrumbCategorie.findParent(this.coll, currentNode);
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
