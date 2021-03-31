using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Doctors
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           
            DataView dv = (DataView)NumOfAppointmentsDataSource.Select(DataSourceSelectArguments.Empty);
            DataRowView drv = dv[0];
            NumTodayLabel.Text = drv[0].ToString();

            DataView dataview = (DataView)NumOfFutureAppointmentsDataSource.Select(DataSourceSelectArguments.Empty);
            DataRowView datarowview = dataview[0];
            FutureAppointmentLabel.Text = datarowview[0].ToString();


            

           
        }
    }
}