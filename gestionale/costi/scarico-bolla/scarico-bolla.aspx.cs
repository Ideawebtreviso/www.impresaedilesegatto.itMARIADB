using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gestionale_costi_scarico_bolla_scarico_bolla : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        object objIDBOLLA = Request.QueryString["IDBOLLA"];
        String stringaIDBOLLA = "0";
        if (objIDBOLLA != null)
            stringaIDBOLLA = objIDBOLLA.ToString();
        LiteralIDBOLLA.Text = stringaIDBOLLA;
    }
}