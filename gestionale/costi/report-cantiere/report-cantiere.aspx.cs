using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gestionale_costi_report_cantiere_report_cantiere : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        object objIDCANTIERE = Request.QueryString["IDCANTIERE"];
        String stringaIDCANTIERE = "0";
        if (objIDCANTIERE != null)
            stringaIDCANTIERE = objIDCANTIERE.ToString();
        LiteralIDCANTIERE.Text = stringaIDCANTIERE;
    }
}