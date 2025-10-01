using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace ASPNET.IdeaWeb.Cms
{

    //*********************************************************************
    //
    // Security Class
    //
    // The Security class encapsulates two helper methods that enable
    // developers to easily check the role status of the current browser client.
    //
    //*********************************************************************

    public class Security
    {

        //*********************************************************************
        //
        // Security.Encrypt() Method
        //
        // The Encrypt method encrypts a clean string into a hashed string
        //
        //*********************************************************************

        public static string Encrypt(string cleanString)
        {
            Byte[] clearBytes = new UnicodeEncoding().GetBytes(cleanString);
            Byte[] hashedBytes = ((HashAlgorithm)CryptoConfig.CreateFromName("MD5")).ComputeHash(clearBytes);

            return BitConverter.ToString(hashedBytes);
        }

        //*********************************************************************
        //
        // Security.IsInRole() Method
        //
        // The IsInRole method enables developers to easily check the role
        // status of the current browser client.
        //
        //*********************************************************************

        public static bool IsInRole(String role)
        {

            return HttpContext.Current.User.IsInRole(role);
        }

        //*********************************************************************
        //
        // Security.IsInRoles() Method
        //
        // The IsInRoles method enables developers to easily check the role
        // status of the current browser client against an array of roles
        //
        //*********************************************************************

        public static bool IsInRoles(String roles)
        {

            HttpContext context = HttpContext.Current;

            foreach (String role in roles.Split(new char[] { ';' }))
            {

                if (role != "" && role != null && ((role == "All Users") || (context.User.IsInRole(role))))
                {
                    return true;
                }
            }

            return false;
        }

        public static void ClearSecurityCoockies(HttpResponse Response)
        {

            // Invalidate roles token
            Response.Cookies["portalroles"].Value = null;
            Response.Cookies["portalroles"].Expires = new System.DateTime(1999, 10, 12);
            Response.Cookies["portalroles"].Path = "/";
            Response.Cookies["ASPNETCommerce_FullName"].Value = null;
            Response.Cookies["ASPNETCommerce_FullName"].Expires = new System.DateTime(1999, 10, 12);

        }
    }

    public class User
    {
        public int UserId;
        public String FullName;
        public String Password;
        public String eMail;
        public String FullAddress;
        public String Phone;
        public String Note;
        public String PartitaIVA;
        public String CodiceFiscale;
    }


    //*********************************************************************
    //
    // UsersDB Class
    //
    // The UsersDB class encapsulates all data logic necessary to add/login/query
    // users within the Portal Users database.
    //
    // Important Note: The UsersDB class is only used when forms-based cookie
    // authentication is enabled within the portal.  When windows based
    // authentication is used instead, then either the Windows SAM or Active Directory
    // is used to store and validate all username/password credentials.
    //
    //*********************************************************************

    public class UsersDB
    {

        //*********************************************************************
        //
        // UsersDB.AddUser() Method <a name="AddUser"></a>
        //
        // The AddUser method inserts a new user record into the "Users" database table.
        //
        // Other relevant sources:
        //     + <a href="AddUser.htm" style="color:green">AddUser Stored Procedure</a>
        //
        //*********************************************************************

        public int AddUser(User UserToAdd)
        {
            // Create Instance of Connection 
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            // PL
            OleDbCommand myCommand = myConnection.CreateCommand();
            myCommand.CommandText = "INSERT INTO Global_Users "
                                  + "([FullName], [Password], [Email], [FullAddress],[Phone],[Note],[PartitaIVA],[CodiceFiscale]) "
                                  + " VALUES "
                                  + "('" + UserToAdd.FullName + "',"
                                  + " '" + UserToAdd.Password + "',"
                                  + " '" + UserToAdd.eMail + "',"
                                  + " '" + UserToAdd.FullAddress + "',"
                                  + " '" + UserToAdd.Phone + "',"
                                  + " '" + UserToAdd.Note + "',"
                                  + " '" + UserToAdd.PartitaIVA + "',"
                                  + " '" + UserToAdd.CodiceFiscale + "');";

            try
            {
                myConnection.Open();
                myCommand.ExecuteNonQuery();

            }
            catch
            {
                // failed to create a new user
                return -1;
            }
            try
            {
                // PL Recupero ID appena generato basandomi sulla CreatedDate
                // appena impostata con la INSERT INTO
                UserToAdd.UserId = -1;
                myCommand.CommandText = "SELECT @@IDENTITY "
                                      + "FROM Global_Users "
                                      + "WHERE [Email] = '" + UserToAdd.eMail + "';";

                OleDbDataReader reader = myCommand.ExecuteReader();
                if (reader.Read()) UserToAdd.UserId = (int)reader[0];
            }
            catch
            {

                return -1;

            }
            finally
            {
                myConnection.Close();
            }
            return UserToAdd.UserId;
        }

        //*********************************************************************
        //
        // UsersDB.DeleteUser() Method <a name="DeleteUser"></a>
        //
        // The DeleteUser method deleted a  user record from the "Users" database table.
        //
        // Other relevant sources:
        //     + <a href="DeleteUser.htm" style="color:green">DeleteUser Stored Procedure</a>
        //
        //*********************************************************************

        public void DeleteUser(int userId)
        {
            // Create Instance of Connection 
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);

            // PL
            OleDbCommand myCommand = myConnection.CreateCommand();
            myCommand.CommandText = "DELETE FROM Global_Users "
                                  + "WHERE UserID = " + userId.ToString() + ";";
            myConnection.Open();
            myCommand.ExecuteNonQuery();

            myCommand.CommandText = "DELETE FROM Global_UserRoles "
                                  + "WHERE UserID = " + userId.ToString() + ";";
            myCommand.ExecuteNonQuery();

            myConnection.Close();
        }

        //*********************************************************************
        //
        // UsersDB.UpdateUser() Method <a name="DeleteUser"></a>
        //
        // The UpdateUser method deleted a  user record from the "Users" database table.
        //
        // Other relevant sources:
        //     + <a href="UpdateUser.htm" style="color:green">UpdateUser Stored Procedure</a>
        //
        //*********************************************************************

        public void UpdateUser(User UsertoUpdate)
        {
            // PL
            // Create Instance of Connection 
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();

            myCmd.CommandText = "UPDATE Global_Users "
                              + "SET [FullName] = '" + UsertoUpdate.FullName + "',"
                              + "    [Password] = '" + UsertoUpdate.Password + "',"
                              + "    [Email] = '" + UsertoUpdate.eMail + "',"
                              + "    [FullAddress] = '" + UsertoUpdate.FullAddress + "',"
                              + "    [Phone] = '" + UsertoUpdate.Phone + "',"
                              + "    [Note] = '" + UsertoUpdate.Note + "',"
                              + "    [PartitaIVA] = '" + UsertoUpdate.PartitaIVA + "',"
                              + "    [CodiceFiscale] = '" + UsertoUpdate.CodiceFiscale + "'"
                              + "  WHERE [UserID] = " + UsertoUpdate.UserId.ToString() + ";";

            myConnection.Open();
            myCmd.ExecuteNonQuery();
            myConnection.Close();
        }

        //*********************************************************************
        //
        // UsersDB.GetRolesByUser() Method <a name="GetRolesByUser"></a>
        //
        // The DeleteUser method deleted a  user record from the "Users" database table.
        //
        // Other relevant sources:
        //     + <a href="GetRolesByUser.htm" style="color:green">GetRolesByUser Stored Procedure</a>
        //
        //*********************************************************************

        public OleDbDataReader GetRolesByUser(String eMail)
        {

            // Create Instance of Connection and Command Object
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();

            myCmd.CommandText =
                            "SELECT Global_Roles.RoleName, "
                          + "       Global_Roles.RoleID "
                          + "FROM (Global_UserRoles "
                          + "       INNER JOIN "
                          + "     Global_Users "
                          + "          ON      "
                          + "     (Global_UserRoles.UserID = Global_Users.UserID)) "
                          + "       INNER JOIN "
                          + "     Global_Roles "
                          + "          ON      "
                          + "     (Global_UserRoles.RoleID = Global_Roles.RoleID) "
                          + "WHERE Global_Users.EMail = '" + eMail + "';";


            // Esegue il comando
            myConnection.Open();
            OleDbDataReader result = myCmd.ExecuteReader(CommandBehavior.CloseConnection);

            // Return the datareader 
            return result;
        }

        //*********************************************************************
        //
        // GetSingleUser Method
        //
        // The GetSingleUser method returns a SqlDataReader containing details
        // about a specific user from the Users database table.
        //
        //*********************************************************************

        public User GetSingleUser(String eMail)
        {

            // Create Instance of Connection and Command Object
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();
            ASPNET.IdeaWeb.Cms.User result = new ASPNET.IdeaWeb.Cms.User();

            myCmd.CommandText =
                            "SELECT UserID, FullName, Password, EMail, FullAddress, Phone, Note, PartitaIVA, CodiceFiscale "
                          + "  FROM Global_Users "
                          + " WHERE Email = '" + eMail + "';";


            // Esegue il comando
            myConnection.Open();
            OleDbDataReader reader = myCmd.ExecuteReader(CommandBehavior.CloseConnection);
            if (reader.Read())
            {
                result.UserId = (int)reader["UserID"];
                result.FullName = reader["FullName"].ToString();
                result.Password = reader["Password"].ToString();
                result.eMail = eMail;
                result.FullAddress = reader["FullAddress"].ToString();
                result.Phone = reader["Phone"].ToString();
                result.Note = reader["Note"].ToString();
                result.PartitaIVA = reader["PartitaIVA"].ToString();
                result.CodiceFiscale = reader["CodiceFiscale"].ToString();
            }

            reader.Close();
            myConnection.Close();

            return result;
        }

        public User GetSingleUserByID(String UserID)
        {

            // Create Instance of Connection and Command Object
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();
            ASPNET.IdeaWeb.Cms.User result = new ASPNET.IdeaWeb.Cms.User();

            myCmd.CommandText =
                            "SELECT UserID, FullName, Password, EMail, FullAddress, Phone, Note, PartitaIVA, CodiceFiscale "
                          + "  FROM Global_Users "
                          + " WHERE UserID = " + UserID + ";";


            // Esegue il comando
            myConnection.Open();
            OleDbDataReader reader = myCmd.ExecuteReader(CommandBehavior.CloseConnection);
            if (reader.Read())
            {
                result.UserId = (int)reader["UserID"];
                result.FullName = reader["FullName"].ToString();
                result.Password = reader["Password"].ToString();
                result.eMail = reader["EMail"].ToString();
                result.FullAddress = reader["FullAddress"].ToString();
                result.Phone = reader["Phone"].ToString();
                result.Note = reader["Note"].ToString();
                result.PartitaIVA = reader["PartitaIVA"].ToString();
                result.CodiceFiscale = reader["CodiceFiscale"].ToString();
            }

            reader.Close();
            myConnection.Close();

            return result;
        }

        //*********************************************************************
        //
        // GetRoles() Method <a name="GetRoles"></a>
        //
        // The GetRoles method returns a list of role names for the user.
        //
        // Other relevant sources:
        //     + <a href="GetRolesByUser.htm" style="color:green">GetRolesByUser Stored Procedure</a>
        //
        //*********************************************************************

        public String[] GetRoles(String eMail)
        {

            // Create Instance of Connection and Command Object
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();

            myCmd.CommandText =
                            "SELECT Global_Roles.RoleName, "
                          + "       Global_Roles.RoleID "
                          + "FROM (Global_UserRoles "
                          + "       INNER JOIN "
                          + "     Global_Users "
                          + "          ON      "
                          + "     (Global_UserRoles.UserID = Global_Users.UserID)) "
                          + "       INNER JOIN "
                          + "     Global_Roles "
                          + "          ON      "
                          + "     (Global_UserRoles.RoleID = Global_Roles.RoleID) "
                          + "WHERE Global_Users.EMail = '" + eMail + "';";                          

            // Esegue il comando
            myConnection.Open();
            OleDbDataReader dr = myCmd.ExecuteReader(CommandBehavior.CloseConnection);

            // create a String array from the data
            ArrayList userRoles = new ArrayList();

            while (dr.Read())
            {
                userRoles.Add(dr["RoleName"]);
            }

            dr.Close();

            // Return the String array of roles
            return (String[])userRoles.ToArray(typeof(String));
        }

        public String[] GetRolesByUserId(String UserID)
        {

            // Create Instance of Connection and Command Object
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();

            myCmd.CommandText =
                            "SELECT Global_Roles.RoleName, "
                          + "       Global_Roles.RoleID "
                          + "FROM (Global_UserRoles "
                          + "       INNER JOIN "
                          + "     Global_Users "
                          + "          ON      "
                          + "     (Global_UserRoles.UserID = Global_Users.UserID)) "
                          + "       INNER JOIN "
                          + "     Global_Roles "
                          + "          ON      "
                          + "     (Global_UserRoles.RoleID = Global_Roles.RoleID) "
                          + "WHERE Global_Users.UserID = " + UserID + ";";

            // Esegue il comando
            myConnection.Open();
            OleDbDataReader dr = myCmd.ExecuteReader(CommandBehavior.CloseConnection);

            // create a String array from the data
            ArrayList userRoles = new ArrayList();

            while (dr.Read())
            {
                userRoles.Add(dr["RoleName"]);
            }

            dr.Close();

            // Return the String array of roles
            return (String[])userRoles.ToArray(typeof(String));
        }
        
        //*********************************************************************
        //
        // UsersDB.Login() Method <a name="Login"></a>
        //
        // The Login method validates a email/password pair against credentials
        // stored in the users database.  If the email/password pair is valid,
        // the method returns user's name.
        //
        // Other relevant sources:
        //     + <a href="UserLogin.htm" style="color:green">UserLogin Stored Procedure</a>
        //
        //*********************************************************************

        public User Login(String eMail, String password)
        {

            // Create Instance of Connection and Command Object
            OleDbConnection myConnection = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringAccessIdeaWebCms"].ConnectionString);
            OleDbCommand myCmd = myConnection.CreateCommand();
            User result = new User();

            result.UserId = -1;
            result.FullName = String.Empty;

            myCmd.CommandText =
                            "SELECT UserID, FullName, Password, EMail "
                          + "  FROM Global_Users "
                          + " WHERE Email = '" + eMail + "'"
                          + "   AND Password = '" + password + "';";

            // Esegue il comando
            myConnection.Open();
            OleDbDataReader dr = myCmd.ExecuteReader(CommandBehavior.CloseConnection);

            // Return the datareader 
            if (dr.Read() && !(dr[0] is DBNull))
            {
                result.UserId = (int)dr["UserID"];
                result.FullName = dr["FullName"].ToString();
                result.Password = dr["Password"].ToString();
                result.eMail = dr["Email"].ToString();
            }

            dr.Close();
            myConnection.Close();

            return result;
        }



    }
}