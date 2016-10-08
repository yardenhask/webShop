<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchForm.aspx.cs" Inherits="WebShop.SearchForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    <style>
        .searchB{
        margin:8px;
	    height:30px;
	    width:250px;
	    font-family: 'Poiret One', cursive;
	    font-size:20px;
	    color:#D6E5A3;
	    font-weight:bold;
	    background:#546E50;
	    border:2px solid #394944;
	    border-radius:8px;
      }
     
      .emptyCartTitle{
          position:absolute;
          left:40%;
          top:5%;
          font-size:40px;
          width:500px;
      }
      .title2{
          position:absolute;
          top:25%;
          left:35%;
          font-size:32px;
          width:500px;
      }
      .itemDiv{
            max-height:150px;
            max-width:150px;
            overflow: hidden;
            padding-left:6px;
        }
        .itemDetails{
            font-size:22px; 
            vertical-align:bottom; 
            position:absolute;
            top:20px;
            opacity: 0;
            color:#546E50;
            transition: all 300ms ease-out;
        }
        .itemClass{
            font-size:16px; 
            font-weight:bold;
            background:#E2D3DD;
        }
        .itemDiv:hover .itemImage{
            opacity:0.5;
            transform: scale(1.4);
            max-width: 150px;
        }
        .itemDiv:hover .itemDetails{
            opacity:1;
            transform: translateY(10px);
        }
        .itemImage{
            display: inline-block;
            transition: all 300ms;
            width: 120px;
            height:120px;
            overflow: hidden;
            
        }
        .addToCartB{
            position:relative;
            float:right;
        }
    </style>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="searchDiv" runat="server" style="position:absolute; left:35%; top:10%; width:25%; height:20%; padding-left:2px;">
                <asp:Label ID="searchText" runat="server" Text="Search Items"  style="position:absolute;top:-20%; left:35%;font-size:40px;width:500px; font-weight:bolder;"></asp:Label>
            
            <asp:TextBox ID="searchTB" runat="server" style="position:absolute; left:20%; top:35%;width:180px; height:20px;"></asp:TextBox> <br />
          <br /> 
            <asp:DropDownList ID="searchDDL" runat="server" style="position:absolute; left:75%; top:35%; font-size:20px;">
                <asp:ListItem>Item Name</asp:ListItem>
                <asp:ListItem>Category</asp:ListItem>
                <asp:ListItem>Brand</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="searchSearchButton" runat="server" Text="Search" CssClass="searchB" style="position:absolute; left:20%; top:65%; width:300px;" OnClick="searchSearchButton_Click" />
                </div>
            <div id="results" style="position:absolute; top:35%; left:10%;">
                <asp:ListView ID="searchListView" runat="server" GroupItemCount="6" DataKeyNames="ItemID" OnItemCommand="ListView_ItemCommand" EnablePersistedSelection="True" OnPagePropertiesChanged="searchListView_PagePropertiesChanged">
                    <AlternatingItemTemplate>
                        <td runat="server" class="itemClass">
                            <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                                    <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                            <div runat="server" style="float:left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                Category:<asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                                Brand:<asp:Label Text='<%# Eval("BrandName") %>' runat="server" ID="BrandNameLabel" /><br />
                            </div>
                            <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </asp:Panel>
                        </td>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                       <td runat="server" class="itemClass">
                            <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                                    <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                            <div runat="server" style="float:left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                Category:<asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                                Brand:<asp:Label Text='<%# Eval("BrandName") %>' runat="server" ID="BrandNameLabel" /><br />
                            </div>
                            <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </asp:Panel>
                        </td>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <EmptyItemTemplate>
                        <td runat="server" />
                    </EmptyItemTemplate>
                    <GroupTemplate>
                        <tr runat="server" id="itemPlaceholderContainer">
                            <td runat="server" id="itemPlaceholder"></td>
                        </tr>
                    </GroupTemplate>
                    <InsertItemTemplate>
                       <td runat="server" class="itemClass">
                            <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                                    <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                            <div runat="server" style="float:left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                Category:<asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                                Brand:<asp:Label Text='<%# Eval("BrandName") %>' runat="server" ID="BrandNameLabel" /><br />
                            </div>
                            <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </asp:Panel>
                        </td>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <td runat="server" class="itemClass">
                            <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                                    <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                            <div runat="server" style="float:left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                Category:<asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                                Brand:<asp:Label Text='<%# Eval("BrandName") %>' runat="server" ID="BrandNameLabel" /><br />
                            </div>
                            <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </asp:Panel>
                        </td>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="groupPlaceholderContainer" style="" border="0">
                                        <tr runat="server" id="groupPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style="">
                                    <asp:DataPager runat="server" PageSize="6" ID="DataPager2">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <td runat="server" class="itemClass">
                            <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                                    <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                            <div runat="server" style="float:left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                Category:<asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                                Brand:<asp:Label Text='<%# Eval("BrandName") %>' runat="server" ID="BrandNameLabel" /><br />
                            </div>
                            <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </asp:Panel>
                        </td>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT Categories.CategoryName, Items.Description, Items.PicturePath, Items.Price, Brands.BrandName, Items.ItemID FROM ItemCategories INNER JOIN Categories ON ItemCategories.CategoryID = Categories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID"></asp:SqlDataSource>
            </div>
            

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
