<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientsReport.aspx.cs" Inherits="WebShop.ClientsReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
        <asp:Label ID="searchText" runat="server" Text="Clients" style="position:absolute;top:10%; left:45%;font-size:40px;width:500px; font-weight:bolder;"></asp:Label>

    
    <asp:SqlDataSource ID="SqlClientsReport" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT NickName, ClientID, FirstName, LastName, Adress, City, Country, Phone, Cellular, Mail FROM Clients WHERE (isADmin = 0)"></asp:SqlDataSource>
    <div style="padding-left:13%; padding-top:6%;">
        <asp:GridView ID="ClientsReportGV" runat="server" DataSourceID="SqlClientsReport" AllowPaging="True" PageSize="8" AutoGenerateColumns="False" DataKeyNames="ClientID">
            <Columns>
                <asp:BoundField DataField="ClientID" HeaderText="Client ID" ReadOnly="True" SortExpression="ClientID"></asp:BoundField>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"></asp:BoundField>
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName"></asp:BoundField>
                <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country"></asp:BoundField>
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>                
                <asp:BoundField DataField="Adress" HeaderText="Adress" SortExpression="Adress"></asp:BoundField>
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                <asp:BoundField DataField="Cellular" HeaderText="Cellular" SortExpression="Cellular"></asp:BoundField>
                <asp:BoundField DataField="Mail" HeaderText="Mail" SortExpression="Mail"></asp:BoundField>
            </Columns>
        </asp:GridView>
        </div>
</asp:Content>
