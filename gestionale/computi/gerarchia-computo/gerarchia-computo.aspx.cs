using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gestionale_computi_gerarchia_computo_gerarchia_computo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        object objIDCOMPUTO = Request.QueryString["IDCOMPUTO"];
        String stringaIDCOMPUTO = "0";
        if (objIDCOMPUTO != null)
            stringaIDCOMPUTO = objIDCOMPUTO.ToString();
        LiteralIDCOMPUTO.Text = stringaIDCOMPUTO;
    }
}