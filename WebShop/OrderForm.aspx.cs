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
    public partial class OrderForm : System.Web.UI.Page
    {
        string cartid;
        double total;

        protected void Page_Load(object sender, EventArgs e)
        {
            cartid = Request.QueryString["cartid"];
            orderRecived.Visible = false;
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("SELECT Items.StokAmount - ItemsInCart.Amount AS avilable, Items.Description, Items.Price, ItemsInCart.Amount FROM Items INNER JOIN ItemsInCart ON Items.ItemID = ItemsInCart.ItemID INNER JOIN Carts ON ItemsInCart.CartID = Carts.CartID WHERE (Carts.CartID = @cartid) ORDER BY avilable DESC");

                cmd.Parameters.AddWithValue("@cartid", cartid);
                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();
                DataTable dt = new DataTable();
                dt.Columns.Add("Missing", typeof(String));
                dt.Columns.Add("Description", typeof(String));
                total = 0;
                bool isMissing=false;
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    int am = Convert.ToInt32(dr.ItemArray[0]);
                    if (am < 0)
                    {
                        DataRow r = dt.NewRow();
                        r["missing"] = -am;
                        r["Description"] = dr.ItemArray[1];
                        dt.Rows.Add(r);
                        isMissing=true;
                    }
                    else
                    {
                        total += Convert.ToDouble(dr.ItemArray[3]) * Convert.ToDouble(dr.ItemArray[2]);
                    }

                }
                if (!isMissing)
                {
                    missingTitle.Text = "All items are avilable";
                }
                totalPriceLBL.Text = total.ToString();
                itemsStockLV.DataSource = dt;
                itemsStockLV.DataBind();
            }


        }


        protected void CurrencyDDL_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (!CurrencyDDL.SelectedValue.Equals("NIS"))
            {
                totalPriceLBL.Text = (total / 3.5).ToString();
            }
            else
            {
                totalPriceLBL.Text = total.ToString();
            }



        }

        protected void OrderButton_Click(object sender, EventArgs e)
        {
            if (txtDate.Text.Equals(""))
                return;
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cartCmd = new SqlCommand("SELECT ClientID, Currency FROM Carts WHERE (Carts.CartID = @cartid) ");

                cartCmd.Parameters.AddWithValue("@cartid", cartid);
                cartCmd.Connection = con;
                con.Open();

                DataSet CartDs = new DataSet();
                SqlDataAdapter CartDa = new SqlDataAdapter(cartCmd);
                CartDa.Fill(CartDs);
                con.Close();

                SqlCommand OrderCmd = new SqlCommand("INSERT INTO Orders (ClientID, OrderDate,ShipmentDate, Currency) VALUES (@clientid, @orderdate, @shipmentdate, @currency) ");
                OrderCmd.Parameters.AddWithValue("@clientid", CartDs.Tables[0].Rows[0].ItemArray[0]);
                OrderCmd.Parameters.AddWithValue("@orderdate", DateTime.Now);
                OrderCmd.Parameters.AddWithValue("@shipmentdate", txtDate.Text);
                OrderCmd.Parameters.AddWithValue("@currency", CartDs.Tables[0].Rows[0].ItemArray[1]);
                OrderCmd.Connection = con;
                con.Open();
                OrderCmd.CommandType = CommandType.Text;
                OrderCmd.ExecuteNonQuery();
                con.Close();

                SqlCommand orderCmd = new SqlCommand("SELECT OrderID FROM Orders ORDER BY Orders.OrderDate DESC");
                orderCmd.Connection = con;
                con.Open();
                DataSet OrderDs = new DataSet();
                SqlDataAdapter OrderDa = new SqlDataAdapter(orderCmd);
                OrderDa.Fill(OrderDs);
                con.Close();
                string orderid = OrderDs.Tables[0].Rows[0].ItemArray[0].ToString();


                SqlCommand cmd = new SqlCommand("SELECT Items.StokAmount - ItemsInCart.Amount AS avilable, Items.ItemID, ItemsInCart.Amount, Items.StokAmount  FROM Items INNER JOIN ItemsInCart ON Items.ItemID = ItemsInCart.ItemID WHERE (ItemsInCart.CartID = @cartid) ");

                cmd.Parameters.AddWithValue("@cartid", cartid);
                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                SqlCommand cmd2;
                SqlCommand cmd3;
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    int am = Convert.ToInt32(dr.ItemArray[0]);
                    if (am >= 0)
                    {
                        cmd2 = new SqlCommand("INSERT INTO ItemsInOrders(OrderID,ItemID,Amount) VALUES (@orderid,@itemid,@amount)");
                        cmd2.Parameters.AddWithValue("@itemid", dr.ItemArray[1]);
                        cmd2.Parameters.AddWithValue("@amount", dr.ItemArray[2]);
                        cmd2.Parameters.AddWithValue("@orderid", orderid);

                        cmd2.Connection = con;
                        con.Open();
                        cmd2.CommandType = CommandType.Text;
                        cmd2.ExecuteNonQuery();
                        con.Close();

                        int stock=(Convert.ToInt32(dr.ItemArray[3])-Convert.ToInt32(dr.ItemArray[2]));
                        UpdateStock(dr.ItemArray[1].ToString(), stock.ToString());
                    }

                    cmd3 = new SqlCommand("DELETE FROM ItemsInCart WHERE CartID=@cartid and ItemID=@itemid");
                    cmd3.Parameters.AddWithValue("@cartid", cartid);
                    cmd3.Parameters.AddWithValue("@itemid", dr.ItemArray[1]);
                    cmd3.Connection = con;
                    con.Open();
                    cmd3.CommandType = CommandType.Text;
                    cmd3.ExecuteNonQuery();
                    con.Close();
                    
                }


                SqlCommand cart = new SqlCommand("DELETE FROM Carts WHERE CartID=@cartid");
                cart.Parameters.AddWithValue("@cartid", cartid);

                cart.Connection = con;
                con.Open();
                cart.CommandType = CommandType.Text;
                cart.ExecuteNonQuery();
                con.Close();

                orderIdLBL.Text = orderid;
                
            }
            
           

            orderRecived.Visible = true;
            
            OrderButton.Enabled = false;
        }

        private void UpdateStock(string itemid, string amount)
        {
          using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
          {
              SqlCommand cmd2 = new SqlCommand("UPDATE Items SET StokAmount=@amount WHERE ItemID=@itemid;");
              cmd2.Parameters.AddWithValue("@amount", amount);
              cmd2.Parameters.AddWithValue("@itemid", itemid);
              cmd2.Connection = con;
              con.Open();
              cmd2.CommandType = CommandType.Text;
              cmd2.ExecuteNonQuery();
              con.Close();
          }

        }
    }
}