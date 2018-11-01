using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapstoneFinal
{
    public partial class signUp : System.Web.UI.Page
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void submitButton_Click(object sender, EventArgs e)
        {
            if(passwordTextBox.Text == confirmPasswordTextBox.Text)
            {
                string password = passwordTextBox.Text;
                string email = emailTextBox.Text;
                // String to store sql connection
                string a;
                // Connection string from sql database stored and connection established
                a = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                SqlConnection con = new SqlConnection(a);
                con.Open();
                
                SqlCommand cmd = new SqlCommand("INSERT into loginTable" + "(password,email) values(@password, @email)", con);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("INSERT into profile" + "(email) value(@email)", con);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.ExecuteNonQuery();

                con.Close();

                Response.Redirect("mainProfile.aspx");
            }
            else
            {

            }
            



        }
    }
}