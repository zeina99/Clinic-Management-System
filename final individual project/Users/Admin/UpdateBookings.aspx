<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="UpdateBookings.aspx.cs" Inherits="final_individual_project.Users.Admin.UpdateBookings" %>
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
        <h2 class="dashboard-title">Update Bookings</h2>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                <asp:BoundField DataField="patient_id" HeaderText="patient_id" SortExpression="patient_id"></asp:BoundField>
                <asp:BoundField DataField="doctor_id" HeaderText="doctor_id" SortExpression="doctor_id"></asp:BoundField>
                <asp:BoundField DataField="reason" HeaderText="reason" SortExpression="reason"></asp:BoundField>
                <asp:BoundField DataField="slot_start" HeaderText="slot_start" SortExpression="slot_start"></asp:BoundField>
                <asp:BoundField DataField="slot_end" HeaderText="slot_end" SortExpression="slot_end"></asp:BoundField>
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status"></asp:BoundField>
                <asp:BoundField DataField="booking_date" HeaderText="booking_date" SortExpression="booking_date"></asp:BoundField>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ClinicConnection %>' SelectCommand="SELECT * FROM [Bookings]" DeleteCommand="DELETE FROM [Bookings] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Bookings] ([patient_id], [doctor_id], [reason], [slot_start], [slot_end], [status], [booking_date]) VALUES (@patient_id, @doctor_id, @reason, @slot_start, @slot_end, @status, @booking_date)" UpdateCommand="UPDATE [Bookings] SET [patient_id] = @patient_id, [doctor_id] = @doctor_id, [reason] = @reason, [slot_start] = @slot_start, [slot_end] = @slot_end, [status] = @status, [booking_date] = @booking_date WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="patient_id" Type="Int32" />
            <asp:Parameter Name="doctor_id" Type="Int32" />
            <asp:Parameter Name="reason" Type="String" />
            <asp:Parameter DbType="Time" Name="slot_start" />
            <asp:Parameter DbType="Time" Name="slot_end" />
            <asp:Parameter Name="status" Type="String" />
            <asp:Parameter DbType="Date" Name="booking_date" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="patient_id" Type="Int32" />
            <asp:Parameter Name="doctor_id" Type="Int32" />
            <asp:Parameter Name="reason" Type="String" />
            <asp:Parameter DbType="Time" Name="slot_start" />
            <asp:Parameter DbType="Time" Name="slot_end" />
            <asp:Parameter Name="status" Type="String" />
            <asp:Parameter DbType="Date" Name="booking_date" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

