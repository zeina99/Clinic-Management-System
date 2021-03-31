<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="BookApointment.aspx.cs" Inherits="final_individual_project.Users.Patients.BookApointment" %>
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
    <br />
    <div class="booking-wrapper">
       
        <div class="book-appointment-section">
             <h2 class="dashboard-title" style="margin-top:3rem">Book an appointment</h2>
            <h3>Choose a doctor:</h3>
            
            <asp:SqlDataSource runat="server" ID="DoctorNames" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' SelectCommand="SELECT [Id],  [first_name] + ' '+ [last_name] AS [Fullname] FROM [Doctors]"></asp:SqlDataSource>

            <asp:GridView  ID="GridView1" runat="server" DataSourceID="DoctorNames" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="GridValidation" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <h3>Reason of visit: </h3>
            <!--<asp:Label ID="Label2" runat="server" Text="Reason of Visit: "></asp:Label>-->
            <asp:TextBox ID="ReasonTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ReasonTextBox" ErrorMessage="Enter a reason for the visit" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
            <br />


            <h3>Starting time of choice: </h3>
            <!--<asp:Label ID="Label3" runat="server" Text="Start Timing of choice: "></asp:Label>-->
            <asp:DropDownList CssClass="user-dropdown-booking" ID="TimeSlots" runat="server"></asp:DropDownList>


            <asp:Label ID="TimeSlotValidLabel" runat="server" ForeColor="Red"></asp:Label>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TimeSlots" ErrorMessage="You have another appointment in this timeslot" ForeColor="Red" OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="group1"></asp:CustomValidator>
            <br />
            <h3>Select a date: </h3>
            <!--<asp:Label ID="Label4" runat="server" ForeColor="Black" Text="Select a date: "></asp:Label>-->
            <asp:TextBox ID="DateTextbox" runat="server" TextMode="Date"></asp:TextBox>

            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DateTextbox" ErrorMessage="You must select a date" ForeColor="Red" ValidationGroup="group1"></asp:RequiredFieldValidator>
            <p style="color: red;">Note: Slots last for 30 minutes only</p>

            <asp:Button ID="BookAppointmentButton" runat="server" Text="Book Apointment" OnClick="BookAppointmentButton_Click" ValidationGroup="group1" />
            <br />
            <asp:Label ID="BookingSuccessLabel" runat="server" Text=""></asp:Label>
        </div>
    </div>
    <footer>
        SiteMap:
        <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1"></asp:TreeView>
        <asp:SiteMapDataSource runat="server" ID="SiteMapDataSource1"></asp:SiteMapDataSource>
        <br />
    </footer>
</asp:Content>
