<%@ Page Title="" Language="C#" MasterPageFile="~/AuthenticationLayout.Master" AutoEventWireup="true" CodeBehind="Sign up.aspx.cs" Inherits="final_individual_project.Sign_up" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3>Sign Up</h3>
    <h5 style="color: red">Sign Up for Patiens only!</h5>
    <div class="input-fields">
        <asp:Label ID="Label1" runat="server" Text="First Name: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="First_Name_Textbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="First_Name_Textbox" ErrorMessage="You have not entered your first name" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div class="input-fields">
        <asp:Label ID="Label2" runat="server" Text="Last Name:"></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="Last_Name_Textbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Last_Name_Textbox" ErrorMessage="You have not entered a Last Name" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div class="input-fields">
        <asp:Label ID="Label3" runat="server" Text="Date Of Birth: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="DOB_TextBox" runat="server" TextMode="Date"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DOB_TextBox" ErrorMessage="You have not selected a date of birth" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>
    <div class="input-fields">
        <asp:Label ID="Label4" runat="server" Text="Address: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="Address_TextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Address_TextBox" Display="Dynamic" ErrorMessage="You have not entered an address" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
     <div class="input-fields ">
        <asp:Label ID="Label5" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="username_textbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="username_textbox" ErrorMessage="Username missing" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
         <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="username_textbox" Display="Dynamic" ErrorMessage="Username already exists" ForeColor="#FF3300" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
    </div>

    <div class="input-fields">
        <asp:Label ID="Label6" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="password_textbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="password_textbox" ErrorMessage="Password missing" ForeColor="#FF3300" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div>
        <asp:Button ID="Button1" runat="server" Text="Sign Up" OnClick="Button1_Click" />
    </div>

    <asp:Label ID="signupSuccessful" runat="server" ForeColor="Red"></asp:Label>

    <div class="right-link">
        
        <span>Want to login instead? </span>
        <a class="a-tag" href="Login.aspx">Login</a>
    </div>
</asp:Content>
