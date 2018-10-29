using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data.SqlClient;
using System.Data;

using System.Configuration;

namespace CapstoneFinal
{
    /// <summary>
    /// Summary description for MentoreeService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class MentoreeService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        public bool LogOn(string uid, string pass)
        {
            //LOGIC: pass the parameters into the database to see if an account
            //with these credentials exist.  If it does, then log them on by
            //storing their unique ID in the session so that other webmethods
            //can retrieve it and confirm that they logged in.  If it doesn't,
            //we need to signal to them that they did not successfully log on.

            //we return this flag to tell them if they logged in or not
            bool success = false;

            //our connection string comes from our web.config file like we talked about earlier
            string sqlConnectString = System.Configuration.ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;
            //here's our query.  A basic select with nothing fancy.  Note the parameters that begin with @
            string sqlSelect = "SELECT id FROM useraccount WHERE username=@idValue and password=@passValue";

            //set up our connection object to be ready to use our connection string
            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);
            //set up our command object to use our connection, and our query
            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

            //tell our command to replace the @parameters with real values
            //we decode them because they came to us via the web so they were encoded
            //for transmission (funky characters escaped, mostly)
            sqlCommand.Parameters.Add("@idValue", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@idValue"].Value = HttpUtility.UrlDecode(uid);
            sqlCommand.Parameters.Add("@passValue", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@passValue"].Value = HttpUtility.UrlDecode(pass);

            //a data adapter acts like a bridge between our command object and 
            //the data we are trying to get back and put in a table object
            SqlDataAdapter sqlDa = new SqlDataAdapter(sqlCommand);
            //here's the table we want to fill with the results from our query
            DataTable sqlDt = new DataTable();
            //here we go filling it!
            sqlDa.Fill(sqlDt);
            //check to see if any rows were returned.  If they were, it means it's 
            //a legit account
            if (sqlDt.Rows.Count > 0)
            {
                //store the id in the session so other web methods can access it later
                Session["id"] = sqlDt.Rows[0]["id"];
                //flip our flag to true so we return a value that lets them know they're logged in
                success = true;
            }
            //return the result!
            return success;
        }

        [WebMethod(EnableSession = true)]
        public bool LogOff()
        {
            //if they log off, then we remove the session.  That way, if they access
            //again later they have to log back on in order for their ID to be back
            //in the session!
            Session.Abandon();
            return true;
        }
    }
}
