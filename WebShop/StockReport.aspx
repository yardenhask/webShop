<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StockReport.aspx.cs" Inherits="WebShop.StockReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    <asp:Label ID="searchText" runat="server" Text="Items Stock" style="position:absolute;top:10%; left:40%;font-size:40px;width:500px; font-weight:bolder;"></asp:Label>
        
    <asp:SqlDataSource ID="SqlStockItems" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT Items.ItemID, Brands.BrandName, Items.Year, Items.ISBN, Items.Description, Items.PublishDate, Items.Price, Items.StokAmount FROM Items INNER JOIN Brands ON Items.BrandID = Brands.BrandID"></asp:SqlDataSource>
    <div style="padding-left:18%; padding-top:6%;">
        <asp:GridView ID="StockItemsGV" runat="server" AutoGenerateColumns="False" DataKeyNames="StokAmount"  PageSize="8" AllowPaging="True" OnPageIndexChanging="StockItemsGV_PageIndexChanging" OnPageIndexChanged="StockItemsGV_PageIndexChanged">
        <Columns>
            <asp:BoundField DataField="ItemID" HeaderText="ItemID" ReadOnly="True" InsertVisible="False" SortExpression="ItemID"></asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Name" SortExpression="Description"></asp:BoundField>
            <asp:BoundField DataField="BrandName" HeaderText="Brand Name" SortExpression="BrandName"></asp:BoundField>
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year"></asp:BoundField>
            <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN"></asp:BoundField>
            <asp:BoundField DataField="PublishDate" HeaderText="Publish Date" SortExpression="PublishDate"></asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price"></asp:BoundField>
            <asp:BoundField DataField="StokAmount" HeaderText="Stok Amount" SortExpression="StokAmount"></asp:BoundField>
        </Columns>
    </asp:GridView>
        </div>
</asp:Content>
