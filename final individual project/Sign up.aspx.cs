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
    public partial class Sign_up : System.Web.UI.Page
    {
        SqlCommand userInsertCmd;
        SqlCommand patientInsertCmd;
        SqlConnection conn;
        
        string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {


            string sqlPatientInsert = "INSERT INTO Patients VALUES(@firstname, @lastname, @dob, @address, @user_id)";
            string sqlUserInsert = "INSERT INTO Users OUTPUT INSERTED.Id VALUES(@username, @password, @user_type) ";



            if (Page.IsValid)
            {


                conn = new SqlConnection(sqlConnectionString);
                conn.Open();


                string firstname = First_Name_Textbox.Text;
                string lastname = Last_Name_Textbox.Text;
                string dob = DOB_TextBox.Text;
                string address = Address_TextBox.Text;
                string username = username_textbox.Text;
                string password = password_textbox.Text;




                // inserting into Users table
                userInsertCmd = new SqlCommand(sqlUserInsert, conn);
                userInsertCmd.Parameters.AddWithValue("@username", username);
                userInsertCmd.Parameters.AddWithValue("@password", password);
                userInsertCmd.Parameters.AddWithValue("@user_type", "Patient");

                // inserting into db and getting the generated user id
                Session["user_id"] = Convert.ToInt32(userInsertCmd.ExecuteScalar());


                // inserting into Patients table
                patientInsertCmd = new SqlCommand(sqlPatientInsert, conn);
                patientInsertCmd.Parameters.AddWithValue("@firstname", firstname);
                patientInsertCmd.Parameters.AddWithValue("@lastname", lastname);
                patientInsertCmd.Parameters.AddWithValue("@dob", dob);
                patientInsertCmd.Parameters.AddWithValue("@address", address);

                patientInsertCmd.Parameters.AddWithValue("@user_id", Session["user_id"].ToString());
                patientInsertCmd.ExecuteNonQuery();




                conn.Close();

                signupSuccessful.Text = "Sign Up Successful";

                // saving session variables
                Session["firstname"] = firstname;
                Session["lastname"] = lastname;
                Session["address"] = address;
                Session["dob"] = dob;
                Session["username"] = username;
                Session["password"] = password;

                Response.Redirect("Users/Patients/Dashboard.aspx");

            }
        }
        private bool CheckIfUserExists()
        {
            SqlConnection conn = new SqlConnection(sqlConnectionString);
            conn.Open();

            string checkUsernameExistsStmt = "SELECT * FROM Users WHERE username = @username";

            SqlCommand checkUserExistsCmd = new SqlCommand(checkUsernameExistsStmt, conn)
            {
                Connection = conn
            };


            checkUserExistsCmd.Parameters.AddWithValue("@username", username_textbox.Text);

            SqlDataReader dataReader = checkUserExistsCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);



            if (dataReader.HasRows)
            {
                conn.Close();
                return true;
            }
            else
            {
                conn.Close();
                return false;
            }
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (CheckIfUserExists())
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
    }
}