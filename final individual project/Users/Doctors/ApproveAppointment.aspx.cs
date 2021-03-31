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
    public partial class ApproveAppointment : System.Web.UI.Page
    {
        string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            // updatee
            string updateStmt = "UPDATE Bookings SET status = @status WHERE Id = @id";
            using(SqlConnection conn = new SqlConnection(sqlConnectionString))
            {
                conn.Open();
                using(SqlCommand sqlCommand = new SqlCommand(updateStmt, conn))
                {
                    sqlCommand.Parameters.AddWithValue("@status", DropDownList1.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@id", DropDownList2.SelectedValue);

                    sqlCommand.ExecuteNonQuery();

                    SuccessLabel.Text = "Update Successful";

                    SqlDataSource1.EnableCaching = false;
                    GridView1.DataBind();
                    SqlDataSource1.EnableCaching = true;
                }
            }
        }
    }
}