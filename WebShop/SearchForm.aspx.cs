using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebShop.ServiceReference2;

namespace WebShop
{
    public partial class SearchForm : System.Web.UI.Page
    {
        ServiceReference2.WebService2SoapClient proxy;
        // ServiceReference.WebService1SoapClient proxy;
        protected void Page_Load(object sender, EventArgs e)
        {
            proxy = new ServiceReference2.WebService2SoapClient();
        }

        private void search()
        {
            string query = searchTB.Text;
            string ddlChoose = searchDDL.SelectedValue.ToString();

            //     using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {

                DataTable dt = new DataTable();

                if (ddlChoose.Equals("Item Name") == true)
                {
                    dt = proxy.getItem(query, ddlChoose);

                }

                else if (ddlChoose.Equals("Brand") == true || ddlChoose.Equals("Category") == true)
                {
                    dt = proxy.getItems(query, ddlChoose);
                }

                searchListView.DataSource = dt;
                searchListView.DataBind();
            }


        }


        protected void searchSearchButton_Click(object sender, EventArgs e)
        {
            search();
        }



        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int clientId = 0;
            if (Request.Cookies["logged"] == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "<script>alert('You need to login before enter items to cart');</script>");
            }
            else
            {
                string userNameCookie = Request.Cookies["logged"].Value;
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd = new SqlCommand("select ClientID from Clients where username=@username");
                    cmd.Parameters.AddWithValue("@username", userNameCookie);
                    cmd.Connection = con;
                    con.Open();
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    con.Close();

                    bool Successful = ((ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0));

                    if (Successful)
                    {
                        clientId = Convert.ToInt32(ds.Tables[0].Rows[0].ItemArray[0]);
                    }

                }
                ListViewDataItem item = (ListViewDataItem)e.Item;
                int index = e.Item.DataItemIndex;
                index = index % 6;
                string itemID = ((ListView)sender).DataKeys[index].Value.ToString();
                bool avilable = true;
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd = new SqlCommand("SELECT CartID from Carts WHERE ClientID=@clientid");
                    cmd.Parameters.AddWithValue("@clientid", clientId);
                    cmd.Connection = con;
                    con.Open();
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    con.Close();

                    bool Successful = ((ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0));

                    if (!Successful)
                    {
                        SqlCommand cmd3 = new SqlCommand("INSERT INTO Carts (ClientID) VALUES (@clientid)");
                        cmd3.Parameters.AddWithValue("@clientid", clientId);
                        cmd3.Connection = con;
                        con.Open();
                        cmd3.CommandType = CommandType.Text;
                        cmd3.ExecuteNonQuery();
                        con.Close();
                        cmd = new SqlCommand("SELECT CartID from Carts WHERE ClientID=@clientid");
                        cmd.Parameters.AddWithValue("@clientid", clientId);
                        cmd.Connection = con;
                        con.Open();
                        ds = new DataSet();
                        da = new SqlDataAdapter(cmd);
                        da.Fill(ds);
                        con.Close();
                    }
                    else //if cart exsist, check if item exsist
                    {
                        string cartid = ds.Tables[0].Rows[0].ItemArray[0].ToString();
                        SqlCommand cmd4 = new SqlCommand("SELECT * from ItemsInCart WHERE CartID=@cartid AND ItemID=@itemid");
                        cmd4.Parameters.AddWithValue("@cartid", cartid);
                        cmd4.Parameters.AddWithValue("@itemid", itemID);
                        cmd4.Connection = con;
                        con.Open();
                        DataSet ds4 = new DataSet();
                        SqlDataAdapter da4 = new SqlDataAdapter(cmd4);
                        da4.Fill(ds4);
                        con.Close();

                        bool Successful4 = ((ds4.Tables.Count > 0) && (ds4.Tables[0].Rows.Count > 0));
                        if (Successful4)
                        {
                            avilable = false;
                        }
                    }
                    if (avilable)
                    {
                        string cartid = ds.Tables[0].Rows[0].ItemArray[0].ToString();
                        SqlCommand cmd2 = new SqlCommand("INSERT INTO ItemsInCart(CartID, ItemID, Amount) VALUES (@cartid, @itemid, 1)");
                        cmd2.Parameters.AddWithValue("@cartid", cartid);
                        cmd2.Parameters.AddWithValue("@itemid", itemID);
                        cmd2.Connection = con;
                        con.Open();
                        cmd2.CommandType = CommandType.Text;
                        cmd2.ExecuteNonQuery();
                        con.Close();
                        Response.Redirect("CartForm.aspx?clientid=" + clientId.ToString());
                    }

                }
            }
        }

        protected void searchListView_PagePropertiesChanged(object sender, EventArgs e)
        {
            search();
        }
    }
}