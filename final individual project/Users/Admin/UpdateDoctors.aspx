<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="UpdateDoctors.aspx.cs" Inherits="final_individual_project.Users.Admin.UpdateDoctors" %>
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
    <asp:SqlDataSource ID="AllDoctors" runat="server" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' DeleteCommand="DELETE FROM [Doctors] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Doctors] ([first_name], [last_name], [user_id]) VALUES (@first_name, @last_name, @user_id)" SelectCommand="SELECT * FROM [Doctors]" UpdateCommand="UPDATE [Doctors] SET [first_name] = @first_name, [last_name] = @last_name, [user_id] = @user_id WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="first_name" Type="String"></asp:Parameter>
            <asp:Parameter Name="last_name" Type="String"></asp:Parameter>
            <asp:Parameter Name="user_id" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="first_name" Type="String"></asp:Parameter>
            <asp:Parameter Name="last_name" Type="String"></asp:Parameter>
            <asp:Parameter Name="user_id" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>


    <div class="update-wrapper">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <h3 class="dashboard-title">Update Doctors</h3>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="AllDoctors" AllowPaging="True" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                        <asp:BoundField DataField="first_name" HeaderText="first_name" SortExpression="first_name"></asp:BoundField>
                        <asp:BoundField DataField="last_name" HeaderText="last_name" SortExpression="last_name"></asp:BoundField>
                        <asp:BoundField DataField="user_id" HeaderText="user_id" SortExpression="user_id"></asp:BoundField>
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
            </ContentTemplate>

        </asp:UpdatePanel>

        <div class="add-doctor">
            <h3 class="subtitle">Add a Doctor</h3>
            <div class="add-doctor addPatient">
                <div class="input-fields">
                    <asp:Label CssClass="listtitle" ID="Label1" runat="server" Text="First Name: "></asp:Label>
                    <asp:TextBox CssClass="text-input" ID="First_Name_Textbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="First_Name_Textbox" ErrorMessage="You have not entered your first name" ForeColor="Red" Display="Dynamic" ValidationGroup="group"></asp:RequiredFieldValidator>
                </div>

                <div class="input-fields">
                    <asp:Label CssClass="listtitle" ID="Label2" runat="server" Text="Last Name:"></asp:Label>
                    <asp:TextBox CssClass="text-input" ID="Last_Name_Textbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Last_Name_Textbox" ErrorMessage="You have not entered a Last Name" ForeColor="Red" Display="Dynamic" ValidationGroup="group"></asp:RequiredFieldValidator>
                </div>

                <div class="input-fields ">
                    <asp:Label CssClass="listtitle" ID="Label5" runat="server" Text="Username: "></asp:Label>
                    <asp:TextBox CssClass="text-input" ID="username_textbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="username_textbox" ErrorMessage="Username missing" ForeColor="Red" Display="Dynamic" ValidationGroup="group"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="username_textbox" Display="Dynamic" ErrorMessage="Username already exists" ForeColor="#FF3300" OnServerValidate="CustomValidator2_ServerValidate" ValidationGroup="group"></asp:CustomValidator>
                </div>

                <div class="input-fields">
                    <asp:Label CssClass="listtitle" ID="Label6" runat="server" Text="Password: "></asp:Label>
                    <asp:TextBox CssClass="text-input" ID="password_textbox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="password_textbox" ErrorMessage="Password missing" ForeColor="#FF3300" Display="Dynamic" ValidationGroup="group"></asp:RequiredFieldValidator>
                </div>
                <div class="buttonmargin">
                <asp:Button ID="Button1" runat="server" Text="Create New Doctor" OnClick="Button1_Click" ValidationGroup="group" />
                </div>
                <asp:Label ID="successLabel" runat="server" Text=""></asp:Label>
            </div>
        </div>
        </div>
</asp:Content>
