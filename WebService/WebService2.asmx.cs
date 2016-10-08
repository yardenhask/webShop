using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace WebService
{
    /// <summary>
    /// Summary description for WebService2
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService2 : System.Web.Services.WebService
    {

        [WebMethod]
        public DataTable getItem(string query, string ddlChoose)
        {
            SqlCommand cmd = null;
            DataTable dt = new DataTable("answer");

            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {

                cmd = new SqlCommand("SELECT Items.ItemID, Categories.CategoryName, Items.Description, Items.PicturePath, Items.Price, Brands.BrandName FROM ItemCategories INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Items.Description=@itemname");
                cmd.Parameters.AddWithValue("@itemname", query);
                cmd.Connection = con;
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.SelectCommand = cmd;
                da.Fill(dt);
                con.Close();
                return dt;

            }
            //   Item item=new Item()


            // return item;

        }

        [WebMethod]
        public DataTable getItems(string query, string ddlChoose)
        {
            DataTable dt = new DataTable("answer");
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = null;


                if (ddlChoose.Equals("Category") == true)
                {
                    cmd = new SqlCommand("SELECT Items.ItemID, Categories.CategoryName, Items.Description, Items.PicturePath, Items.Price, Brands.BrandName FROM ItemCategories INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.CategoryName=@itemcat");
                    cmd.Parameters.AddWithValue("@itemcat", query);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                }
                else if (ddlChoose.Equals("Brand") == true)
                {
                    cmd = new SqlCommand("SELECT Items.ItemID, Categories.CategoryName, Items.Description, Items.PicturePath, Items.Price, Brands.BrandName FROM ItemCategories INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Brands.BrandName=@itembrand");
                    cmd.Parameters.AddWithValue("@itembrand", query);
                    cmd.Connection = con;
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    con.Close();
                }
            }
            return dt;
        }
        //cmd = new SqlCommand("SELECT Items.ItemID, Categories.CategoryName, Items.Description, Items.PicturePath, Items.Price, Brands.BrandName FROM ItemCategories INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE Categories.CategoryName=@itemcat");

        public class Item
        {
            public Item() { }
            int itemID;
            int brandID;
            int year;
            string ISBN;
            string description;
            string picturePath;
            DateTime date;
            int price;
            int stockAmount;
            public Item(
            int itemID,
            int brandID,
            int year,
            string ISBN,
            string description,
            string picturePath,
            DateTime date,
            int price,
            int stockAmount)
            {
                this.itemID = itemID;
                this.brandID = brandID;
                this.year = year;
                this.ISBN = ISBN;
                this.description = description;
                this.picturePath = picturePath;
                this.date = date;
                this.price = price;
            }



        }
    }
}
