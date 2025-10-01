using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Summary description for Class1
/// </summary>
/// 
namespace ASPNET.IdeaWeb.Cms
{
    public class BaseSecurityAdminPage : System.Web.UI.Page
    {
        public BaseSecurityAdminPage()
        {

        }

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (!ASPNET.IdeaWeb.Cms.Security.IsInRole("admin"))
            {
                //FormsAuthentication.RedirectToLoginPage();
            }
        }
    }
}