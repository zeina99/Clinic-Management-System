<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="UpdateAccount.aspx.cs" Inherits="final_individual_project.Users.Patients.UpdateAccount" %>
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


    <asp:SqlDataSource ID="PatientDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT * FROM [Patients] 
JOIN Users ON Users.Id = Patients.user_id
WHERE (Patients.Id = @patientid) ">
             <SelectParameters>
                 <asp:SessionParameter Name="patientid" SessionField="id" />
             </SelectParameters>
         </asp:SqlDataSource>

    <div class="profile-wrapper">
        <h3 class="dashboard-title">Update Account</h3>
        <div class="profile-section">
            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label1" runat="server" Text="First Name: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="First_Name_Textbox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="First_Name_Textbox" ErrorMessage="First name is empty" ForeColor="Red" ValidationGroup="group" Display="Dynamic"></asp:RequiredFieldValidator>

            </div>

            <div class="input-fields">
                <asp:Label CssClass="listtitle padding-1" ID="Label2" runat="server" Text="Last Name:"></asp:Label>
                <asp:TextBox CssClass="input-fields" ID="Last_Name_Textbox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Last_Name_Textbox" ErrorMessage="Last Name is empty" ForeColor="Red" ValidationGroup="group" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="input-fields">
                <asp:Label CssClass="listtitle padding-1" ID="Label3" runat="server" Text="Date Of Birth: "></asp:Label>
                <asp:TextBox  CssClass="input-fields" ID="DOB_TextBox" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DOB_TextBox" ErrorMessage="Date of birth is empty" ForeColor="#FF3300" ValidationGroup="group" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label4" runat="server" Text="Address: "></asp:Label>
                <asp:TextBox CssClass="input-fields" ID="Address_TextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Address_TextBox" ErrorMessage="Address is empty" ForeColor="Red" ValidationGroup="group" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="input-fields ">
                <asp:Label CssClass="listtitle" ID="Label5" runat="server" Text="Username: "></asp:Label>
                <asp:TextBox CssClass="input-fields" ID="username_textbox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="username_textbox" Display="Dynamic" ErrorMessage="Username cannot be empty" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>
            </div>

            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label6" runat="server" Text="Password: "></asp:Label>
                <asp:TextBox CssClass="input-fields" ID="password_textbox" runat="server"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="password_textbox" ErrorMessage="Password cannot be empty" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>

            </div>
            <asp:Button ID="UpdateButton" runat="server" Text="Update" OnClick="UpdateButton_Click" ValidationGroup="group" />
            <br />
            <asp:Label ID="UpdateLabel" runat="server"></asp:Label>
        </div>
    </div>
    <footer>
        SiteMap: 
        <asp:TreeView ID="TreeView1" runat="server" DataSourceID="SiteMapDataSource1"></asp:TreeView>
        <asp:SiteMapDataSource runat="server" ID="SiteMapDataSource1"></asp:SiteMapDataSource>
        <br />
    </footer>
    </asp:Content>
