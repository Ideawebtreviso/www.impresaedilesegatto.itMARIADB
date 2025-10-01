using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gestionale_costi_controllo_fattura_controllo_fattura : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        object objIDFATTURA = Request.QueryString["IDFATTURA"];
        String stringaIDFATTURA = "0";
        if (objIDFATTURA != null)
            stringaIDFATTURA = objIDFATTURA.ToString();
        LiteralIDFATTURA.Text = stringaIDFATTURA;
    }
}