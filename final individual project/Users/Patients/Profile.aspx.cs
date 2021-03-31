using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Patients
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            DataRowView drv = dv[0];

            UsernameLabel.Text = drv["username"].ToString();
            PasswordLabel.Text = drv["password"].ToString();
            DOBLabel.Text = Convert.ToDateTime(drv["Date of birth"]).ToShortDateString();
            FirstNameLabel.Text = drv["first_name"].ToString();
            lastnameLabel.Text = drv["last_name"].ToString();
            addressLabel.Text = drv["Address"].ToString();

        }
    }
}