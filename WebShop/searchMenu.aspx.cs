using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
    public partial class searchMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void siteSearchB_Click(object sender, EventArgs e)
        {
            Response.Redirect("SearchForm.aspx");
        }

        protected void angularSearchB_Click(object sender, EventArgs e)
        {
            Response.Redirect("searchAPIH.html");
        }
    }
}