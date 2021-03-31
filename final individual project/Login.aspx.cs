using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;

namespace final_individual_project
{
    public partial class Login : System.Web.UI.Page
    {

        SqlCommand getUserIdCommand;
        SqlCommand getUserInfoCommand;
        SqlConnection conn;
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signin_Button_Click(object sender, EventArgs e)
        {
            string patientSqlStmt = "SELECT * FROM Patients WHERE user_id = @id";
            string doctorSqlStmt = "SELECT * FROM Doctors WHERE user_id = @id";
            string AdminSqlStmt = "SELECT * FROM Admin WHERE user_id = @id";

            
            string user_type = DropDownList1.SelectedValue;

            string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;

            conn = new SqlConnection(sqlConnectionString);
            conn.Open();


            string getUserIdStmt = "SELECT Id, user_type FROM Users WHERE username = @username AND password = @password";

            getUserIdCommand = new SqlCommand(getUserIdStmt, conn);

            getUserIdCommand.Parameters.AddWithValue("@username", username_textbox.Text);
            getUserIdCommand.Parameters.AddWithValue("@password", password_textbox.Text);

            /*SqlDataReader dataReader = getUserIdCommand.ExecuteReader();*/


            bool userExists = false;
            using(SqlDataReader dataReader = getUserIdCommand.ExecuteReader())
            {
                // check if user exists
                if (!dataReader.HasRows)
                {
                    doesnotexistLabel.Text = "User does not exist";
                    userExists = false;
                }
                else
                {

                    while (dataReader.Read())
                    {
                        userExists = true;
                        System.Diagnostics.Debug.WriteLine("UserID: ", Convert.ToInt32(dataReader["Id"]));
                        Session["user_id"] = dataReader.GetInt32(0);
                        int id = (int)Session["user_id"];
                        int dataid = dataReader.GetInt32(0);
                        Session["username"] = username_textbox.Text;
                        Session["password"] = password_textbox.Text;
                        Session["user_type"] = dataReader.GetString(1);
                    }

                       
                }
            }


            if (userExists)
            {


                if (user_type == "Patient")
                {
                    if((string)Session["user_type"] != "Patient")
                    {
                        doesnotexistLabel.Text = "User does not exist as a patient";
                        return;
                    }
                    getUserInfoCommand = new SqlCommand(patientSqlStmt, conn);
                    getUserInfoCommand.Parameters.AddWithValue("@id", Session["user_id"]);
                    using (SqlDataReader patientReader = getUserInfoCommand.ExecuteReader())
                    {
                       
                        patientReader.Read();
                        Session["id"] = patientReader["Id"];
                        Session["firstname"] = patientReader["first_name"];
                        Session["lastname"] = patientReader["last_name"];
                        Session["DOB"] = patientReader["Date of Birth"];
                        Session["address"] = patientReader["Address"];
                        
                    }

                    Response.Redirect("Users/Patients/Dashboard.aspx");

                }
                else if (user_type == "Doctor")
                {
                    getUserInfoCommand = new SqlCommand(doctorSqlStmt, conn);
                    getUserInfoCommand.Parameters.AddWithValue("@id", Session["user_id"]);
                    using (SqlDataReader sqlDataReader = getUserInfoCommand.ExecuteReader())
                    {
                        if ((string)Session["user_type"] != "Doctor")
                        {
                            doesnotexistLabel.Text = "User does not exist as a Doctor";
                            return;
                        }
                       

                            while (sqlDataReader.Read())
                            {
                               
                                Session["id"] = sqlDataReader.GetInt32(0);
                                Session["firstname"] = sqlDataReader.GetString(1);
                                Session["lastname"] = sqlDataReader.GetString(2);
                            }
                        
                        
                       
                    }
                    System.Diagnostics.Debug.WriteLine("SessionID: ",Session["id"]);
                    Response.Redirect("Users/Doctors/Dashboard.aspx");

                }
                else if (user_type == "Admin")
                {
                    getUserInfoCommand = new SqlCommand(AdminSqlStmt, conn);
                    getUserInfoCommand.Parameters.AddWithValue("@id", Session["user_id"]);

                    using (SqlDataReader sqlDataReader = getUserInfoCommand.ExecuteReader())
                    {
                        try
                        {


                            while (sqlDataReader.Read())
                            {
                                Session["id"] = sqlDataReader["Id"];
                                Session["firstname"] = sqlDataReader["first_name"];
                                Session["lastname"] = sqlDataReader["last_name"];
                            }
                        }
                        catch (InvalidOperationException)
                        {
                            doesnotexistLabel.Text = "User does not exist as an Admin";
                            return;
                        }
                    }

                    Response.Redirect("Users/Admin/Dashboard.aspx");
                }



            }



            





        }
        
    }
}