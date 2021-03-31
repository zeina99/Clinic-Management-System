<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="UpdateUsers.aspx.cs" Inherits="final_individual_project.Users.Admin.UpdateUsers" %>
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
    <div class ="update-wrapper">
        <h2 class="dashboard-title">Update Users</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                <asp:BoundField DataField="username" HeaderText="username" SortExpression="username"></asp:BoundField>
                <asp:BoundField DataField="password" HeaderText="password" SortExpression="password"></asp:BoundField>
                <asp:BoundField DataField="user_type" HeaderText="user_type" SortExpression="user_type"></asp:BoundField>
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>

            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White"></HeaderStyle>

            <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066"></PagerStyle>

            <RowStyle ForeColor="#000066"></RowStyle>

            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

            <SortedAscendingHeaderStyle BackColor="#007DBB"></SortedAscendingHeaderStyle>

            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

            <SortedDescendingHeaderStyle BackColor="#00547E"></SortedDescendingHeaderStyle>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' DeleteCommand="DELETE FROM [Users] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Users] ([username], [password], [user_type]) VALUES (@username, @password, @user_type)" SelectCommand="SELECT * FROM [Users]" UpdateCommand="UPDATE [Users] SET [username] = @username, [password] = @password, [user_type] = @user_type WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="username" Type="String"></asp:Parameter>
            <asp:Parameter Name="password" Type="String"></asp:Parameter>
            <asp:Parameter Name="user_type" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="username" Type="String"></asp:Parameter>
            <asp:Parameter Name="password" Type="String"></asp:Parameter>
            <asp:Parameter Name="user_type" Type="String"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
