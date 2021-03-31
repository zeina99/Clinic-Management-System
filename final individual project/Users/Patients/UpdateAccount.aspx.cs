using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Patients
{
    public partial class UpdateAccount : System.Web.UI.Page
    {
        string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            //DataView dv = (DataView)PatientDataSource.Select(DataSourceSelectArguments.Empty);
            //DataRowView drv = dv[0];
            if (!IsPostBack)
            {

           
                username_textbox.Text = (string)Session["username"]; // or try using Session
                First_Name_Textbox.Text = Session["firstname"].ToString();
                Last_Name_Textbox.Text = Session["lastname"].ToString();
                Address_TextBox.Text = Session["address"].ToString();
                DOB_TextBox.Text = Session["DOB"].ToString();
                password_textbox.Text = Session["password"].ToString();
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

        //protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        //{
        //    if (CheckIfUserExists())
        //    {
        //        args.IsValid = false;
        //    }
        //    else
        //    {
        //        args.IsValid = true;
        //    }
        //}

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

            
                string updateStmt = "UPDATE Patients SET first_name = @firstname, last_name = @lastname, [Date of birth] = @dob, Address = @address WHERE id = @id";
                string updateUserStmt = "UPDATE Users SET username = @username, password = @password WHERE Id = @userid";
                using (SqlConnection conn = new SqlConnection(sqlConnectionString))
                {
                    conn.Open();

                    using(SqlCommand command = new SqlCommand(updateStmt, conn))
                    {
                        command.Parameters.AddWithValue("@id", Session["id"]);
                        command.Parameters.AddWithValue("@firstname", First_Name_Textbox.Text);
                        command.Parameters.AddWithValue("@lastname", Last_Name_Textbox.Text);
                        command.Parameters.AddWithValue("@dob", DOB_TextBox.Text);
                        command.Parameters.AddWithValue("@address", Address_TextBox.Text);

                        command.ExecuteNonQuery();
                    }

                    using(SqlCommand cmd = new SqlCommand(updateUserStmt, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username_textbox.Text);
                        cmd.Parameters.AddWithValue("@password", password_textbox.Text);

                        cmd.Parameters.AddWithValue("@userid", Session["user_id"]);

                        cmd.ExecuteNonQuery();
                    }

                    Session["firstname"] = First_Name_Textbox.Text;
                    Session["lastname"] = Last_Name_Textbox.Text;
                    Session["address"] = Address_TextBox.Text;
                    Session["DOB"] = DOB_TextBox.Text;
                    Session["username"] = username_textbox.Text;
                    Session["password"] = password_textbox.Text;

                    UpdateLabel.Text = "Update Successful";
                }
            }
        }
    }
}