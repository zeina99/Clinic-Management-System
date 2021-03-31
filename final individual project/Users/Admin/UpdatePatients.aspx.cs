using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Admin
{
    public partial class UpdatePatients : System.Web.UI.Page
    {
        string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            
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

        protected void AddPatientButton_Click(object sender, EventArgs e)
        {
            int patient_userId;


            string sqlUserInsert = "INSERT INTO Users OUTPUT INSERTED.Id VALUES(@username, @password, @user_type) ";
            string insertPatient = "INSERT INTO Patients VALUES(@firstname, @lastname,@dob, @address, @user_id)";

            if (Page.IsValid)
            {


                using (SqlConnection conn = new SqlConnection(sqlConnectionString))
                {
                    conn.Open();

                    SqlCommand userInsertCmd = new SqlCommand(sqlUserInsert, conn);

                    userInsertCmd.Parameters.AddWithValue("@username", username_textbox.Text);
                    userInsertCmd.Parameters.AddWithValue("@password", password_textbox.Text);
                    userInsertCmd.Parameters.AddWithValue("@user_type", "Patient");


                    using (SqlDataReader dataReader = userInsertCmd.ExecuteReader())
                    {

                        dataReader.Read();

                        patient_userId = Convert.ToInt32(dataReader["Id"]);


                    }

                    using (SqlCommand doctorInsertCmd = new SqlCommand(insertPatient, conn))
                    {
                        doctorInsertCmd.Parameters.AddWithValue("@firstname", First_Name_Textbox.Text);
                        doctorInsertCmd.Parameters.AddWithValue("@lastname", Last_Name_Textbox.Text);
                        doctorInsertCmd.Parameters.AddWithValue("@dob", DOB_TextBox.Text);
                        doctorInsertCmd.Parameters.AddWithValue("@address", Address_TextBox.Text);
                        doctorInsertCmd.Parameters.AddWithValue("@user_id", patient_userId);

                        doctorInsertCmd.ExecuteNonQuery();

                        successLabel.Text = "Patient inserted successfully";

                    }


                }

                AllPatients.EnableCaching = false;
                GridView1.DataBind();
                AllPatients.EnableCaching = true;
            }
        }
    }
}