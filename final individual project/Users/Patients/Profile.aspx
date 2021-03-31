<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="final_individual_project.Users.Patients.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SideBar" runat="server">
       
    <ul class="nav-style">
        <li><a href="Dashboard.aspx">Dashboard </a></li>
        <li><a href="BookApointment.aspx">Book Appointment</a></li>

        <li><a href="Profile.aspx">Profile</a> </li>
        <li><a href="UpdateAccount.aspx">Update account </a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT * FROM [Patients] 
JOIN Users ON Users.Id = Patients.user_id
WHERE (Patients.Id = @patientid) ">
        <SelectParameters>
            <asp:SessionParameter Name="patientid" SessionField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
   
    <div class="profile-wrapper">
         <h3 class="dashboard-title">Profile</h3>
        <div class="profile-section">
        <div class="profile-item">
            <asp:Label CssClass="listtitle" ID="Label1" runat="server" Text="First Name: "></asp:Label>
            <asp:Label ID="FirstNameLabel" runat="server" Text=""></asp:Label>
        </div>

        <div class="profile-item">
            <asp:Label CssClass="listtitle" ID="Label2" runat="server" Text="Last Name:"></asp:Label>
            <asp:Label ID="lastnameLabel" runat="server" Text=""></asp:Label>
        </div>

        <div class="profile-item">
            <asp:Label CssClass="listtitle" ID="Label3" runat="server" Text="Date of Birth: "></asp:Label>
            <asp:Label ID="DOBLabel" runat="server" Text=""></asp:Label>
        </div>
        <div class="profile-item">
            <asp:Label CssClass="listtitle" ID="Label4" runat="server" Text="Address: "></asp:Label>
            <asp:Label ID="addressLabel" runat="server" Text=""></asp:Label>
        </div>
        <div class="profile-item">
            <asp:Label CssClass="listtitle" ID="Label5" runat="server" Text="Username: "></asp:Label>
            <asp:Label ID="UsernameLabel" runat="server" Text=""></asp:Label>
        </div>
        <div class="profile-item">
            <asp:Label CssClass="listtitle" ID="Label6" runat="server" Text="Password: "></asp:Label>
            <asp:Label ID="PasswordLabel" runat="server" Text=""></asp:Label>

        </div>
            </div>
    </div>
    <footer>
        SiteMap:
        <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1"></asp:TreeView>
        <asp:SiteMapDataSource runat="server" ID="SiteMapDataSource1"></asp:SiteMapDataSource>
        <br />
    </footer>
</asp:Content>
