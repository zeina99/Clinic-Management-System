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
    public partial class UpdateDoctors : System.Web.UI.Page
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            // inserting a new doctor to the db 
            // insert user, get user_id
            // insert into doctors db
            int doctor_user_id;


            string sqlUserInsert = "INSERT INTO Users OUTPUT INSERTED.Id VALUES(@username, @password, @user_type) ";
            string insertDoc = "INSERT INTO Doctors VALUES(@firstname, @lastname, @user_id)";

            if (Page.IsValid)
            {


                using (SqlConnection conn = new SqlConnection(sqlConnectionString))
                {
                    conn.Open();

                    SqlCommand userInsertCmd = new SqlCommand(sqlUserInsert, conn);

                    userInsertCmd.Parameters.AddWithValue("@username", username_textbox.Text);
                    userInsertCmd.Parameters.AddWithValue("@password", password_textbox.Text);
                    userInsertCmd.Parameters.AddWithValue("@user_type", "Doctor");


                    using (SqlDataReader dataReader = userInsertCmd.ExecuteReader())
                    {

                        dataReader.Read();

                        doctor_user_id = Convert.ToInt32(dataReader["Id"]);


                    }

                    using (SqlCommand doctorInsertCmd = new SqlCommand(insertDoc, conn))
                    {
                        doctorInsertCmd.Parameters.AddWithValue("@firstname", First_Name_Textbox.Text);
                        doctorInsertCmd.Parameters.AddWithValue("@lastname", Last_Name_Textbox.Text);
                        doctorInsertCmd.Parameters.AddWithValue("@user_id", doctor_user_id);

                        doctorInsertCmd.ExecuteNonQuery();

                        successLabel.Text = "Doctor inserted successfully";
                    }


                }
                AllDoctors.EnableCaching = false;
                GridView1.DataBind();
                AllDoctors.EnableCaching = true;
            }
        }
        private void bindGridData()
        {

        }
    }
}