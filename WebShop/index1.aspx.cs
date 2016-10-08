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
    public partial class index1 : System.Web.UI.Page
    {
        private bool newVisit = true;
        ServiceReference1.WebService1SoapClient proxy;

        protected void Page_Load(object sender, EventArgs e)
        {
            proxy = new ServiceReference1.WebService1SoapClient();
            newItemSection.Visible = false;
            /*  Master.FindControl("CartMenuB").Visible = false;
              Master.FindControl("logoutB").Visible = false;
              Master.FindControl("OrdersReportMenuB").Visible = false;
              Master.FindControl("ItemsStockReportMenuB").Visible = false;
              Master.FindControl("ClientsMenuB").Visible = false;*/

            //      if (!this.IsPostBack)
            {
                if (Request.Cookies["logged"] != null)
                {
                    newVisit = false;

                }
            }

            if (!newVisit)
            {
                loginSection.Visible = false;

                string userNameCookie = Request.Cookies["logged"].Value;
                string dateCookie = Request.Cookies[userNameCookie].Value;
                UserHelloLB.Text = "Hello " + userNameCookie + ", ";
                UserLastVisitLB.Text = dateCookie;

                UserLastVisitLB.Visible = true;
                newItemSection.Visible = true;


                //if entered continue cookie and change login date
                HttpCookie updateDate = new HttpCookie(userNameCookie, DateTime.Now.ToString());
                updateDate.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(updateDate);

            }

        }



        public void loginSignInButton_Click(object sender, EventArgs e)
        {


            bool loginSuccessful = proxy.LoginCheck(loginUserNameTB.Text, loginPassTB.Value.ToString());

            if (loginSuccessful)
            {
                HttpCookie logged = new HttpCookie("logged", loginUserNameTB.Text);
                logged.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(logged);
                HttpCookie logged2 = new HttpCookie(loginUserNameTB.Text, DateTime.Now.ToString());
                logged2.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(logged2);

                Response.Redirect("index1.aspx");
            }
            else
            {
                valid1.Text = "incorect username or password.";

            }

        }


        public void loginRegisterButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterForm.aspx");
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

                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "<script>alert('the item has already entered the cart');</script>");
                    }
                }
            }
        }
        protected void forgotB_Click(object sender, EventArgs e)
        {
            recoverPasswordSection.Visible = true;
        }

        protected void recoverPassB_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("select password from Clients where username=@username and Mail = @mail;");
                cmd.Parameters.AddWithValue("@username", recoverPassUsernameTB.Text);
                cmd.Parameters.AddWithValue("@mail", recoverPassEmailTB.Text);
                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                bool Successful = ((ds.Tables.Count > 0) && (ds.Tables[0].Rows.Count > 0));

                if (Successful)
                {
                    recoveredPassLB.Text = ds.Tables[0].Rows[0].ItemArray[0].ToString();
                }
                else
                {
                    // Console.WriteLine("Invalid username or password");
                    recoveredPassLB.Text = "incorect details.";

                }
            }
        }




    }
}