using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gestionale_costi_carica_rapportino_carica_rapportino : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        object objIDMANODOPERA = Request.QueryString["IDMANODOPERA"];
        String stringaIDMANODOPERA = "0";
        if (objIDMANODOPERA != null)
            stringaIDMANODOPERA = objIDMANODOPERA.ToString();
        LiteralIDMANODOPERA.Text = stringaIDMANODOPERA;


        if (ViewState["TextBoxDataDa"] == null) {
            ViewState["TextBoxDataDa"] = DateTime.Today.ToShortDateString();
            ViewState["TextBoxDataA"] = DateTime.Today.AddDays(7).ToShortDateString();
            TextBoxDataDa.Text = ViewState["TextBoxDataDa"].ToString();
            TextBoxDataA.Text = ViewState["TextBoxDataA"].ToString();
        }

    }



    protected void ButtonFiltra_Command(object sender, CommandEventArgs e)
    {
        ViewState["TextBoxDataDa"] = TextBoxDataDa.Text;
        ViewState["TextBoxDataA"] = TextBoxDataA.Text;
    }


}