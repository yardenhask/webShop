using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
    public partial class OrdersReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void OrdersReportGV_SelectedIndexChanged(object sender, EventArgs e)
        {

            Response.Redirect("ItemsInOrderReport.aspx?orderid=" + OrdersReportGV.SelectedRow.Cells[0].Text);
        }
    }
}