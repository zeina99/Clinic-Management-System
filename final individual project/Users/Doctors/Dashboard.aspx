<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="final_individual_project.Users.Doctors.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SideBar" runat="server">

    <ul class="nav-style">
        <li> <a href="Dashboard.aspx" > Dashboard </a>  </li>
        <li> <a href="ApproveAppointment.aspx">Approve Appointments </a>  </li>
        <li> <a href="UpdateAccount.aspx">Update Account </a> </li>
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
                    <h3># of Appointments today</h3>
                </div>
                <asp:Label CssClass="cardLabel" ID="NumTodayLabel" runat="server" Text=""></asp:Label>
            </div>

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3># of Future Appointments</h3>
                </div>
                <asp:Label CssClass="cardLabel" ID="FutureAppointmentLabel" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="AppointmentsTodayDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' SelectCommand="SELECT patient_id, [patient_first_name], [patient_last_name], [reason], [booking_date], [slot_start], [slot_end], status FROM [Bookings_DoctorsPatients] WHERE (([booking_date] = CONVERT(date, getdate())) AND ([doctor_id] = @doctor_id))">
        <SelectParameters>
            <asp:SessionParameter SessionField="id" Name="doctor_id" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="FutureAppointmentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT [patient_last_name], [patient_first_name], [slot_start], [slot_end], [booking_date], [reason], status, patient_id FROM [Bookings_DoctorsPatients] WHERE ([doctor_id] = @doctor_id) AND CONVERT(date, getdate()) &lt; booking_date">
        <SelectParameters>
            <asp:SessionParameter Name="doctor_id" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="NumOfAppointmentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) FROM Bookings WHERE doctor_id = @doctorid AND booking_date = CONVERT(date, getdate())">
        <SelectParameters>
            <asp:SessionParameter Name="doctorid" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="NumOfFutureAppointmentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) FROM Bookings WHERE  doctor_id = @doctorid AND booking_date &gt; CONVERT(date, getdate())">
        <SelectParameters>
            <asp:SessionParameter Name="doctorid" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="doctor-dashboard-wrapper">
    <div class="doctor-dashboard-section">
        <h2 class="dashboard-title">Appointments today
        </h2>

        <asp:ListView ID="ListView1" runat="server" DataSourceID="AppointmentsTodayDataSource">
            <AlternatingItemTemplate>
                <h4 class="sub-subtitle">Timing: '<%# Eval("slot_start") %>'</h4>
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
                        <span class="listtitle">Reason:
                        </span>
                        <span class="listcontent"><%# Eval("reason") %> </span>
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
                <li style="">patient_id:
                    <asp:TextBox Text='<%# Bind("patient_id") %>' runat="server" ID="patient_idTextBox" /><br />
                    patient_first_name:
                    <asp:TextBox Text='<%# Bind("patient_first_name") %>' runat="server" ID="patient_first_nameTextBox" /><br />
                    patient_last_name:
                    <asp:TextBox Text='<%# Bind("patient_last_name") %>' runat="server" ID="patient_last_nameTextBox" /><br />
                    reason:
                    <asp:TextBox Text='<%# Bind("reason") %>' runat="server" ID="reasonTextBox" /><br />
                    booking_date:
                    <asp:TextBox Text='<%# Bind("booking_date") %>' runat="server" ID="booking_dateTextBox" /><br />
                    slot_start:
                    <asp:TextBox Text='<%# Bind("slot_start") %>' runat="server" ID="slot_startTextBox" /><br />
                    slot_end:
                    <asp:TextBox Text='<%# Bind("slot_end") %>' runat="server" ID="slot_endTextBox" /><br />
                    status:
                    <asp:TextBox Text='<%# Bind("status") %>' runat="server" ID="statusTextBox" /><br />
                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" /><asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /></li>

            </EditItemTemplate>
            <EmptyDataTemplate>
                No data was returned.

            </EmptyDataTemplate>
            <InsertItemTemplate>
                <li style="">patient_id:
                    <asp:TextBox Text='<%# Bind("patient_id") %>' runat="server" ID="patient_idTextBox" /><br />
                    patient_first_name:
                    <asp:TextBox Text='<%# Bind("patient_first_name") %>' runat="server" ID="patient_first_nameTextBox" /><br />
                    patient_last_name:
                    <asp:TextBox Text='<%# Bind("patient_last_name") %>' runat="server" ID="patient_last_nameTextBox" /><br />
                    reason:
                    <asp:TextBox Text='<%# Bind("reason") %>' runat="server" ID="reasonTextBox" /><br />
                    booking_date:
                    <asp:TextBox Text='<%# Bind("booking_date") %>' runat="server" ID="booking_dateTextBox" /><br />
                    slot_start:
                    <asp:TextBox Text='<%# Bind("slot_start") %>' runat="server" ID="slot_startTextBox" /><br />
                    slot_end:
                    <asp:TextBox Text='<%# Bind("slot_end") %>' runat="server" ID="slot_endTextBox" /><br />
                    status:
                    <asp:TextBox Text='<%# Bind("status") %>' runat="server" ID="statusTextBox" /><br />
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /></li>

            </InsertItemTemplate>
            <ItemSeparatorTemplate>
                <br />
            </ItemSeparatorTemplate>
            <ItemTemplate>
                               <h4 class="sub-subtitle">Timing: '<%# Eval("slot_start") %>'</h4>
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
                        <span class="listtitle">Reason:
                        </span>
                        <span class="listcontent"><%# Eval("reason") %> </span>
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
            </ItemTemplate>
            <LayoutTemplate>
                <ul runat="server" id="itemPlaceholderContainer" style="">
                    <li runat="server" id="itemPlaceholder" />
                </ul>

                <div style="">
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <li style="">patient_id:
                    <asp:Label Text='<%# Eval("patient_id") %>' runat="server" ID="patient_idLabel" /><br />
                    patient_first_name:
                    <asp:Label Text='<%# Eval("patient_first_name") %>' runat="server" ID="patient_first_nameLabel" /><br />
                    patient_last_name:
                    <asp:Label Text='<%# Eval("patient_last_name") %>' runat="server" ID="patient_last_nameLabel" /><br />
                    reason:
                    <asp:Label Text='<%# Eval("reason") %>' runat="server" ID="reasonLabel" /><br />
                    booking_date:
                    <asp:Label Text='<%# Eval("booking_date") %>' runat="server" ID="booking_dateLabel" /><br />
                    slot_start:
                    <asp:Label Text='<%# Eval("slot_start") %>' runat="server" ID="slot_startLabel" /><br />
                    slot_end:
                    <asp:Label Text='<%# Eval("slot_end") %>' runat="server" ID="slot_endLabel" /><br />
                    status:
                    <asp:Label Text='<%# Eval("status") %>' runat="server" ID="statusLabel" /><br />
                </li>

            </SelectedItemTemplate>
        </asp:ListView>
    </div>
    <div class="future-appointmetns">
        <h2 class="dashboard-title">Future Appointments</h2>

        <asp:ListView ID="ListView2" runat="server" DataSourceID="FutureAppointmentsDataSource">
            <AlternatingItemTemplate>
 <h4 class="sub-subtitle">Timing: '<%# Eval("booking_date") %>'</h4>
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
                        <span class="listtitle">Reason:
                        </span>
                        <span class="listcontent"><%# Eval("reason") %> </span>
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
                <li style="">patient_last_name:
                    <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                    <br />
                    patient_first_name:
                    <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                    <br />
                    slot_start:
                    <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                    <br />
                    slot_end:
                    <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                    <br />
                    booking_date:
                    <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                    <br />
                    reason:
                    <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                    <br />
                    status:
                    <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                    <br />
                    patient_id:
                    <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                </li>
            </EditItemTemplate>
            <EmptyDataTemplate>
                No data was returned.
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <li style="">patient_last_name:
                    <asp:TextBox ID="patient_last_nameTextBox" runat="server" Text='<%# Bind("patient_last_name") %>' />
                    <br />
                    patient_first_name:
                    <asp:TextBox ID="patient_first_nameTextBox" runat="server" Text='<%# Bind("patient_first_name") %>' />
                    <br />
                    slot_start:
                    <asp:TextBox ID="slot_startTextBox" runat="server" Text='<%# Bind("slot_start") %>' />
                    <br />
                    slot_end:
                    <asp:TextBox ID="slot_endTextBox" runat="server" Text='<%# Bind("slot_end") %>' />
                    <br />
                    booking_date:
                    <asp:TextBox ID="booking_dateTextBox" runat="server" Text='<%# Bind("booking_date") %>' />
                    <br />
                    reason:
                    <asp:TextBox ID="reasonTextBox" runat="server" Text='<%# Bind("reason") %>' />
                    <br />
                    status:
                    <asp:TextBox ID="statusTextBox" runat="server" Text='<%# Bind("status") %>' />
                    <br />
                    patient_id:
                    <asp:TextBox ID="patient_idTextBox" runat="server" Text='<%# Bind("patient_id") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                </li>
            </InsertItemTemplate>
            <ItemSeparatorTemplate>
                <br />
            </ItemSeparatorTemplate>
            <ItemTemplate>
                                 <h4 class="sub-subtitle">Timing: <%# Convert.ToDateTime(Eval("booking_date")).ToShortDateString() %></h4>
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
                        <span class="listtitle">Reason:
                        </span>
                        <span class="listcontent"><%# Eval("reason") %> </span>
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
            </ItemTemplate>
            <LayoutTemplate>
                <ul id="itemPlaceholderContainer" runat="server" style="">
                    <li runat="server" id="itemPlaceholder" />
                </ul>
                <div style=""></div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <li style="">patient_last_name:
                    <asp:Label ID="patient_last_nameLabel" runat="server" Text='<%# Eval("patient_last_name") %>' />
                    <br />
                    patient_first_name:
                    <asp:Label ID="patient_first_nameLabel" runat="server" Text='<%# Eval("patient_first_name") %>' />
                    <br />
                    slot_start:
                    <asp:Label ID="slot_startLabel" runat="server" Text='<%# Eval("slot_start") %>' />
                    <br />
                    slot_end:
                    <asp:Label ID="slot_endLabel" runat="server" Text='<%# Eval("slot_end") %>' />
                    <br />
                    booking_date:
                    <asp:Label ID="booking_dateLabel" runat="server" Text='<%# Eval("booking_date") %>' />
                    <br />
                    reason:
                    <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' />
                    <br />
                    status:
                    <asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>' />
                    <br />
                    patient_id:
                    <asp:Label ID="patient_idLabel" runat="server" Text='<%# Eval("patient_id") %>' />
                    <br />
                </li>
            </SelectedItemTemplate>
        </asp:ListView>
    </div>
        </div>
</asp:Content>
