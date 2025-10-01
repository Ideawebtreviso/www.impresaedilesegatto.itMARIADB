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
public class AlberoCategorie
{
    public static String paginaElencoProdotti = "~/scrivanieetavoli/ScrivanieETavoliRegolabili.aspx?CategoryID=";

    public AlberoCategorie(TreeView alberoCategorie, Boolean attivaNavigazione, String codiceLingua) {
        new AlberoCategorie(alberoCategorie, attivaNavigazione, codiceLingua, true);
    }
	public AlberoCategorie(TreeView alberoCategorie, Boolean attivaNavigazione, String codiceLingua, Boolean mostraLivelloZero)
	{
        alberoCategorie.Nodes.Clear();

        // Crea una collezione di nodi senza gerarchia
        TreeNodeCollection coll = new TreeNodeCollection();
        using (OleDbConnection connection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString))
        {
            try
            {
                connection.Open();
                OleDbCommand command = connection.CreateCommand();
                switch (codiceLingua) {
                    //case "IT": command.CommandText = "SELECT distinct([CMRC_Categories.CategoryID]), [CategoryName], (CategoryDesc), [parentID], [position] FROM [CMRC_Categories] INNER JOIN [CMRC_Products] ON [CMRC_Categories.CategoryID] = [CMRC_Products.CategoryID]"; break;
                    case "IT": command.CommandText = "SELECT [CategoryID],[CategoryName], [CategoryDesc], [parentID] from [CMRC_Categories] order by [position]"; break;
                    case "EN": command.CommandText = "SELECT [CategoryID],[CategoryName_EN], [CategoryDesc_EN], [parentID] from [CMRC_Categories] order by [position]"; break;
                    case "DE": command.CommandText = "SELECT [CategoryID],[CategoryName_DE], [CategoryDesc_DE], [parentID] from [CMRC_Categories] order by [position]"; break;
                    case "FR": command.CommandText = "SELECT [CategoryID],[CategoryName_FR], [CategoryDesc_FR], [parentID] from [CMRC_Categories] order by [position]"; break;
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
                        toAdd.NavigateUrl = paginaElencoProdotti + idCategory.ToString();
                    }
                    coll.Add(toAdd);

                }
                reader.Close();
                connection.Close();
            }
            catch (Exception ex) {
                log.lg(ex.ToString());
            }

            // Trova il nodo radice
            Boolean rootFound = false;
            TreeNode root = null;
            foreach (TreeNode tmp in coll) {
                if (tmp.Value == "1") {
                    root = tmp;
                    rootFound = true;
                    break;
                }
            }
            // Se il nodo radice non c'è (non ha prodotti associati!) crealo
            if (!rootFound) {
                root = new TreeNode();
                switch (codiceLingua)
                {
                    case "IT": root.Text = "Catalogo"; break;
                    case "EN": root.Text = "Catalogue"; break;
                    default: root.Text = "Catalogo"; break;
                }
                root.Value = "1";
                root.ToolTip = "1";
                coll.Add(root);
            }
            // Valorizza la gerarchia (per ogni nodo trovo il proprio padre e lo associo)
            foreach (TreeNode tmp in coll) {
                if (tmp.Value == "1") {
                    continue; 
                }
                TreeNode parent = this.findParent(coll, tmp);
                if (parent != null) {
                    if ( (!mostraLivelloZero) && (parent.Value == "1")) {
                        alberoCategorie.Nodes.Add(tmp);
                    }
                    else parent.ChildNodes.Add(tmp); 
                }
                else {
                    // non passa mai di qua se generato correttamente! ogni nodo ha il padre
                    root.ChildNodes.Add(tmp);
                }
            }

            // Sistemo i tooltip, aggiungo keyword ai link di navigazione
            if (codiceLingua.Equals("IT")) {
                foreach (TreeNode tmp in coll)
                {
                    if (tmp.Parent != null)
                    {
                        tmp.ToolTip = tmp.Parent.Text + " " + tmp.Text + " - Mobili per ufficio";
                        tmp.NavigateUrl += "&mobili=" + tmp.Parent.Text + "&marca=" + tmp.Text;
                    }
                    else
                    {
                        tmp.ToolTip = tmp.Text + " - Mobili per ufficio";
                        tmp.NavigateUrl += "&scrivanie=" + tmp.Text;
                    }

                }      
            }
            else
            {
                foreach (TreeNode tmp in coll)
                {
                    if (tmp.Parent != null)
                    {
                        tmp.ToolTip = tmp.Parent.Text + " " + tmp.Text + " - Workwear";
                        tmp.NavigateUrl += "&garments=" + tmp.Parent.Text + "&brand=" + tmp.Text;
                    }
                    else
                    {
                        tmp.ToolTip = tmp.Text + " - Workwear";
                        tmp.NavigateUrl += "&garments=" + tmp.Text;
                    }

                }
            }


            // Associo all'albero il nodo root che ora ha tutta la gerarchia sottostante
            //alberoCategorie.Nodes.Clear();

            if (mostraLivelloZero) {
                alberoCategorie.Nodes.Add(root);
            }
            
           
        }
	}

    private TreeNode findParent(TreeNodeCollection coll, TreeNode child) {
        foreach (TreeNode tmp in coll) {
            if (tmp.Value == child.ToolTip) {
                return tmp;
            }
        }
        return null;
    }
}
