<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="final_individual_project.Users.Patients.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SideBar" runat="server">


    <ul class="nav-style">
        <li> <a href="Dashboard.aspx" > Dashboard </a>  </li>
        <li> <a href="BookApointment.aspx">Book Appointment</a></li>
        
        <li><a href="Profile.aspx">Profile</a> </li>
        <li> <a href="UpdateAccount.aspx"> Update account </a></li>
    </ul>
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="patient-wrap-dashboard">
        <h2 class="patient-dashboard-title">Dashboard</h2>

        <div class="cards admin-dashboard">

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3>Appointments today (Confirmed)</h3>

                </div>

                <asp:Label CssClass="cardLabel" ID="TodayAppLabel" runat="server" Text=""></asp:Label>

            </div>

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3 >Future Appointments (Confirmed)</h3>
                </div>

                <asp:Label CssClass="cardLabel" ID="FutureAppointmentLabel" runat="server" Text=""></asp:Label>

            </div>

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3>Pending Appointments</h3>
                </div>

                <asp:Label CssClass="cardLabel" ID="PendingLabel" runat="server" Text=""></asp:Label>

            </div>

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3>Rejected Appointments</h3>
                </div>

                <asp:Label CssClass="cardLabel" ID="RejectedLabel" runat="server" Text=""></asp:Label>

            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="NumAppointmentsToday" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) From Bookings WHERE patient_id=@patientid AND booking_date = CONVERT(date, getdate()) AND status = @status">
        <SelectParameters>
            <asp:SessionParameter Name="patientid" SessionField="id" />
            <asp:Parameter DefaultValue="approved" Name="status" />
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="FutureAppointmentsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="Select * from Bookings_DoctorsPatients WHERE booking_date &gt; CONVERT(date, getdate()) AND status = 'approved' AND patient_id = @patientid">
            <SelectParameters>
                <asp:SessionParameter Name="patientid" SessionField="id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="TodayAppointmentSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT * FROM [Bookings_DoctorsPatients] WHERE ([booking_date] =CONVERT(date, getdate())) AND status = 'approved' AND patient_id = @patientid">
            <SelectParameters>
                <asp:SessionParameter Name="patientid" SessionField="id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="PendingAppointmentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT * FROM [Bookings_DoctorsPatients] WHERE (([patient_id] = @patient_id) AND ([status] = @status))">
            <SelectParameters>
                <asp:SessionParameter Name="patient_id" SessionField="id" Type="Int32" />
                <asp:Parameter DefaultValue="pending" Name="status" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="RejectedDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT * FROM [Bookings_DoctorsPatients] WHERE (([patient_id] = @patient_id) AND ([status] = @status))">
            <SelectParameters>
                <asp:SessionParameter Name="patient_id" SessionField="id" Type="Int32" />
                <asp:Parameter DefaultValue="rejected" Name="status" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="NumOfFutureAppointmentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) FROM Bookings WHERE patient_id = @patient_id AND booking_date &gt; CONVERT(date, getdate()) AND status = @status">
        <SelectParameters>
            <asp:SessionParameter Name="patient_id" SessionField="id" />
            <asp:Parameter DefaultValue="approved" Name="status" />
        </SelectParameters>
    </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="NumPendingSqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) FROM [Bookings] WHERE (([patient_id] = @patient_id) AND ([status] = @status))">
        <SelectParameters>
            <asp:SessionParameter Name="patient_id" SessionField="id" Type="Int32" />
            <asp:Parameter DefaultValue="pending" Name="status" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    

    <asp:SqlDataSource ID="NumRejectedDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' SelectCommand="SELECT COUNT(*) FROM [Bookings] WHERE (([status] = @status) AND ([patient_id] = @patient_id))">
        <SelectParameters>
            <asp:Parameter DefaultValue="rejected" Name="status"></asp:Parameter>
            <asp:SessionParameter SessionField="id" DefaultValue="" Name="patient_id"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    
    <div >
        <h2 class="title patient-dashboard-title">Approved Appointments </h2>
    </div>
    <div class="dashboard-section">
       

        <div class="appointment appointments-today">
            <h3 class="subtitle">Appointments today: </h3>

            <asp:ListView ID="ListView1" runat="server" DataKeyNames="doctor_id" DataSourceID="TodayAppointmentSqlDataSource">
                <AlternatingItemTemplate>
                    <h4 class="sub-subtitle"> Timing <%# Eval("slot_start") %></h4>
                <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>
                


                <div class="listitem">
                    <span class="listtitle"> Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>
                
                 <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>
                    

                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <span style="background-color: #FFCC66; color: #000080;">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:Label ID="doctor_idLabel1" runat="server" Text='<%# Eval("doctor_id") %>' />
                        <br />
                        reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                        <br />
                        patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                        <br />
                        Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                        <br />
                        status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                        <br />
                        booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        <br />
                        <br />
                    </span>

                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>

                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:TextBox ID="doctor_idTextBox" runat="server" Text='<%# Bind("doctor_id") %>' />
                        <br />
                        reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                        <br />
                        patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                        <br />
                        Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                        <br />
                        status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                        <br />
                        booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br />
                        <br />
                    </span>

                </InsertItemTemplate>
                <ItemTemplate>
                    <h4 class="sub-subtitle">Timing: '<%# Eval("slot_start") %>'</h4>

                    <div class="listitem">
                        <span class="listtitle">Doctor's First Name: 
                        </span>
                        <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                    </div>



                    <div class="listitem">
                        <span class="listtitle">Doctor's Last Name: 
                        </span>
                        <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                    </div>

                    <div class="listitem">
                        <span class="listtitle">Doctor's Id: 
                        </span>
                        <span class="listcontent"><%# Eval("doctor_id") %> </span>
                    </div>
                    <div class="listitem">
                        <span class="listtitle">Reason:
                        </span>
                        <span class="listcontent"><%# Eval("reason") %> </span>
                    </div>


                    <div class="listitem">
                        <span class="listtitle">Patient ID:
                        </span>
                        <span class="listcontent"><%# Eval("patient_id") %> </span>
                    </div>


                    <div class="listitem">
                        <span class="listtitle">Patient's first name:
                        </span>
                        <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                    </div>

                    <div class="listitem">
                        <span class="listtitle">Patient's last name:
                        </span>
                        <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                    </div>

                    <div class="listitem">
                        <span class="listtitle">Address:
                        </span>
                        <span class="listcontent"><%# Eval("Address") %> </span>
                    </div>

                    <div class="listitem">
                        <span class="listtitle">Date of birth:
                        </span>
                        <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                    </div>

                    <div class="listitem">
                        <span class="listtitle">Slot starting time:
                        </span>
                        <span class="listcontent"><%# Eval("slot_start") %> </span>
                    </div>

                    <div class="listitem">
                        <span class="listtitle">Slot ending time:
                        </span>
                        <span class="listcontent"><%# Eval("slot_end") %> </span>
                    </div>


                    <div class="listitem">
                        <span class="listtitle">Status:
                        </span>
                        <span class="listcontent"><%# Eval("status") %> </span>
                    </div>
                    <div class="listitem">
                        <span class="listtitle">Booking date:
                        </span>
                        <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                    </div>
                    <%--<span style="background-color: #FFFBD6; color: #333333;">doctor_first_name:
                <asp:Label ID="doctor_first_nameLabel" runat="server" Text='<%# Eval("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:Label ID="doctor_last_nameLabel" runat="server" Text='<%# Eval("doctor_last_name") %>' />
                        <br />

                        doctor_id:
                <asp:Label ID="doctor_idLabel" runat="server" Text='<%# Eval("doctor_id") %>' />
                        <br />

                        reason:
                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                        <br />
                        patient_id:
                <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                        <br />
                        Date of birth:
                <asp:Label ID="Date_of_birthLabel" runat="server" Text='<%# Eval("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                        <br />
                        status:
                <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                        <br />
                        booking_date:
                <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                        <br />
                        <br />
                    </span>--%>
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="text-align: center; background-color: #FFCC66; font-family: Verdana, Arial, Helvetica, sans-serif; color: #333333;">
                    </div>

                </LayoutTemplate>
                <SelectedItemTemplate>
                    <span style="background-color: #FFCC66; font-weight: bold; color: #000080;">doctor_first_name:
                <asp:Label ID="doctor_first_nameLabel" runat="server" Text='<%# Eval("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:Label ID="doctor_last_nameLabel" runat="server" Text='<%# Eval("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:Label ID="doctor_idLabel" runat="server" Text='<%# Eval("doctor_id") %>' />
                        <br />
                        reason:
                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                        <br />
                        patient_id:
                <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                        <br />
                        Date of birth:
                <asp:Label ID="Date_of_birthLabel" runat="server" Text='<%# Eval("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                        <br />
                        status:
                <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                        <br />
                        booking_date:
                <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                        <br />
                        <br />
                    </span>

                </SelectedItemTemplate>
            </asp:ListView>

        </div>

        <div class="appointment future-appointments">
            <h3 class="subtitle">Future Appointments: </h3>

            <asp:ListView ID="ListView2" runat="server" DataKeyNames="doctor_id" DataSourceID="FutureAppointmentsSqlDataSource">
                <AlternatingItemTemplate>
                    <h3 class="sub-subtitle"> Date: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h3>

                     <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>
                


                <div class="listitem">
                    <span class="listtitle"> Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>
                
                 <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>

                   


                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:Label ID="doctor_idLabel1" runat="server" Text='<%# Eval("doctor_id") %>' />
                        <br />
                        reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                        <br />
                        patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                        <br />
                        Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                        <br />
                        status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                        <br />
                        booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        <br />
                        <br />
                    </span>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:TextBox ID="doctor_idTextBox" runat="server" Text='<%# Bind("doctor_id") %>' />
                        <br />
                        reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                        <br />
                        patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                        <br />
                        Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                        <br />
                        status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                        <br />
                        booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br />
                        <br />
                    </span>
                </InsertItemTemplate>
                <ItemTemplate>
                    <h3 class="sub-subtitle"> Date: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h3>
                <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>
                


                <div class="listitem">
                    <span class="listtitle"> Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>
                
                 <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>
                    <%--<span style="">doctor_first_name:
                <asp:Label ID="doctor_first_nameLabel" runat="server" Text='<%# Eval("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:Label ID="doctor_last_nameLabel" runat="server" Text='<%# Eval("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:Label ID="doctor_idLabel" runat="server" Text='<%# Eval("doctor_id") %>' />
                        <br />
                        reason:
                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                        <br />
                        patient_id:
                <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                        <br />
                        Date of birth:
                <asp:Label ID="Date_of_birthLabel" runat="server" Text='<%# Eval("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                        <br />
                        status:
                <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                        <br />
                        booking_date:
                <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                        <br />
                        <br />
                    </span>--%>
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <span style="">doctor_first_name:
                <asp:Label ID="doctor_first_nameLabel" runat="server" Text='<%# Eval("doctor_first_name") %>' />
                        <br />
                        doctor_last_name:
                <asp:Label ID="doctor_last_nameLabel" runat="server" Text='<%# Eval("doctor_last_name") %>' />
                        <br />
                        doctor_id:
                <asp:Label ID="doctor_idLabel" runat="server" Text='<%# Eval("doctor_id") %>' />
                        <br />
                        reason:
                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                        <br />
                        patient_id:
                <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                        <br />
                        patient_last_name:
                <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                        <br />
                        patient_first_name:
                <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                        <br />
                        Address:
                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                        <br />
                        Date of birth:
                <asp:Label ID="Date_of_birthLabel" runat="server" Text='<%# Eval("[Date of birth]") %>' />
                        <br />
                        slot_start:
                <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                        <br />
                        slot_end:
                <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                        <br />
                        status:
                <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                        <br />
                        booking_date:
                <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                        <br />
                        <br />
                    </span>
                </SelectedItemTemplate>
            </asp:ListView>

        </div>

    </div>
    <h2 class="patient-dashboard-title">Pending Appointments</h2>
    <div class="dashboard-section">
        
        <asp:ListView ID="ListView3" runat="server" DataSourceID="PendingAppointmentsDataSource" DataKeyNames="doctor_id">
            <AlternatingItemTemplate>
                <h3 class="sub-subtitle">Date: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h3>
                <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>



                <div class="listitem">
                    <span class="listtitle">Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>

                <br />
                <br />
                </span>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                
                <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                <br />
                doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                <br />
                doctor_id:
                <asp:Label ID="doctor_idLabel1" runat="server" Text='<%# Eval("doctor_id") %>' />
                <br />
                reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                <br />
                patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                <br />
                patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                <br />
                patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                <br />
                Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                <br />
                Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                <br />
                slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                <br />
                slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                <br />
                status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                <br />
                booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br /><br /></span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>No data was returned.</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                <br />doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                <br />doctor_id:
                <asp:TextBox ID="doctor_idTextBox" runat="server" Text='<%# Bind("doctor_id") %>' />
                <br />reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                <br />patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                <br />patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                <br />patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                <br />Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                <br />Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                <br />slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                <br />slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                <br />status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                <br />booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                <br /><br /></span>
            </InsertItemTemplate>
            <ItemTemplate>
                <h3 class="sub-subtitle"> Date: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h3>
                <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>
                


                <div class="listitem">
                    <span class="listtitle"> Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                 <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>
                
                 <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>

                 
                <br />
