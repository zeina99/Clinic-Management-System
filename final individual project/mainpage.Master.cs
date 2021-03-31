using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project
{
    public partial class mainpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateLabel.Text = DateTime.Now.ToShortDateString();

            try
            {
                patientName.Text = Session["firstname"].ToString() + " " + Session["lastname"];
            }
            catch (NullReferenceException)
            {

            }
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("../../Login.aspx");
        }
    }
}