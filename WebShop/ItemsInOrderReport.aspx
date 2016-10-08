<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ItemsInOrderReport.aspx.cs" Inherits="WebShop.ItemsInOrderReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">

    <asp:Label ID="searchText" runat="server" Text="Items In Order" style="position:absolute;top:10%; left:40%;font-size:40px;width:500px; font-weight:bolder;"></asp:Label>


    <asp:SqlDataSource ID="SqlItemsReport" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT ItemsInOrders.ItemID, ItemsInOrders.Amount, Items.Description, Brands.BrandName FROM ItemsInOrders INNER JOIN Items ON ItemsInOrders.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE (ItemsInOrders.OrderID = @orderid)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="orderid" Name="orderid"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <div style="padding-left:37%; padding-top:6%;">
    <asp:GridView ID="ItemsReportGV" runat="server" AutoGenerateColumns="False" DataSourceID="SqlItemsReport" AllowPaging="True" PageSize="5">
        <Columns>
            <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Name" SortExpression="Description"></asp:BoundField>
            <asp:BoundField DataField="BrandName" HeaderText="BrandName" SortExpression="BrandName"></asp:BoundField>
            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
            
        </Columns>
    </asp:GridView>
    </div>
    <div style="position:absolute; left:40%; top:80%;">
    <asp:Button ID="ItemsInOrderBackB" CssClass="loginSectionB" Width="220" runat="server" Text="Back" OnClick="ItemsInOrderBackB_Click" />
        </div>
</asp:Content>
