<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="UpdatePatients.aspx.cs" Inherits="final_individual_project.Users.Admin.UpdatePatients" %>
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

    <asp:SqlDataSource ID="AllPatients" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" SelectCommand="SELECT * FROM [Patients]" DeleteCommand="DELETE FROM [Patients] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Patients] ([first_name], [last_name], [Date of birth], [Address], [user_id]) VALUES (@first_name, @last_name, @Date_of_birth, @Address, @user_id)" UpdateCommand="UPDATE [Patients] SET [first_name] = @first_name, [last_name] = @last_name, [Date of birth] = @Date_of_birth, [Address] = @Address, [user_id] = @user_id WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="first_name" Type="String"></asp:Parameter>
            <asp:Parameter Name="last_name" Type="String"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="Date_of_birth"></asp:Parameter>
            <asp:Parameter Name="Address" Type="String"></asp:Parameter>
            <asp:Parameter Name="user_id" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="first_name" Type="String"></asp:Parameter>
            <asp:Parameter Name="last_name" Type="String"></asp:Parameter>
            <asp:Parameter DbType="Date" Name="Date_of_birth"></asp:Parameter>
            <asp:Parameter Name="Address" Type="String"></asp:Parameter>
            <asp:Parameter Name="user_id" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    

    <div class="update-wrapper">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <h3 class="dashboard-title titlemargin">Update Patients</h3>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="AllPatients" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="first_name" HeaderText="first_name" SortExpression="first_name" />
                        <asp:BoundField DataField="last_name" HeaderText="last_name" SortExpression="last_name" />
                        <asp:BoundField DataField="Date of birth" HeaderText="Date of birth" SortExpression="Date of birth" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                        <asp:BoundField DataField="user_id" HeaderText="user_id" SortExpression="user_id" />
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>

            </ContentTemplate>

        </asp:UpdatePanel>



        <h3 class="subtitle">Add a Patient</h3>
        <div class="addPatient">
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

            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label3" runat="server" Text="Date Of Birth: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="DOB_TextBox" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DOB_TextBox" ErrorMessage="You have not selected a date of birth" ForeColor="Red" Display="Dynamic" ValidationGroup="group"></asp:RequiredFieldValidator>
            </div>
            <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label4" runat="server" Text="Address: "></asp:Label>
                <asp:TextBox CssClass="text-input" ID="Address_TextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Address_TextBox" Display="Dynamic" ErrorMessage="You have not entered an address" ForeColor="Red" ValidationGroup="group"></asp:RequiredFieldValidator>
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
            <div class="buttonmargin buttonmiddle">
                <asp:Button ID="AddPatientButton" runat="server" Text="Add Patient" OnClick="AddPatientButton_Click" ValidationGroup="group" />
            </div>
            <br />
            <asp:Label ID="successLabel" runat="server" Text=""></asp:Label>
        </div>
    </div>
</asp:Content>
