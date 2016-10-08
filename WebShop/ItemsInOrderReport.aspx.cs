using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
    public partial class ItemsInOrderReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ItemsInOrderBackB_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrdersReport.aspx");
        }
    }
}