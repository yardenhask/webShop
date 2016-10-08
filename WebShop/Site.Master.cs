using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebShop
{
    public partial class Site : System.Web.UI.MasterPage
    {
        string clientid;


        protected void Page_Load(object sender, EventArgs e)
        {

            CartMenuB.Visible = false;
            logoutB.Visible = false;
            OrdersReportMenuB.Visible = false;
            ItemsStockReportMenuB.Visible = false;
            ClientsMenuB.Visible = false;

            if (Request.Cookies["logged"] != null)
            {
                CartMenuB.Visible = true;
                logoutB.Visible = true;

                string userNameCookie = Request.Cookies["logged"].Value;
                bool isAdmin = checkIfAdmin(userNameCookie);

                if (isAdmin)
                {
                    OrdersReportMenuB.Visible = true;
                    ItemsStockReportMenuB.Visible = true;
                    ClientsMenuB.Visible = true;
                }

            }

        }

        private bool checkIfAdmin(string username)
        {
            int isAdmin = 0;
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("select isADmin from Clients where username=@username;");
                cmd.Parameters.AddWithValue("@username", username);

                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                bool loginSuccessful = ((ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0));
                if (loginSuccessful)
                {
                    isAdmin = Convert.ToInt32(ds.Tables[0].Rows[0].ItemArray[0]);
                }
            }
            if (isAdmin == 1)
                return true;
            return false;
        }

        private void getClientID(string clientName)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd;
                DataSet ds = new DataSet();
                cmd = new SqlCommand("SELECT Clients.clientid FROM Clients WHERE Clients.username=@clientname");
                cmd.Parameters.AddWithValue("@clientname", clientName);
                cmd.Connection = con;
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand = cmd;
                da.Fill(ds);
                con.Close();
                clientid = ds.Tables[0].Rows[0].ItemArray[0].ToString();
            }
        }
        protected void ProductsMenuB_Click(object sender, EventArgs e)
        {
            string clientName;
            if (Request.Cookies["logged"] != null)
            {
                clientName = Request.Cookies["logged"].Value;
                getClientID(clientName);

            }
            else
            {
                clientName = "guest";
                clientid = "0";
            }
            Response.Redirect("ProductsForm.aspx?clientid=" + clientid);

            /*    using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataSet ds = new DataSet();
                    cmd = new SqlCommand("SELECT Clients.clientid FROM Clients WHERE Clients.username=@clientname");
                    cmd.Parameters.AddWithValue("@clientname", clientName);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(ds);
                    con.Close();

                    bool isCorrectClient = ((ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0));
                    if (isCorrectClient)
                    {
                        Response.Redirect("ProductsForm.aspx?clientid=" + );
                    }
                    else
                    {
                        Response.Redirect("ProductsForm.aspx?clientid=0");

                    }

                }*/

        }

        protected void SearchMenuB_Click(object sender, EventArgs e)
        {
             Response.Redirect("SearchMenu.aspx");
        }

        protected void CartMenuB_Click(object sender, EventArgs e)
        {
            string clientName;
            if (Request.Cookies["logged"] != null)
            {
                clientName = Request.Cookies["logged"].Value;
                getClientID(clientName);

            }
            else
            {
                clientName = "guest";
                clientid = "0";
            }
            Response.Redirect("CartForm.aspx?clientid=" + clientid);
            // Response.Redirect("CartForm.aspx?clientid=305242166");
        }

        protected void HomeMenuB_Click(object sender, EventArgs e)
        {
            Response.Redirect("index1.aspx");
        }

        protected void logoutB_Click(object sender, EventArgs e)
        {
            HttpCookie logged = new HttpCookie("logged");
            logged.Expires = DateTime.Now.AddDays(-2);
            Response.Cookies.Add(logged);
            Response.Redirect("index1.aspx");
        }

        protected void OrdersReportMenuB_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrdersReport.aspx");
        }

        protected void ItemsStockReportMenuB_Click(object sender, EventArgs e)
        {
            Response.Redirect("StockReport.aspx");
        }

        protected void ClientsMenuB_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClientsReport.aspx");
        }

        protected void AboutMenuB_Click(object sender, EventArgs e)
        {
            Response.Redirect("About.aspx");
        }



    }
}