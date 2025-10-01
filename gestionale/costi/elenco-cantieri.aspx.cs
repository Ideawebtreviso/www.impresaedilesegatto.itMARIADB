using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gestionale_costi_elenco_cantieri : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LabelIDFORNITORESEGATTOMANODOPERA.Text = Application["IDFORNITORESEGATTOMANODOPERA"].ToString();
        LabelIDFORNITORECOSTIGENERICI.Text = Application["IDFORNITORECOSTIGENERICI"].ToString();
    }
}