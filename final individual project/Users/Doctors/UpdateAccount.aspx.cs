using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Doctors
{
    public partial class UpdateAccount : System.Web.UI.Page
    {
        string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FirstNameTextbox.Text = Session["firstname"].ToString();
                LastNameTextbox.Text = Session["lastname"].ToString();
                UsernameTextbox.Text = Session["username"].ToString();
                PasswordTextbox.Text = Session["password"].ToString();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {


                string updateStmt = "UPDATE Doctors SET first_name = @firstname, last_name = @lastname WHERE id = @id";
                string updateUserStmt = "UPDATE Users SET username = @username, password = @password WHERE Id = @userid";
                using (SqlConnection conn = new SqlConnection(sqlConnectionString))
                {
                    conn.Open();

                    using (SqlCommand command = new SqlCommand(updateStmt, conn))
                    {
                        command.Parameters.AddWithValue("@id", Session["id"]);
                        command.Parameters.AddWithValue("@firstname", FirstNameTextbox.Text);
                        command.Parameters.AddWithValue("@lastname", LastNameTextbox.Text);
                       
                        command.ExecuteNonQuery();
                    }

                    using (SqlCommand cmd = new SqlCommand(updateUserStmt, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", UsernameTextbox.Text);
                        cmd.Parameters.AddWithValue("@password", PasswordTextbox.Text);

                        cmd.Parameters.AddWithValue("@userid", Session["user_id"]);

                        cmd.ExecuteNonQuery();
                    }
                    Session["firstname"] = FirstNameTextbox.Text;
                    Session["lastname"] = LastNameTextbox.Text;
                    Session["username"] = UsernameTextbox.Text;
                    Session["password"] = PasswordTextbox.Text;

                    UpdateLabel.Text = "Update Successful";
                }
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


            checkUserExistsCmd.Parameters.AddWithValue("@username", UsernameTextbox.Text);

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
       
    }
}