using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
    public partial class About : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void tomerSite_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://tomerdoitshman.net16.net");
        }

        protected void yardenSite_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://yardenhaskal.site88.net");
        }


        protected void common_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://civilwarclash.netau.net/");
        }
    }
}