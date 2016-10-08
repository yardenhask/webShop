<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ItemForm.aspx.cs" Inherits="WebShop.ItemForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    <asp:SqlDataSource ID="sqlItem" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT Items.ItemID, Items.Year, Items.ISBN, Items.Description, Items.PicturePath, Items.PublishDate, Items.Price, Items.StokAmount, Brands.BrandName FROM Items INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE (Items.ItemID = @ItemID)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="itemid" Name="ItemID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="FormView1" runat="server" DataSourceID="sqlItem" DataKeyNames="ItemID">
        <ItemTemplate>
            <br />
            <span style="position:relative; float:left; padding-left:250px;">
               <asp:Image ID="Image1" runat="server" CssClass="itemImg"  ImageUrl='<%# Eval("PicturePath") %>'  />
            </span>

            <span style="position:relative; float:left; font-size:25px; padding-left:50px;">
                <br /> 
                ItemID:
                  <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="ItemIDLabel" /><br />
                Name:
                   <asp:Label Text='<%# Bind("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                BrandName:
                    <asp:Label Text='<%# Bind("BrandName") %>' runat="server" ID="BrandNameLabel" /><br />
                Year:
                   <asp:Label Text='<%# Bind("Year") %>' runat="server" ID="YearLabel" /><br />
                Price:
                    <asp:Label Text='<%# Bind("Price") %>' runat="server" ID="PriceLabel" /><br />
               PublishDate:
                  <asp:Label Text='<%# Bind("PublishDate") %>' runat="server" ID="PublishDateLabel" /><br /> 
                StokAmount:
                    <asp:Label Text='<%# Bind("StokAmount") %>' runat="server" ID="StokAmountLabel" /><br />
            </span>


        </ItemTemplate>
    </asp:FormView>
</asp:Content>
