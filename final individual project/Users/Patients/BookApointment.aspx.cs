using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace final_individual_project.Users.Patients
{

    public partial class BookApointment : System.Web.UI.Page
    {
        string sqlConnectionString = ConfigurationManager.ConnectionStrings["ClinicConnection"].ConnectionString;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TimeSlots.Items.Clear();
                PopulateTimeSlotList();
            }
           
        }

        private void PopulateTimeSlotList()
        {
           
            string zerominutes = "00";
            string thirtyminutes = "30";
            string minutes = zerominutes;
            int startHour = 10;
            for(int i = 0; i < 16; i++)
            {
                if (i % 2 == 0 && i != 0)
                {
                    startHour++;
                }
                TimeSlots.Items.Add(new ListItem(startHour + ":" + minutes, startHour + ":" + minutes));
               if(minutes == zerominutes)
                {
                    minutes = thirtyminutes;
                }
                else
                {
                    minutes = zerominutes;
                }


            }
            
        }

        protected void BookAppointmentButton_Click(object sender, EventArgs e)
        {
            string timeslotStart = TimeSlots.SelectedValue;
            // check if row is selected in grid
            if (!validateGridViewSelection())
            {
                GridValidation.Text = "You must select a doctor";
            }

            // page valid/inavlid set from customvalidator which is set for timeslot checking
            else if (!TimeslotIsTaken())
            {
                if (Page.IsValid)
                {

                    GridValidation.Text = "";

                    string insertBooking = "INSERT INTO Bookings VALUES(@patientid, @doctorid, @reason, @slotStart, @slotEnd, @status, @booking_date)";
                    using (SqlConnection conn = new SqlConnection(sqlConnectionString))
                    {
                        conn.Open();

                        using(SqlCommand command = new SqlCommand(insertBooking, conn))
                        {

                            command.Parameters.AddWithValue("@patientid", Session["id"]);
                            command.Parameters.AddWithValue("@doctorid", ViewState["selectedDoctorId"]);

                            command.Parameters.AddWithValue("@reason", ReasonTextBox.Text);
                            command.Parameters.AddWithValue("@slotStart", TimeSlots.SelectedValue);
                            command.Parameters.AddWithValue("@slotEnd", getSlotEnd(TimeSlots.SelectedItem.Value));
                            command.Parameters.AddWithValue("@status", "pending");
                            command.Parameters.AddWithValue("@booking_date", DateTextbox.Text);

                            command.ExecuteNonQuery();
                        }
                    }

                    BookingSuccessLabel.Text = "Booking Succesful, \nbooking is now pending, please wait for approval from the doctor";
                }
            }
            else
            {
                TimeSlotValidLabel.Text = "Timeslot is occupied by another patient!";
            }
            
            
        }

       
        private string getSlotEnd(string selectedValue)
        {
            string[] hoursMinutes = selectedValue.Split(':');
            System.Diagnostics.Debug.WriteLine(selectedValue);
            int hour = Convert.ToInt32(hoursMinutes[0]);
            // minutes are 30
            if (hoursMinutes[1] == "30")
            {
                return String.Format("{0}:00", hour + 1);
            }
            //minutes are 00
            else
            {
                return hoursMinutes[0] + ":30";
            }
        }

        protected bool TimeslotIsTaken()
        {
            bool timeSlotIsTaken = CheckIfDoctorTimeslotTaken();
            if (timeSlotIsTaken)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        private bool CheckIfPatientTimeslotTaken()
        {
            string patientTimeslotStmt = "SELECT * from Bookings WHERE patient_id = @patientid AND slot_start = @slotstart AND booking_date = @booking_date";

            string timeslot = TimeSlots.SelectedValue;

            using (SqlConnection conn = new SqlConnection(sqlConnectionString))
            {
                conn.Open();
                using(SqlCommand cmd = new SqlCommand(patientTimeslotStmt, conn))
                {
                    cmd.Parameters.AddWithValue("@patientid", Session["id"]);
                    cmd.Parameters.AddWithValue("@slotstart", timeslot);
                    cmd.Parameters.AddWithValue("@booking_date", DateTextbox.Text);

                    SqlDataReader dataReader = cmd.ExecuteReader();

                    if (dataReader.HasRows)
                        return true;
                    else return false;
                }
            }
        }

        private bool CheckIfDoctorTimeslotTaken()
        {
            //string getAllBookingsStmt2 = "SELECT * from DoctorsNBookings WHERE doctor_first_name = @firstname AND doctor_last_name = @lastname AND slot_start = @timeslotstart";
            string getAllBookingsStmt = "SELECT * from DoctorsNBookings WHERE doctor_id = @doctorid AND slot_start = @timeslotstart AND booking_date = @booking_date";
           
            // details ..
            string timeslot = TimeSlots.SelectedValue;
            
            SqlConnection conn = new SqlConnection(sqlConnectionString);
            
            using (SqlCommand sqlCommand = new SqlCommand(getAllBookingsStmt, conn))
            {
                conn.Open();

                sqlCommand.Parameters.AddWithValue("@doctorid", ViewState["selectedDoctorId"]);
                sqlCommand.Parameters.AddWithValue("@timeslotstart", timeslot);
                sqlCommand.Parameters.AddWithValue("@booking_date", DateTextbox.Text);

                SqlDataReader dataReader = sqlCommand.ExecuteReader();

                if (dataReader.HasRows)
                    return true;
                else return false;
            }            
                                                              
           
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            {
                //Check if Viewstate is null or not
                if (ViewState["PreviousRowIndex"] != null)
                {
                    //Get the Previously selected rowindex
                    var previousRowIndex = (int)ViewState["PreviousRowIndex"];
                    //Get the previously selected row
                    GridViewRow PreviousRow = GridView1.Rows[previousRowIndex];
                    //Assign back color to previously selected row
                    PreviousRow.BackColor = Color.White;
                }

                int currentRowIndex = GridView1.SelectedIndex;
                //Get the GridViewRow from Current Row Index
                GridViewRow row = GridView1.Rows[currentRowIndex];
                //Assign the Back Color to Yellow
                //Change this color as per your need
                row.BackColor = Color.Beige;
                //Assign the index as PreviousRowIndex
                ViewState["PreviousRowIndex"] = currentRowIndex;

                // global vars
                ViewState["selectedDoctorId"] = Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text);
                ViewState["selectedDoctorName"] = GridView1.SelectedRow.Cells[2].Text.Split(' ');
            }
        }

        protected bool validateGridViewSelection()
        {
            if (GridView1.SelectedIndex == -1)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (CheckIfPatientTimeslotTaken())
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
    }
}