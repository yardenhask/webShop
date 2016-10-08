<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="searchMenu.aspx.cs" Inherits="WebShop.searchMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    <div style="padding-left:30%; padding-top:4%;">

   
    <asp:Button ID="siteSearchB" runat="server" Text="Search in Site for Items" Font-Size="25" Width="470" Height="100" CssClass="loginSectionB" OnClick="siteSearchB_Click"/>
        <br />
    <asp:Button ID="angularSearchB" runat="server" Text="Search for Movie with Angular" Font-Size="25" Width="470" Height="100" CssClass="loginSectionB" OnClick="angularSearchB_Click" />
         </div>
</asp:Content>

