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
    public partial class index : System.Web.UI.Page
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            //string username = usernameTextBox.Text;
            //string password = passwordTextBox.Text;

            //string sql = "SELECT* FROM  Users WHERE username=@username AND [password]=@password";

            //// String to store sql connection
            //SqlConnection con = new SqlConnection();
            //con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();


            //SqlCommand sqlCommand = new SqlCommand(sql, con); ;
            //con.Open();
            //cmd.Parameters.AddWithValue("@username", username);
            //cmd.Parameters.AddWithValue("@password", password);
            //cmd.Connection = con;
            //cmd.CommandText = sql;
            //SqlDataReader rd = cmd.ExecuteReader();

            //if (rd.HasRows)
            //{
            //    while (rd.Read())
            //    {
            //        Response.Redirect("index.aspx");
            //    }
            //}
            //else
            //{
            //    passwordTextBox.Text = "";
            //    errorLabel.Visible = true;
            //    errorLabel.Text = "Username or password is incorrect!";

            //}
        }
    }
}