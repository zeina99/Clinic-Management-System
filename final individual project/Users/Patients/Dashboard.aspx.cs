using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Patients
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //TodayAppointmentSqlDataSource.SelectParameters["booking_date"].DefaultValue = DateTime.Now.ToShortDateString();



                DataView dv = (DataView)NumAppointmentsToday.Select(DataSourceSelectArguments.Empty);
                DataRowView drv = dv[0];
                TodayAppLabel.Text = drv[0].ToString();

                DataView dataview = (DataView)NumOfFutureAppointmentsDataSource.Select(DataSourceSelectArguments.Empty);
                DataRowView datarowview = dataview[0];
                FutureAppointmentLabel.Text = datarowview[0].ToString();


                DataView dataview2 = (DataView)NumPendingSqlDataSource1.Select(DataSourceSelectArguments.Empty);
                DataRowView datarowview2 = dataview2[0];
                PendingLabel.Text = datarowview2[0].ToString();

                DataView dataview3 = (DataView)NumRejectedDataSource.Select(DataSourceSelectArguments.Empty);
                DataRowView datarowview3 = dataview3[0];
                RejectedLabel.Text = datarowview3[0].ToString();

            
        }
    }
}