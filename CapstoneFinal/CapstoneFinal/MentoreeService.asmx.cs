 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.Data.SqlClient;
using System.Data;

using System.Configuration;
using System.Web.Script.Serialization;

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
        public bool LogOn(string email, string pass)
        {
            //LOGIC: pass the parameters into the database to see if an account
            //with these credentials exist.  If it does, then log them on by
            //storing their unique ID in the session so that other webmethods
            //can retrieve it and confirm that they logged in.  If it doesn't,
            //we need to signal to them that they did not successfully log on.

            //we return this flag to tell them if they logged in or not
            bool success = false;

            //our connection string comes from our web.config file like we talked about earlier
            string sqlConnectString = ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;
            //here's our query.  A basic select with nothing fancy.  Note the parameters that begin with @
            string sqlSelect = "SELECT userID FROM login WHERE userEmail=@email and userPassword=@passValue";

            //set up our connection object to be ready to use our connection string
            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);
            //set up our command object to use our connection, and our query
            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

            //tell our command to replace the @parameters with real values
            //we decode them because they came to us via the web so they were encoded
            //for transmission (funky characters escaped, mostly)
            sqlCommand.Parameters.Add("@email", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@email"].Value = HttpUtility.UrlDecode(email);
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
                Session["id"] = sqlDt.Rows[0]["userID"];
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
        public bool CreateAccount(string email, string pass)
        {
            //again, this is either gonna work or it won't.  We return this flag to let them
            //know if account creation was successful
            bool success = false;
            string sqlConnectString = ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            string sqlSelect = "insert into login (userEmail, userPassword) " +
                "values(@email, @password)SELECT SCOPE_IDENTITY();";
            string sqlSelect2 = "insert into profileTable (userEmail)" + "values(@email)";


            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);

            SqlCommand sqlCommand2 = new SqlCommand(sqlSelect2, sqlConnection);

            sqlCommand2.Parameters.Add("@email", System.Data.SqlDbType.NVarChar);
            sqlCommand2.Parameters["@email"].Value = HttpUtility.UrlDecode(email);



            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

            sqlCommand.Parameters.Add("@email", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@email"].Value = HttpUtility.UrlDecode(email);
            sqlCommand.Parameters.Add("@password", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@password"].Value = HttpUtility.UrlDecode(pass);

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

        [WebMethod(EnableSession = true)]
        public string LoadProfile()
        {
            List<Info> lst = new List<Info>();
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            try
            {
                string searchID = Session["id"].ToString();

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select * from profileTable where userEmail = (select userEmail from login where userID = '" + searchID + "');";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        string email = rd[0].ToString().Trim() ?? "";
                        string firstName = rd[1].ToString().Trim() ?? "";
                        string lastName = rd[2].ToString().Trim() ?? "";
                        string currentPosition = rd[3].ToString().Trim() ?? "";
                        string edu_or_cert = rd[4].ToString().Trim() ?? "";
                        string userCity = rd[5].ToString().Trim() ?? "";
                        string userState = rd[6].ToString().Trim() ?? "";
                        string userCountry = rd[7].ToString().Trim() ?? "";
                        string goals = rd[8].ToString().Trim() ?? "";
                        string skills = rd[9].ToString().Trim() ?? "";
                        string experience = rd[10].ToString().Trim() ?? "";
                        string userAvailability = rd[11].ToString().Trim() ?? "";
                        lst.Add(new Info(email, firstName, lastName, currentPosition, edu_or_cert, userCity, userState, userCountry, goals, skills, experience, userAvailability));
                    }

                    string str = new JavaScriptSerializer().Serialize(lst);
                    return str;
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }


        }

        [WebMethod(EnableSession = true)]
        public string LoadUserCode()
        {



            List<UserCode> lst = new List<UserCode>();
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  Thhat's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            try
            {
                string searchID = Session["id"].ToString();

                
                searchID = searchID.PadLeft(5, '0');

                lst.Add(new UserCode(searchID));

                    string str = new JavaScriptSerializer().Serialize(lst);
                    return str;
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                
                
            }
            catch
            {
                return null;
            }


        }

        [WebMethod(EnableSession = true)]
        public string LoadConnections()
        {
            List<Info> lst = new List<Info>();
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            try
            {
                string searchID = Session["id"].ToString();

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select * from profileTable where userEmail IN (select userEmail from bridge_meetings_Profile where meetingId IN (Select meetingID from meetings where meetingId IN (Select meetingId From bridge_meetings_Profile where userEmail = (select userEmail from profileTable where userEmail = (select userEmail from login where userID = '" + searchID + "'))))) And userEmail != (select userEmail from login where userID = '" + searchID + "' ) And userEmail IN (select userEmail from bridge_meetings_Profile where meetingId IN (Select meetingID from meetings where haveMet is NULL));";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        string email = rd[0].ToString().Trim() ?? "";
                        string firstName = rd[1].ToString().Trim() ?? "";
                        string lastName = rd[2].ToString().Trim() ?? "";
                        string currentPosition = rd[3].ToString().Trim() ?? "";
                        string edu_or_cert = rd[4].ToString().Trim() ?? "";
                        string userCity = rd[5].ToString().Trim() ?? "";
                        string userState = rd[6].ToString().Trim() ?? "";
                        string userCountry = rd[7].ToString().Trim() ?? "";
                        string goals = rd[8].ToString().Trim() ?? "";
                        string skills = rd[9].ToString().Trim() ?? "";
                        string experience = rd[10].ToString().Trim() ?? "";
                        string userAvailability = rd[11].ToString().Trim() ?? "";
                        lst.Add(new Info(email, firstName, lastName, currentPosition, edu_or_cert, userCity, userState, userCountry, goals, skills, experience, userAvailability));
                    }

                    string str = new JavaScriptSerializer().Serialize(lst);
                    return str;
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }


        }

        [WebMethod(EnableSession = true)]
        public string LoadMeetingConnections()
        {
            List<Info> lst = new List<Info>();
         
            try
            {
                string searchID = Session["id"].ToString();

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select * from profileTable where userEmail != (select userEmail from login where userID = " + searchID + ") And userEmail NOT IN (select userEmail from bridge_meetings_Profile where meetingId IN (Select meetingID from meetings where haveMet IS NULL) And meetingId In (Select meetingId from meetings where meetingId In (Select meetingId from bridge_meetings_Profile where userEmail IN (Select userEmail from profileTable where userEmail In (Select userEmail from login where userId = " + searchID + "))))); ";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        string email = rd[0].ToString().Trim() ?? "";
                        string firstName = rd[1].ToString().Trim() ?? "";
                        string lastName = rd[2].ToString().Trim() ?? "";
                        string currentPosition = rd[3].ToString().Trim() ?? "";
                        string edu_or_cert = rd[4].ToString().Trim() ?? "";
                        string userCity = rd[5].ToString().Trim() ?? "";
                        string userState = rd[6].ToString().Trim() ?? "";
                        string userCountry = rd[7].ToString().Trim() ?? "";
                        string goals = rd[8].ToString().Trim() ?? "";
                        string skills = rd[9].ToString().Trim() ?? "";
                        string experience = rd[10].ToString().Trim() ?? "";
                        string userAvailability = rd[11].ToString().Trim() ?? "";
                        lst.Add(new Info(email, firstName, lastName, currentPosition, edu_or_cert, userCity, userState, userCountry, goals, skills, experience, userAvailability));
                    }

                    string str = new JavaScriptSerializer().Serialize(lst);
                    return str;
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }


        }

        [WebMethod(EnableSession = true)]
        public bool CreateRandomConnection()
        {
            List<Info> lst = new List<Info>();

            List<string> tmpList;

            tmpList = new List<string>();
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            //try
            {

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select * from profileTable ;";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();

                

                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        string email = rd[0].ToString().Trim() ?? "";
                        string firstName = rd[1].ToString().Trim() ?? "";
                        string lastName = rd[2].ToString().Trim() ?? "";
                        string currentPosition = rd[3].ToString().Trim() ?? "";
                        string edu_or_cert = rd[4].ToString().Trim() ?? "";
                        string userCity = rd[5].ToString().Trim() ?? "";
                        string userState = rd[6].ToString().Trim() ?? "";
                        string userCountry = rd[7].ToString().Trim() ?? "";
                        string goals = rd[8].ToString().Trim() ?? "";
                        string skills = rd[9].ToString().Trim() ?? "";
                        string experience = rd[10].ToString().Trim() ?? "";
                        string userAvailability = rd[11].ToString().Trim() ?? "";
                        lst.Add(new Info(email, firstName, lastName, currentPosition, edu_or_cert, userCity, userState, userCountry, goals, skills, experience, userAvailability));
                    }


                    foreach (Info x in lst)
                    {
                        tmpList.Add(x.Email);
                    }

                    string[] listArray = new string[tmpList.Count()];

                    int tmpNum = 0;

                    foreach (string s in tmpList)
                    {
                       

                        listArray[tmpNum] = s;

                        tmpNum++;
                    }


                    foreach (string s in tmpList)
                    {
                        bool doesExist = false;
                        bool success = false;

                        for (int i = 0; i < listArray.Length; i++)
                        {
                                if(s == listArray[i])
                            {
                                doesExist = true;
                            }
                        }

                        if(doesExist != false)
                        {
                            int totalLoops = 0;
                            while (success == false)
                            {
                               
                                totalLoops++;
                                bool nameMatch = false;

                                Random random = new Random();

                                int index = random.Next(tmpList.Count);

                                string tmpEmail = tmpList[index];

                                if (tmpEmail == s)
                                {

                                }
                                else
                                {
                                    con = new SqlConnection();
                                    con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                                    con.Open();
                                    cmd = new SqlCommand();
                                    cmd.CommandText = "Select * from profileTable where userEmail IN (select userEmail from bridge_meetings_Profile where meetingId IN (Select meetingID from meetings where meetingId IN (Select meetingId From bridge_meetings_Profile where userEmail = (select userEmail from profileTable where userEmail = (select userEmail from login where userEmail = '" + s + "'))))) And userEmail != (select userEmail from login where userEmail = '" + s + "' );";
                                    cmd.Connection = con;
                                    rd = cmd.ExecuteReader();

                                    if (rd.HasRows)
                                    {
                                        while (rd.Read())
                                        {
                                            string email = rd[0].ToString().Trim() ?? "";

                                            if (email == tmpEmail)
                                            {
                                                nameMatch = true;
                                            }
                                        }

                                        if (nameMatch != true)
                                        {
                                            success = true;

                                            string meetingID;
                                            string fixID = "";

                                            con = new SqlConnection();
                                            con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                                            con.Open();
                                            cmd = new SqlCommand();
                                            cmd.CommandText = "Select MAX(meetingID) from meetings";
                                            cmd.Connection = con;
                                            rd = cmd.ExecuteReader();

                                            if (rd.HasRows)
                                            {
                                                while (rd.Read())
                                                {
                                                    meetingID = rd[0].ToString().Trim() ?? "";
                                                    fixID = "M" + (Convert.ToInt32(meetingID.Replace("M", "")) + 1).ToString().PadLeft(5, '0');
                                                }
                                            }

                                            string date = DateTime.Today.AddMonths(2).ToString("yyyy-MM-dd");

                                            string sqlSelect = "insert into meetings (meetingID, meetingDate) " + "values(@id, @date);";

                                            string sqlSelect2 = "insert into bridge_Meetings_Profile (meetingID, userEmail)" + "values(@id, @email);";

                                            string sqlSelect3 = "insert into bridge_Meetings_Profile (meetingID, userEmail)" + "values(@id, @email);";

                                            string sqlConnectString = ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;

                                            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);

                                            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

                                            sqlCommand.Parameters.Add("@id", System.Data.SqlDbType.NVarChar);
                                            sqlCommand.Parameters["@id"].Value = HttpUtility.UrlDecode(fixID);
                                            sqlCommand.Parameters.Add("@date", System.Data.SqlDbType.NVarChar);
                                            sqlCommand.Parameters["@date"].Value = HttpUtility.UrlDecode(date);

                                           

                                            SqlCommand sqlCommand2 = new SqlCommand(sqlSelect2, sqlConnection);

                                            sqlCommand2.Parameters.Add("@id", System.Data.SqlDbType.NVarChar);
                                            sqlCommand2.Parameters["@id"].Value = HttpUtility.UrlDecode(fixID);
                                            sqlCommand2.Parameters.Add("@email", System.Data.SqlDbType.NVarChar);
                                            sqlCommand2.Parameters["@email"].Value = HttpUtility.UrlDecode(s);

                                           
                                            SqlCommand sqlCommand3 = new SqlCommand(sqlSelect3, sqlConnection);

                                            sqlCommand3.Parameters.Add("@id", System.Data.SqlDbType.NVarChar);
                                            sqlCommand3.Parameters["@id"].Value = HttpUtility.UrlDecode(fixID);
                                            sqlCommand3.Parameters.Add("@email", System.Data.SqlDbType.NVarChar);
                                            sqlCommand3.Parameters["@email"].Value = HttpUtility.UrlDecode(tmpEmail);

                                            sqlConnection.Open();
                                            //we're using a try/catch so that if the query errors out we can handle it gracefully
                                            //by closing the connection and moving on
                                            try
                                            {
                                                sqlCommand.ExecuteNonQuery();
                                                sqlCommand2.ExecuteNonQuery();
                                                sqlCommand3.ExecuteNonQuery();

                                                success = true;
                                            }
                                            catch
                                            {

                                                success = false;
                                            }


                                            sqlConnection.Close();


                                            for (int i = 0; i < listArray.Length; i++)
                                            {
                                                if (s == listArray[i])
                                                {
                                                    listArray[i] = "";
                                                }
                                                if (tmpEmail == listArray[i])
                                                {
                                                    listArray[i] = "";
                                                }
                                            }
                                        }

                                    }
                                    else
                                    {

                                    }
                                }

                                
                                if (totalLoops > 20)
                                {
                                    success = true;
                                }

                            }
                        }
                        

                        
                   

                     

                       
                    }
                  
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                }
                else
                {
                    return true;
                }
            }
           // catch
            {
                return true;
            }

            return true;
        }


        [WebMethod(EnableSession = true)]
        public bool NewProfile(string email)
        {
            //if they log off, then we remove the session.  That way, if they access
            //again later they have to log back on in order for their ID to be back
            //in the session!
            Session["newProfile"] = email;
            return true;
        }

        [WebMethod(EnableSession = true)]
        public string LoadNewConnections()
        {
            List<Info> lst = new List<Info>();
         
            try
            {
                string searchID = Session["newProfile"].ToString();

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select * from profileTable where userEmail IN (select userEmail from bridge_meetings_Profile where meetingId IN (Select meetingID from meetings where meetingId IN (Select meetingId From bridge_meetings_Profile where userEmail = (select userEmail from profileTable where userEmail = (select userEmail from login where userEmail = '" + searchID + "'))))) And userEmail != (select userEmail from login where userEmail = '" + searchID + "' ) And userEmail IN (select userEmail from bridge_meetings_Profile where meetingId IN (Select meetingID from meetings where haveMet is NULL));";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        string email = rd[0].ToString().Trim() ?? "";
                        string firstName = rd[1].ToString().Trim() ?? "";
                        string lastName = rd[2].ToString().Trim() ?? "";
                        string currentPosition = rd[3].ToString().Trim() ?? "";
                        string edu_or_cert = rd[4].ToString().Trim() ?? "";
                        string userCity = rd[5].ToString().Trim() ?? "";
                        string userState = rd[6].ToString().Trim() ?? "";
                        string userCountry = rd[7].ToString().Trim() ?? "";
                        string goals = rd[8].ToString().Trim() ?? "";
                        string skills = rd[9].ToString().Trim() ?? "";
                        string experience = rd[10].ToString().Trim() ?? "";
                        string userAvailability = rd[11].ToString().Trim() ?? "";
                        lst.Add(new Info(email, firstName, lastName, currentPosition, edu_or_cert, userCity, userState, userCountry, goals, skills, experience, userAvailability));
                    }

                    string str = new JavaScriptSerializer().Serialize(lst);
                    return str;
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }


        }


        [WebMethod(EnableSession = true)]
        public string TempProfile()
        {
            List<Info> lst = new List<Info>();
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            try
            {
                string searchID = Session["newProfile"].ToString();

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select * from profileTable where userEmail = '" + searchID + "';";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        string email = rd[0].ToString().Trim() ?? "";
                        string firstName = rd[1].ToString().Trim() ?? "";
                        string lastName = rd[2].ToString().Trim() ?? "";
                        string currentPosition = rd[3].ToString().Trim() ?? "";
                        string edu_or_cert = rd[4].ToString().Trim() ?? "";
                        string userCity = rd[5].ToString().Trim() ?? "";
                        string userState = rd[6].ToString().Trim() ?? "";
                        string userCountry = rd[7].ToString().Trim() ?? "";
                        string goals = rd[8].ToString().Trim() ?? "";
                        string skills = rd[9].ToString().Trim() ?? "";
                        string experience = rd[10].ToString().Trim() ?? "";
                        string userAvailability = rd[11].ToString().Trim() ?? "";
                        lst.Add(new Info(email, firstName, lastName, currentPosition, edu_or_cert, userCity, userState, userCountry, goals, skills, experience, userAvailability));
                    }

                    string str = new JavaScriptSerializer().Serialize(lst);
                    return str;
                    //while (rd.Read())
                    //{
                    //    //object binaryData = rd[0];
                    //    //byte[] bytes = (byte[])binaryData;
                    //    //string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);


                    //    // mainImage.ImageUrl = "data:image/jpg;base64," + base64String;

                    //}
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }


        }

        [WebMethod(EnableSession = true)]
        public bool EditProfile(string firstName, string lastName, string position, string cert, string city, string state, string country, string avail, string experience, string skills, string goals)
        {
            string searchID = Session["id"].ToString();
            //again, this is either gonna work or it won't.  We return this flag to let them
            //know if account creation was successful
            bool success = false;
            string sqlConnectString = ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            string sqlSelect = "UPDATE profileTable Set firstName = @firstName, lastname = @lastName, currentPosition = @position, edu_or_cert = @cert, userCity = @city, userState = @state, userCountry = @country, userAvailability = @avail, experience = @experience, skills = @skills, goals = @goals where userEmail IN (select userEmail from login where userID = " + searchID + ");";


            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);

            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

            sqlCommand.Parameters.Add("@firstName", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@firstName"].Value = HttpUtility.UrlDecode(firstName);
            sqlCommand.Parameters.Add("@lastName", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@lastName"].Value = HttpUtility.UrlDecode(lastName);
            sqlCommand.Parameters.Add("@position", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@position"].Value = HttpUtility.UrlDecode(position);
            sqlCommand.Parameters.Add("@cert", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@cert"].Value = HttpUtility.UrlDecode(cert);
            sqlCommand.Parameters.Add("@city", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@city"].Value = HttpUtility.UrlDecode(city);
            sqlCommand.Parameters.Add("@state", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@state"].Value = HttpUtility.UrlDecode(state);
            sqlCommand.Parameters.Add("@country", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@country"].Value = HttpUtility.UrlDecode(country);
            sqlCommand.Parameters.Add("@avail", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@avail"].Value = HttpUtility.UrlDecode(avail);
            sqlCommand.Parameters.Add("@experience", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@experience"].Value = HttpUtility.UrlDecode(experience);
            sqlCommand.Parameters.Add("@skills", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@skills"].Value = HttpUtility.UrlDecode(skills);
            sqlCommand.Parameters.Add("@goals", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@goals"].Value = HttpUtility.UrlDecode(goals);

            //this time, we're not using a data adapter to fill a data table.  We're just
            //opening the connection, telling our command to "executescalar" which says basically
            //execute the query and just hand me back the number the query returns (the ID, remember?).
            //don't forget to close the connection!
            sqlConnection.Open();
            //we're using a try/catch so that if the query errors out we can handle it gracefully
            //by closing the connection and moving on
            try
            {
                sqlCommand.ExecuteNonQuery();

                success = true;
            }
            catch
            {

                success = false;
            }


            sqlConnection.Close();

            return success;
        }

        [WebMethod(EnableSession = true)]
        public bool CheckMeetup(string code, string email)
        {

            bool success = false;
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            try
            {
                string searchID = Session["id"].ToString();

                SqlConnection con = new SqlConnection();
                con.ConnectionString = ConfigurationManager.ConnectionStrings["myDB"].ToString();
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Select userEmail from login where userId = " + code + ";";
                cmd.Connection = con;
                SqlDataReader rd = cmd.ExecuteReader();



                if (rd.HasRows)
                {
                    while (rd.Read())
                    {
                        try
                        {
                            string tmpEmail = rd[0].ToString();

                            if (tmpEmail == email)
                            {
                                string sqlConnectString = ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;

                                string sqlSelect = "UPDATE meetings Set haveMet = 1 where meetingID IN (select meetingId from bridge_meetings_Profile where userEmail = '"+ tmpEmail + "');";

                                SqlConnection sqlConnection = new SqlConnection(sqlConnectString);

                                SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

                                sqlConnection.Open();
                                //we're using a try/catch so that if the query errors out we can handle it gracefully
                                //by closing the connection and moving on
                                try
                                {
                                    sqlCommand.ExecuteNonQuery();

                                    success = true;
                                }
                                catch
                                {

                                    success = false;
                                }
                            }
                            else
                            {
                                return false;
                            }

                        }
                        catch
                        {
                            return false;
                        }

                    }
                }
                else
                {
                    return false;
                }
            }
            catch
            {
                return false;
            }

            return success;


        }

        [WebMethod(EnableSession = true)]
        public bool UpdateMatch(string code)
        {
            string searchID = Session["id"].ToString();
            //again, this is either gonna work or it won't.  We return this flag to let them
            //know if account creation was successful
            bool success = false;
            string sqlConnectString = ConfigurationManager.ConnectionStrings["myDB"].ConnectionString;
            //the only thing fancy about this query is SELECT SCOPE_IDENTITY() at the end.  All that
            //does is tell sql server to return the primary key of the last inserted row.
            //we want this, because if the account gets created we will automatically
            //log them on by storing their id in the session.  That's just a design choice.  You could
            //decide that after they create an account they still have to log on seperately.  Whatevs.
            string sqlSelect = "UPDATE meetings Set haveMet = 1 where meetingID = @code ;";


            SqlConnection sqlConnection = new SqlConnection(sqlConnectString);

            SqlCommand sqlCommand = new SqlCommand(sqlSelect, sqlConnection);

            sqlCommand.Parameters.Add("@code", System.Data.SqlDbType.NVarChar);
            sqlCommand.Parameters["@code"].Value = HttpUtility.UrlDecode(code);

            //this time, we're not using a data adapter to fill a data table.  We're just
            //opening the connection, telling our command to "executescalar" which says basically
            //execute the query and just hand me back the number the query returns (the ID, remember?).
            //don't forget to close the connection!
            sqlConnection.Open();
            //we're using a try/catch so that if the query errors out we can handle it gracefully
            //by closing the connection and moving on
            try
            {
                sqlCommand.ExecuteNonQuery();

                success = true;
            }
            catch
            {

                success = false;
            }


            sqlConnection.Close();

            return success;
        }
    }
}