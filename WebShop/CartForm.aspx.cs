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
    public partial class CartForm : System.Web.UI.Page
    {
        string cartid;
        string clientid;
        protected void Page_Load(object sender, EventArgs e)
        {
            clientid = Request.QueryString["clientid"];

            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("SELECT Carts.CartID FROM Carts WHERE (Carts.ClientID = @clientid)");
                cmd.Parameters.AddWithValue("@clientid", clientid);
                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    cartid = ds.Tables[0].Rows[0].ItemArray[0].ToString();
                    updateTotalSum();
                    cart.Visible = true;
                    noCartP.Visible = false;
                    checkCart();
                }
                else
                {
                    cart.Visible = false;
                    noCartP.Visible = true;

                }
            }
            
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
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "<script>alert('the item added to the cart');</script>");
                        Response.Redirect("CartForm.aspx?clientid=" + clientid);
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "<script>alert('the item has already entered the cart');</script>");
                    }
                }
            }
        }

        private void checkAmount()
        {
            CartSql.UpdateCommand = "DELETE FROM ItemsInCart WHERE  Amount=" + 0;

            CartSql.Update();
            checkCart();
        }
        private void checkCart()
        {
           
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("SELECT * from ItemsInCart WHERE CartID=@cartid");
                cmd.Parameters.AddWithValue("@cartid", cartid);
                cmd.Connection = con;
                con.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                bool Successful = ((ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0));

                if (!Successful)
                {
                    SqlCommand del = new SqlCommand("DELETE FROM Carts WHERE  CartID=" + cartid,con);
                    con.Open();

                    del.ExecuteNonQuery();
                    con.Close();
                    cartid = "";
                    Response.Redirect("CartForm.aspx?clientid=" + clientid);
                }
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "UpdatePlus")
            {

                int index = Convert.ToInt32(e.CommandArgument);
                string itemid = CartGV.DataKeys[index].Value.ToString();
                CartSql.UpdateCommand = "UPDATE ItemsInCart Set Amount=Amount+1 WHERE ItemID=" + itemid;
                
                CartSql.Update();
                
            }
            else if (e.CommandName == "UpdateMinus")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                string itemid = CartGV.DataKeys[index].Value.ToString();
                CartSql.UpdateCommand = "UPDATE ItemsInCart Set Amount=Amount-1 WHERE ItemID=" + itemid;
                CartSql.Update();
                checkAmount();
            }
            updateTotalSum();



        }

        private void updateTotalSum()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("SELECT SUM(Items.Price * ItemsInCart.Amount) AS sumTotal FROM Items INNER JOIN ItemsInCart ON Items.ItemID = ItemsInCart.ItemID WHERE (ItemsInCart.CartID = @cartid)");
                cmd.Parameters.AddWithValue("@cartid", cartid);
                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                string sum = ds.Tables[0].Rows[0].ItemArray[0].ToString();
                priceLBL.Text = sum;
            }
        }

        protected void payment_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderForm.aspx?cartid=" + cartid);
        }

        protected void CartGV_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            checkCart();
        }
    }
}