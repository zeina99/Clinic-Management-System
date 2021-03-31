<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="UpdateAccount.aspx.cs" Inherits="final_individual_project.Users.Doctors.UpdateAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SideBar" runat="server">

    <ul class="nav-style">
        <li><a href="Dashboard.aspx">Dashboard </a></li>
        <li><a href="ApproveAppointment.aspx">Approve Appointments </a></li>
        <li><a href="UpdateAccount.aspx">Update Account </a></li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:SqlDataSource ID="DoctorsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT [first_name], [last_name], [username], [password] FROM [DoctorsUsers] WHERE ([doctor_id] = @doctor_id)">
        <SelectParameters>
            <asp:SessionParameter Name="doctor_id" SessionField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="profile-wrapper">
        <h3 class="dashboard-title">Update Account</h3>
        <div class="profile-section">
            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label1" runat="server" Text="First Name: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="FirstNameTextbox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FirstNameTextbox" ErrorMessage="First Name is empty" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>
            </div>
            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label2" runat="server" Text="Last Name: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="LastNameTextbox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="LastNameTextbox" ErrorMessage="Last name is empty" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>
            </div>
            <div class="inline-fields">
                <asp:Label CssClass="listtitle" ID="Label3" runat="server" Text="Username: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="UsernameTextbox" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="UsernameTextbox" ErrorMessage="Username is empty" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>

            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label4" runat="server" Text="Password: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="PasswordTextbox" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="PasswordTextbox" ErrorMessage="Password is empty" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>

            <asp:Button ID="Button1" runat="server" Text="Update" OnClick="Button1_Click" ValidationGroup="group" />
            <br />
            <asp:Label ID="UpdateLabel" runat="server" Text=""></asp:Label>

        </div>
        </div>
</asp:Content>
