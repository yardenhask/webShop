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
    
    public partial class ProductsForm : System.Web.UI.Page
    {
     
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["logged"] == null)
            {
                recommended.Visible = false;
            }
           
            if (!IsPostBack)
            {

                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID");
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();


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


        protected void selectCatB_Click(object sender, EventArgs e)
        {
            sortinOn.Text = "";
            ListViewAllProducts.Items.Clear();
            string cat = catDDL.SelectedValue;
            if (cat.Equals(" "))
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID");
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }
            }
            else {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    ListViewAllProducts.Items.Clear();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID WHERE (Categories.CategoryName = @category)");
                    cmd.Parameters.AddWithValue("@category", cat);

                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();

                    ListViewAllProducts.Items.Clear();

                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }
            }
        }


        protected void initB_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd;
                DataTable dt = new DataTable();
                cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID");
                cmd.Connection = con;
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand = cmd;
                da.Fill(dt);
                con.Close();
                ListViewAllProducts.DataSource = dt;
                ListViewAllProducts.DataBind();
            }
        }

        protected void ProductsSortInc_Click(object sender, EventArgs e)
        {
            sortinOn.Text = "inc";
            string cat = catDDL.SelectedValue;
            if (cat.Equals(" "))
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID ORDER BY Items.Price ASC");
                    cmd.Parameters.AddWithValue("@category", cat);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }
            }
            else
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID WHERE CategoryName=@category ORDER BY Items.Price ASC");
                    cmd.Parameters.AddWithValue("@category", cat);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }
            }
        }

        protected void ProductsSortDec_Click(object sender, EventArgs e)
        {
            sortinOn.Text = "dec";
            string cat = catDDL.SelectedValue;
            if (cat.Equals(" "))
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID ORDER BY Items.Price DESC");
                    cmd.Parameters.AddWithValue("@category", cat);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }

            }
            else
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                    cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID WHERE CategoryName=@category ORDER BY Items.Price DESC");
                    cmd.Parameters.AddWithValue("@category", cat);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }
            }
        }

        protected void ListViewAllProducts_PagePropertiesChanged(object sender, EventArgs e)
        {
             string cat = catDDL.SelectedValue;
             if (cat.Equals(" "))
             {
                 using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                 {
                     SqlCommand cmd;
                     DataTable dt = new DataTable();
                     
                     if (sortinOn.Text.Equals("dec"))
                     {
                         cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID ORDER BY Items.Price DESC");
                     }
                     else if (sortinOn.Text.Equals("inc"))
                     {
                         cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID ORDER BY Items.Price ASC");
                     }
                     else
                     {
                         cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID");
                     }
                     cmd.Parameters.AddWithValue("@category", cat);
                     cmd.Connection = con;
                     con.Open();
                     SqlDataAdapter da = new SqlDataAdapter(cmd);
                     da.SelectCommand = cmd;
                     da.Fill(dt);
                     con.Close();
                     ListViewAllProducts.DataSource = dt;
                     ListViewAllProducts.DataBind();
                 } 
             }
             else
             {
                 using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd;
                    DataTable dt = new DataTable();
                     if (sortinOn.Text.Equals("dec"))
                     {
                         cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID WHERE CategoryName=@category ORDER BY Items.Price DESC");
                     }
                     else if (sortinOn.Text.Equals("inc"))
                     {
                         cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID WHERE CategoryName=@category ORDER BY Items.Price ASC");
                     }
                     else
                     {
                         cmd = new SqlCommand("SELECT ItemCategories.ItemID, Items.Description, Items.PicturePath, Items.Price, Categories.CategoryName FROM ItemCategories INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID WHERE CategoryName=@category");
                     }
                    cmd.Parameters.AddWithValue("@category", cat);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                    ListViewAllProducts.DataSource = dt;
                    ListViewAllProducts.DataBind();
                }
             }
        }

    }



}