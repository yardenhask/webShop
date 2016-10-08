using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;

namespace WebShop
{
    public partial class RegisterForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] countries = getCountries();

            registerCountryDDL.DataSource = countries;
            registerCountryDDL.DataBind();

            // Response.Redirect("ProductsForm.aspx?cat=harlem");


        }

        protected void registerRegisterButton_Click(object sender, EventArgs e)
        {
            //id not exsist!!!
            if (validLBL.Text.Equals(""))
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=cvm110f94y.database.windows.net;Initial Catalog=WebShopDBAss3;Persist Security Info=True;User ID=tomerdoiServer;Password=beuHer16"))
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO Clients (ClientID, NickName,FirstName, LastName, Adress, City, Country, Phone, Cellular, Mail, CreditCardNumber, isAdmin, password, username) VALUES (@ClientID, @NickName, @FirstName, @LastName, @Adress, @City, @Country, @Phone, @Cellular, @Mail, @CreditCardNumber, @isAdmin, @password, @username) ");
                    cmd.Parameters.AddWithValue("@ClientID", registerIDTB.Text);
                    cmd.Parameters.AddWithValue("@NickName", registerNicknameTB.Text);
                    cmd.Parameters.AddWithValue("@FirstName", registerFirstNameTB.Text);
                    cmd.Parameters.AddWithValue("@LastName", registerLastNameTB.Text);
                    cmd.Parameters.AddWithValue("@Adress", registerAdrressTB.Text);
                    cmd.Parameters.AddWithValue("@City", registerCityTB.Text);
                    cmd.Parameters.AddWithValue("@Country", registerCountryDDL.SelectedValue);
                    cmd.Parameters.AddWithValue("@Phone", registerPhoneNumTB.Text);
                    cmd.Parameters.AddWithValue("@Cellular", registerCellphoneTB.Text);
                    cmd.Parameters.AddWithValue("@Mail", registerMailTB.Text);
                    cmd.Parameters.AddWithValue("@CreditCardNumber", registerCreditCardTB.Text);
                    cmd.Parameters.AddWithValue("@isAdmin", "0");
                    cmd.Parameters.AddWithValue("@password", registerPasswordTB.Text);
                    cmd.Parameters.AddWithValue("@username", registerUserNameTB.Text);
                    cmd.Connection = con;
                    con.Open();
                    cmd.CommandType = CommandType.Text;
                    cmd.ExecuteNonQuery();
                    con.Close();
                    {
                        List<String> cats = new List<string>();
                        foreach (ListItem item in catsCBL.Items)
                        {
                            
                            if (item.Selected)
                            {
                                cats.Add(item.Value);
                            }
                        }
                        
                        for (int i = 0; i < cats.Count; i++)
                        {
                            SqlCommand cmd3 = new SqlCommand("INSERT INTO ClientCategory (ClientID, CategoryID) VALUES (@clientid,@categoryid)");
                            cmd3.Parameters.AddWithValue("@clientid", registerIDTB.Text);
                            cmd3.Parameters.AddWithValue("@categoryid",cats[i] );
                            cmd3.Connection = con;
                            con.Open();
                            cmd3.CommandType = CommandType.Text;
                            cmd3.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
           /*     HttpCookie logged = new HttpCookie("logged", registerUserNameTB.Text);
                logged.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(logged);
                HttpCookie logged2 = new HttpCookie(registerUserNameTB.Text, DateTime.Now.ToString());
                logged2.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(logged2);*/
                Response.Redirect("index1.aspx");
            }
            
        }

        public string[] getCountries()
        {
            Countries c = null;
            string path = Server.MapPath(@"~/countries.xml");

            XmlSerializer serializer = new XmlSerializer(typeof(Countries));

            StreamReader reader = new StreamReader(path);
            c = (Countries)serializer.Deserialize(reader);
            reader.Close();

            string[] res = new string[c.Country.Length];
            for (int i = 0; i < c.Country.Length; i++)
            {
                res[i] = c.Country[i].Name;
            }

            return res;
        }
    }


    [Serializable()]
    public class Country
    {
        [System.Xml.Serialization.XmlElement("ID")]
        public string ID { get; set; }

        [System.Xml.Serialization.XmlElement("Name")]
        public string Name { get; set; }

    }

    [Serializable()]
    [System.Xml.Serialization.XmlRoot("CountriesCollection")]
    public class Countries
    {
        [XmlArray("Countries")]
        [XmlArrayItem("Country", typeof(Country))]
        public Country[] Country { get; set; }


    }

}
