<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CartForm.aspx.cs" Inherits="WebShop.CartForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server" >
  <style>
     
     
     
      .itemDiv{
            max-height:150px;
            max-width:150px;
            overflow: hidden;
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
      <asp:Panel runat="server" ID="noCartP" >
        <asp:Label runat="server" ID="noCart" Text="The Cart Is Empty." CssClass="emptyCartTitle"></asp:Label> <br />
        <asp:Label runat="server" ID="recommendedCart" Text="This Items Recommended For You: " CssClass="title2"></asp:Label>
        <asp:SqlDataSource ID="SqlRecommended" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT top 5  Items.ItemID, Items.Description, Items.PicturePath, Items.Price FROM ClientCategory INNER JOIN ItemCategories ON ClientCategory.CategoryID = ItemCategories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID WHERE (ClientCategory.ClientID = @clientid) ORDER BY Items.Price">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="clientid" Name="clientid"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
          <div id="LV" runat="server" style="position:absolute; top:40%;left:23%;  ">

              <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource> 
        <asp:ListView ID="recommendedLV" runat="server" DataSourceID="SqlRecommended" DataKeyNames="ItemID" OnItemCommand="ListView_ItemCommand">
            <AlternatingItemTemplate>
                <td runat="server" class="itemClass">
                    <div runat="server" class="itemDiv">
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                            <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                    <div runat="server" style="float:left;">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB" >
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
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
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                </td>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <td runat="server" class="itemClass">
                    <div runat="server" class="itemDiv">
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                            <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                    <div runat="server" style="float:left;">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
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
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                </td>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server" style="" border="0">
                    <tr runat="server" id="itemPlaceholderContainer">
                        <td runat="server" id="itemPlaceholder"></td>
                    </tr>
                </table>

                <div style="">
                    <asp:DataPager runat="server" ID="DataPager3" PageSize="5">
                    </asp:DataPager>
                </div>
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
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                </td>
            </SelectedItemTemplate>
        </asp:ListView>
              </div>
    </asp:Panel>
    

    <asp:Panel runat="server" ID="cart">
        <div style="padding-left:30%; padding-top:2%;">
            <asp:GridView ID="CartGV" runat="server" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="CartSql" OnRowCommand="GridView1_RowCommand" AllowPaging="True" PageSize="5" OnRowDeleted="CartGV_RowDeleted">
            <Columns>
                <asp:CommandField ShowDeleteButton="True"></asp:CommandField>
                <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID"></asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Name" SortExpression="Description"></asp:BoundField>
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price"></asp:BoundField>
                <asp:BoundField DataField="ClientID" HeaderText="ClientID" SortExpression="ClientID" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="BrandName" HeaderText="BrandName" SortExpression="BrandName"></asp:BoundField>
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                <asp:BoundField DataField="Money" HeaderText="Total Money" ReadOnly="True" SortExpression="Money"></asp:BoundField>
                
                <asp:ButtonField CommandName="UpdateMinus" Text="-" ButtonType="Button"></asp:ButtonField>
                <asp:ButtonField CommandName="UpdatePlus" Text="+" ButtonType="Button"></asp:ButtonField>

            </Columns>
        </asp:GridView>
            </div>
        <asp:SqlDataSource ID="CartSql" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>'
            SelectCommand="SELECT Items.Description, Items.Price, Carts.ClientID, Brands.BrandName, ItemsInCart.Amount As Amount, ItemsInCart.Amount * Items.Price AS Money, ItemsInCart.ItemID FROM Carts INNER JOIN ItemsInCart ON Carts.CartID = ItemsInCart.CartID INNER JOIN Items ON ItemsInCart.ItemID = Items.ItemID INNER JOIN Brands ON Items.BrandID = Brands.BrandID WHERE (Carts.ClientID = @clientid)"
            DeleteCommand="DELETE FROM ItemsInCart FROM ItemsInCart WHERE ItemID=@itemid "
            InsertCommand="INSERT INTO ItemsInCart(CartID, ItemID, Amount) VALUES (@cartid, @itemid, 1)">
            <InsertParameters>
                <asp:QueryStringParameter QueryStringField="cartid" Name="cartid"></asp:QueryStringParameter>
                <asp:QueryStringParameter QueryStringField="itemid" Name="itemid"></asp:QueryStringParameter>
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="clientid" Name="clientid"></asp:QueryStringParameter>
            </SelectParameters>

            <DeleteParameters>
                <asp:Parameter Name="itemid" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <div class="totalP">
        <asp:Label ID="totalPriceLBL" runat="server" Text="total price:" ></asp:Label>
        <asp:Label ID="priceLBL" runat="server"></asp:Label>
            </div>
        <div style="padding-top:2%;padding-left:41%;">
        <asp:Button runat="server" Text="Move to Payment" OnClick="payment_Click" CssClass="payB" />
            </div>
    </asp:Panel>
   


</asp:Content>