<br /></span>
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <span style="">doctor_first_name:
                <asp:Label ID="doctor_first_nameLabel" runat="server" Text='<%# Eval("doctor_first_name") %>' />
                <br />
                doctor_last_name:
                <asp:Label ID="doctor_last_nameLabel" runat="server" Text='<%# Eval("doctor_last_name") %>' />
                <br />
                doctor_id:
                <asp:Label ID="doctor_idLabel" runat="server" Text='<%# Eval("doctor_id") %>' />
                <br />
                reason:
                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                <br />
                patient_id:
                <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                <br />
                patient_last_name:
                <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                <br />
                patient_first_name:
                <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                <br />
                Address:
                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                <br />
                Date of birth:
                <asp:Label ID="Date_of_birthLabel" runat="server" Text='<%# Eval("[Date of birth]") %>' />
                <br />
                slot_start:
                <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                <br />
                slot_end:
                <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                <br />
                status:
                <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                <br />
                booking_date:
                <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                <br />
<br /></span>
            </SelectedItemTemplate>
            </asp:ListView>
        
    </div>
    <h2 class="patient-dashboard-title">Rejected Appointments</h2>
    <div class="dashboard-section">
        
        <asp:ListView ID="ListView4" runat="server" DataKeyNames="doctor_id" DataSourceID="RejectedDataSource">
            <AlternatingItemTemplate>
                <h3 class="sub-subtitle">Date: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h3>
                <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>



                <div class="listitem">
                    <span class="listtitle">Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>

                <br />
                </span>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                <br />
                doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                <br />
                doctor_id:
                <asp:Label ID="doctor_idLabel1" runat="server" Text='<%# Eval("doctor_id") %>' />
                <br />
                reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                <br />
                patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                <br />
                patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                <br />
                patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                <br />
                Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                <br />
                Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                <br />
                slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                <br />
                slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                <br />
                status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                <br />
                booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br /><br /></span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>No data was returned.</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <span style="">doctor_first_name:
                <asp:TextBox ID="doctor_first_nameTextBox" runat="server" Text='<%# Bind("doctor_first_name") %>' />
                <br />doctor_last_name:
                <asp:TextBox ID="doctor_last_nameTextBox" runat="server" Text='<%# Bind("doctor_last_name") %>' />
                <br />doctor_id:
                <asp:TextBox ID="doctor_idTextBox" runat="server" Text='<%# Bind("doctor_id") %>' />
                <br />reason:
                <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                <br />patient_id:
                <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                <br />patient_last_name:
                <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                <br />patient_first_name:
                <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                <br />Address:
                <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />
                <br />Date of birth:
                <asp:TextBox ID="Date_of_birthTextBox" runat="server" Text='<%# Bind("[Date of birth]") %>' />
                <br />slot_start:
                <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                <br />slot_end:
                <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                <br />status:
                <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                <br />booking_date:
                <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                <br /><br /></span>
            </InsertItemTemplate>
            <ItemTemplate>
                <h3 class="sub-subtitle">Date: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h3>
                <div class="listitem">
                    <span class="listtitle">Doctor's First Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_first_name") %> </span>
                </div>



                <div class="listitem">
                    <span class="listtitle">Doctor's Last Name: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Doctor's Id: 
                    </span>
                    <span class="listcontent"><%# Eval("doctor_id") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Reason:
                    </span>
                    <span class="listcontent"><%# Eval("reason") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient ID:
                    </span>
                    <span class="listcontent"><%# Eval("patient_id") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Patient's first name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_first_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Patient's last name:
                    </span>
                    <span class="listcontent"><%# Eval("patient_last_name") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Address:
                    </span>
                    <span class="listcontent"><%# Eval("Address") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Date of birth:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("[Date of birth]")).ToShortDateString() %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot starting time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_start") %> </span>
                </div>

                <div class="listitem">
                    <span class="listtitle">Slot ending time:
                    </span>
                    <span class="listcontent"><%# Eval("slot_end") %> </span>
                </div>


                <div class="listitem">
                    <span class="listtitle">Status:
                    </span>
                    <span class="listcontent"><%# Eval("status") %> </span>
                </div>
                <div class="listitem">
                    <span class="listtitle">Booking date:
                    </span>
                    <span class="listcontent"><%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %> </span>
                </div>

                <br />
                </span>
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <span style="">doctor_first_name:
                <asp:Label ID="doctor_first_nameLabel" runat="server" Text='<%# Eval("doctor_first_name") %>' />
                <br />
                doctor_last_name:
                <asp:Label ID="doctor_last_nameLabel" runat="server" Text='<%# Eval("doctor_last_name") %>' />
                <br />
                doctor_id:
                <asp:Label ID="doctor_idLabel" runat="server" Text='<%# Eval("doctor_id") %>' />
                <br />
                reason:
                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                <br />
                patient_id:
                <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                <br />
                patient_last_name:
                <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                <br />
                patient_first_name:
                <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                <br />
                Address:
                <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />
                <br />
                Date of birth:
                <asp:Label ID="Date_of_birthLabel" runat="server" Text='<%# Eval("[Date of birth]") %>' />
                <br />
                slot_start:
                <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                <br />
                slot_end:
                <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                <br />
                status:
                <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                <br />
                booking_date:
                <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                <br />
<br /></span>
            </SelectedItemTemplate>
        </asp:ListView>
    </div>

    <footer>
        SiteMap:
        <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1"></asp:TreeView>
        <asp:SiteMapDataSource runat="server" ID="SiteMapDataSource1"></asp:SiteMapDataSource>
        <br />
    </footer>
</asp:Content>
