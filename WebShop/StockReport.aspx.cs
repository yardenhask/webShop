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
    public partial class StockReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Getdata();
            changeRed();
        }

        private void changeRed()
        {
            

            for (int i = 0; i < StockItemsGV.Rows.Count; i++)
            {
                string s = StockItemsGV.Rows[i].Cells[7].Text.ToString();
                bool empty = Convert.ToInt32(s) < 3;

                if (empty)
                    StockItemsGV.Rows[i].ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void StockItemsGV_PageIndexChanged(object sender, EventArgs e)
        {
            changeRed();
        }

        protected void StockItemsGV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            StockItemsGV.PageIndex = e.NewPageIndex;

            Getdata();

            
        }

        private void Getdata()
        {
            using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
            {
                SqlCommand cmd = new SqlCommand("SELECT Items.ItemID, Brands.BrandName, Items.Year, Items.ISBN, Items.Description, Items.PublishDate, Items.Price, Items.StokAmount FROM Items INNER JOIN Brands ON Items.BrandID = Brands.BrandID");
                cmd.Connection = con;
                con.Open();

                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Close();

                

                StockItemsGV.DataSource = ds;
                StockItemsGV.DataBind();
            }
            
        }
    }
}