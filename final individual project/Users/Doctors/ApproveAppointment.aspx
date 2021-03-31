<%@ Page Title="" Language="C#" MasterPageFile="~/mainpage.Master" AutoEventWireup="true" CodeBehind="ApproveAppointment.aspx.cs" Inherits="final_individual_project.Users.Doctors.ApproveAppointment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SideBar" runat="server">

    <ul class="nav-style">
        <li> <a href="Dashboard.aspx" > Dashboard </a>  </li>
        <li> <a href="ApproveAppointment.aspx">Approve Appointments </a>  </li>
        <li> <a href="UpdateAccount.aspx">Update Account </a> </li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="booking-approval">
    <h2 class="dashboard-title">Bookings requiring Approval</h2>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ClinicConnection %>" DeleteCommand="DELETE FROM [Bookings] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Bookings] ([patient_id], [reason], [slot_start], [slot_end], [status], [booking_date]) VALUES (@patient_id, @reason, @slot_start, @slot_end, @status, @booking_date)" SelectCommand="SELECT [Id], [patient_id], [reason], [slot_start], [slot_end], [status], [booking_date]  FROM [Bookings] WHERE (([status] = @status) AND ([doctor_id] = @doctor_id))" UpdateCommand="UPDATE [Bookings] SET [patient_id] = @patient_id, [reason] = @reason, [slot_start] = @slot_start, [slot_end] = @slot_end, [status] = @status, [booking_date] = @booking_date WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="patient_id" Type="Int32" />
            <asp:Parameter Name="reason" Type="String" />
            <asp:Parameter DbType="Time" Name="slot_start" />
            <asp:Parameter DbType="Time" Name="slot_end" />
            <asp:Parameter Name="status" Type="String" />
            <asp:Parameter DbType="Date" Name="booking_date" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="pending" Name="status" Type="String" />
            <asp:SessionParameter Name="doctor_id" SessionField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="patient_id" Type="Int32" />
            <asp:Parameter Name="reason" Type="String" />
            <asp:Parameter DbType="Time" Name="slot_start" />
            <asp:Parameter DbType="Time" Name="slot_end" />
            <asp:Parameter Name="status" Type="String" />
            <asp:Parameter DbType="Date" Name="booking_date" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        </asp:SqlDataSource>

       
    



    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="patient_id" HeaderText="patient_id" SortExpression="patient_id" />
            <asp:BoundField DataField="reason" HeaderText="reason" SortExpression="reason" />
            <asp:BoundField DataField="slot_start" HeaderText="slot_start" SortExpression="slot_start" />
            <asp:BoundField DataField="slot_end" HeaderText="slot_end" SortExpression="slot_end" />
            <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
            <asp:BoundField DataField="booking_date" HeaderText="booking_date" SortExpression="booking_date" />

        </Columns>
    </asp:GridView>

    <h3 class="subtitle">Update Status of booking</h3>
        <br />
        <div class="profile-section">
            <div class="approve-inputs">
                <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label1" runat="server" Text="Booking ID: "></asp:Label>
                <asp:DropDownList CssClass="user-dropdown-approve" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Id" DataValueField="Id">
                </asp:DropDownList>
                    </div>
                <div class="input-fields">
                <asp:Label CssClass="listtitle" ID="Label2" runat="server" Text="Status: "></asp:Label>
                <asp:DropDownList CssClass="user-dropdown-approve" ID="DropDownList1" runat="server">
                    <asp:ListItem>pending</asp:ListItem>
                    <asp:ListItem>approved</asp:ListItem>
                    <asp:ListItem>rejected</asp:ListItem>
                </asp:DropDownList>
                    </div>
            </div>
            <asp:Button CssClass="buttonmargin" ID="UpdateButton" runat="server" Text="Update" ValidationGroup="group2" OnClick="UpdateButton_Click" />


            <br />

            <asp:Label ID="SuccessLabel" runat="server"></asp:Label>

        </div>
        </div>

</asp:Content>
