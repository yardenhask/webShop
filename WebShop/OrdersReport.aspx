<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrdersReport.aspx.cs" Inherits="WebShop.OrdersReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    <asp:Label ID="searchText" runat="server" Text="Orders Report"  style="position:absolute;top:10%; left:40%;font-size:40px;width:500px; font-weight:bolder;"></asp:Label>
    <asp:SqlDataSource ID="SqlOrdersReport" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT Orders.OrderID, Clients.FirstName, Clients.LastName, Clients.Cellular, Clients.Mail, Orders.OrderDate, Orders.ShipmentDate FROM Orders INNER JOIN Clients ON Orders.ClientID = Clients.ClientID ORDER BY Orders.OrderDate DESC"></asp:SqlDataSource>
    <asp:Panel runat="server" CssClass="OrderDetail">
    <asp:GridView ID="OrdersReportGV" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="SqlOrdersReport" AllowPaging="True" PageSize="8" OnSelectedIndexChanged="OrdersReportGV_SelectedIndexChanged">
        <Columns>
            
            <asp:BoundField DataField="OrderID" HeaderText="Order Id" ReadOnly="True" InsertVisible="False" SortExpression="OrderID"></asp:BoundField>
            <asp:BoundField DataField="FirstName" HeaderText="Client First Name" SortExpression="FirstName"></asp:BoundField>
            <asp:BoundField DataField="LastName" HeaderText="Client Last Name" SortExpression="LastName"></asp:BoundField>
            <asp:BoundField DataField="Cellular" HeaderText="Client Cellular" SortExpression="Cellular"></asp:BoundField>
            <asp:BoundField DataField="Mail" HeaderText="Client Mail" SortExpression="Mail"></asp:BoundField>
            <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate"></asp:BoundField>
            <asp:BoundField DataField="ShipmentDate" HeaderText="Shipment Date" SortExpression="ShipmentDate"></asp:BoundField>
            <asp:CommandField ShowSelectButton="True" HeaderText="Show Order Items"></asp:CommandField>

        </Columns>
    </asp:GridView>
        </asp:Panel>
</asp:Content>
