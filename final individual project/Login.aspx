<%@ Page Title="" Language="C#" MasterPageFile="~/AuthenticationLayout.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="final_individual_project.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Log in</h3>

    <div class="input-fields">
        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="user-dropdown">
            <asp:ListItem Value="Patient">Patient</asp:ListItem>
            <asp:ListItem Value="Doctor">Doctor</asp:ListItem>
            <asp:ListItem Value="Admin">Admin</asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="input-fields ">
        <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="username_textbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="username_textbox" ErrorMessage="Username missing" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <div class="input-fields">
        <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox CssClass ="text-input" ID="password_textbox" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="password_textbox" ErrorMessage="Password missing" ForeColor="#FF3300" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>

    <asp:Button ID="signin_Button" runat="server" Text="Login" OnClick="signin_Button_Click" />
    <div style="color:red">
        <asp:Label ID="doesnotexistLabel" runat="server" Text=""></asp:Label>
    </div>
    <div class="right-link">
        <span>Dont have an account? </span>
        <a class="a-tag" href="Sign%20up.aspx">Sign up</a>
    </div>

</asp:Content>
