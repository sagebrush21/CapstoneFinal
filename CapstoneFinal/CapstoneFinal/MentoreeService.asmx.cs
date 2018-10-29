﻿using System;
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

        [WebMethod(EnableSession = true)]
        public bool CreateAccount(string email, string pass, string firstName, string lastName)
        {
            //again, this is either gonna work or it won't.  We return this flag to let them
            //know if account creation was successful
            bool success = false;
            string sqlConnectString = System.Configuration.ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            string sqlSelect = "insert into useraccount (username, password, firstname, lastname) " +
                "values(@idValue, @passValue, @fnameValue, @lnameValue)SELECT SCOPE_IDENTITY();";

            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);
            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

            sqlCommand.Parameters.Add("@idValue", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@idValue"].Value = HttpUtility.UrlDecode(email);
            sqlCommand.Parameters.Add("@passValue", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@passValue"].Value = HttpUtility.UrlDecode(pass);
            sqlCommand.Parameters.Add("@fnameValue", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@fnameValue"].Value = HttpUtility.UrlDecode(firstName);
            sqlCommand.Parameters.Add("@lnameValue", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@lnameValue"].Value = HttpUtility.UrlDecode(lastName);

            //this time, we're not using a data adapter to fill a data table.  We're just
            //opening the connection, telling our command to "executescalar" which says basically
            //execute the query and just hand me back the number the query returns (the ID, remember?).
            //don't forget to close the connection!
            sqlConnection.Open();
            //we're using a try/catch so that if the query errors out we can handle it gracefully
            //by closing the connection and moving on
            try
            {
                int accountID = Convert.ToInt32(sqlCommand.ExecuteScalar());
                //these three lines only execute if the command doesn't error out
                //so they won't get logged in unless the row is actually inserted.
                success = true;
                Session["id"] = accountID;
            }
            catch (Exception e) { }
            sqlConnection.Close();

            return success;
        }

    }
}
