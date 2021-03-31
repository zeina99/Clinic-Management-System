using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataView dv = (DataView)NumOfDoctorsDataSource.Select(DataSourceSelectArguments.Empty);
            DataRowView drv = dv[0];
            DoctorsNumLabel.Text = drv[0].ToString();

            DataView dv2 = (DataView)NumOfPatientsDataSource.Select(DataSourceSelectArguments.Empty);
            DataRowView drv2 = dv2[0];
            PatientsNumLabel.Text = drv2[0].ToString();

            DataView dv3 = (DataView)NumOfAppointmentsTodayDataSource.Select(DataSourceSelectArguments.Empty);
            DataRowView drv3 = dv3[0];
            AppointmentLabel.Text = drv3[0].ToString();


        }
    }
}