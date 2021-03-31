<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="final_individual_project.Users.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SideBar" runat="server">
  
       <ul class="nav-style">
        <li><a href="Dashboard.aspx">Dashboard </a></li>
        <li><a href="UpdateDoctors.aspx">UpdateDoctors </a></li>
        <li><a href="UpdateUsers.aspx">UpdateUsers</a> </li>
        <li><a href="UpdateBookings.aspx">UpdateBookings</a>   </li>
        <li><a href="UpdatePatients.aspx">UpdatePatients </a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap-dashboard">
        <h2 class="dashboard-title">Dashboard</h2>
        <div class="cards admin-dashboard">

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3># of Doctors</h3>
                </div>

                <asp:Label CssClass="cardLabel" ID="DoctorsNumLabel" runat="server" Text=""></asp:Label>
            </div>
            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3># of Patients</h3>
                </div>

                <asp:Label CssClass="cardLabel" ID="PatientsNumLabel" runat="server" Text=""></asp:Label>

            </div>

            <div class="card">
                <div class="top-card">
                    <span class="material-icons md-36">book_online
                    </span>
                    <h3># of Appointments today</h3>
                </div>

                <asp:Label CssClass="cardLabel" ID="AppointmentLabel" runat="server" Text=""></asp:Label>

                <asp:SqlDataSource ID="NumOfDoctorsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) FROM Doctors "></asp:SqlDataSource>

                <asp:SqlDataSource ID="NumOfPatientsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT COUNT(*) FROM Patients"></asp:SqlDataSource>
                <asp:SqlDataSource ID="NumOfAppointmentsTodayDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' SelectCommand="SELECT COUNT(*) FROM Bookings WHERE booking_date = CONVERT(date, getdate())"></asp:SqlDataSource>
            </div>
        </div>
    </div>

</asp:Content>
