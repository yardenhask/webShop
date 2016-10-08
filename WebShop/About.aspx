<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebShop.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    <asp:Label ID="txt" runat="server" CssClass="about1">
        <span style="padding-left:70px;"></span>The difficulties in this task where buldiing the Database, connecting and delivering data. <br />
        We also encountered problems in dividing the responsibility between the client side and the server side.
    </asp:Label><br />
    <asp:Table ID="Table1" runat="server" CssClass="about2">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" ID="tomer" >
                Tomer Doitshman <br />
                201053170 <br />
                Information system engineering <br /> in BGU. <br />
                <asp:Button ID="tomerSite" CssClass="loginSectionB" runat="server" Text="Visit my site"  OnClick="tomerSite_Click"  />
            </asp:TableCell>
            <asp:TableCell runat="server" ID="yarden">
                Yarden Haskal <br />
                305242166 <br />
                Information system engineering in BGU. <br />
                <asp:Button ID="yardenSite" CssClass="loginSectionB" runat="server" Text="Visit my site" OnClick="yardenSite_Click"  />
            </asp:TableCell>
        </asp:TableRow>
        
        <asp:TableFooterRow runat="server">
            <asp:TableCell runat="server" CssClass="about3">
                <asp:Button ID="common" CssClass="loginSectionB" runat="server" Text="Our previous page" OnClick="common_Click"  />
            </asp:TableCell>
        </asp:TableFooterRow>
    </asp:Table>
</asp:Content>
