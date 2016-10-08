<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index1.aspx.cs" Inherits="WebShop.index1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
     <asp:Label ID="UserHelloLB" runat="server" Text="Hello Guest,   " ></asp:Label>
     <asp:Label ID="UserLastVisitLB" runat="server" Text=" Last visit" Visible="false" ></asp:Label>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server"  >
    <style>
        .itemDetails{
            font-size:22px; 
            vertical-align:bottom; 
            position:absolute;
            top:20px;
            opacity: 0;
            color:#546E50;
            transition: all 300ms ease-out;
        }
        .cartB{
            position:relative;
            float:right;
            font-size:18px;
            align-content:center; 
            align-items:center;
        }

        .addToCartB{
            position:relative;
            float:right;
        }
        .itemDiv{
            max-height:150px;
            max-width:150px;
            overflow: hidden;
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
        
        .itemImage{
            display: inline-block;
            transition: all 300ms;
            width: 120px;
            height:120px;
            overflow: hidden;
        }
        

        .itemDiv:hover .itemDetails{
            opacity:1;
            transform: translateY(10px);
        }
    </style>
    

    <div id="loginSection" runat="server" style="position:relative ; top:2%;  left: 50%; margin-right: -40%; transform: translate(-15%, 0) ;">
        <asp:Label ID="loginUserNameLB" runat="server" Text="User Name"></asp:Label>  
        <asp:TextBox ID="loginUserNameTB" runat="server" ></asp:TextBox>
        <asp:Label ID="loginPassLB" runat="server" Text="Password"></asp:Label>
        
        <input id="loginPassTB" runat="server" type="password" />

        
        <asp:Label ID="valid1" runat="server" ></asp:Label>
        <br />
        <asp:Button ID="loginSignInButton" runat="server" Text="Login" OnClick="loginSignInButton_Click" CssClass="loginSectionB" />
        <asp:button runat="server" id="loginRegisterButton" text="Register" OnClick="loginRegisterButton_Click" CssClass="loginSectionB"/>
        <br/> 
        <asp:Button ID="forgotB" runat="server" Text="Forgot Your Password?" OnClick="forgotB_Click" CssClass="loginSectionB" Width="522"></asp:Button>
        <div runat="server" id="recoverPasswordSection" visible="false">
            <asp:Label ID="recoverPassUsernameLB" runat="server" Text="User Name:"></asp:Label>
            <asp:TextBox ID="recoverPassUsernameTB" runat="server"></asp:TextBox>
            <asp:Label ID="recoverPassEmailLB" runat="server" Text="E-mail:"></asp:Label>
            <asp:TextBox ID="recoverPassEmailTB" runat="server"></asp:TextBox> 
            <asp:Label ID="recoveredPassLB" runat="server" ></asp:Label><br />
            <asp:Button ID="recoverPassB" runat="server" Text="Help!" OnClick="recoverPassB_Click" CssClass="loginSectionB" Width="522"/>
        </div>
    </div>


    <div id="bestSellerSection" runat="server" style="position:absolute; left: 29.5%; top:53%;">
        <asp:Label runat="server" Text="Best Seller" style="font-size:60px; font-weight:bolder; position:absolute; left:-25%; top:10%; width:60px; padding-left:40px;"></asp:Label>  
        <asp:SqlDataSource ID="IndexFiveBestDS" runat="server" ConnectionString="<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>" SelectCommand="SELECT TOP (5) Items.PicturePath, Items.Description, Items.ItemID, Items.Price FROM Items INNER JOIN ItemsInOrders ON Items.ItemID = ItemsInOrders.ItemID GROUP BY Items.ItemID, Items.PicturePath, Items.Description, Items.BrandID, Items.Price ORDER BY SUM(ItemsInOrders.Amount) DESC"></asp:SqlDataSource>
        <asp:ListView ID="FiveBestSellerLV" runat="server" DataSourceID="IndexFiveBestDS" DataKeyNames="ItemID" OnItemCommand="ListView_ItemCommand" EnablePersistedSelection="true">
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
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB">
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
    
    <div id="newItemSection" style=" position:absolute ; left: 18%; top:5%;" runat="server">
        <asp:Label runat="server" Text="New Items" style="font-size:60px; font-weight:bolder; position:absolute; right:-25%; top:10%; width:60px; padding-right:120px;"></asp:Label>
        <asp:ListView ID="newItemLV" runat="server" DataSourceID="NewItemsDB" DataKeyNames="ItemID" OnItemCommand="ListView_ItemCommand" EnablePersistedSelection="true">
            <AlternatingItemTemplate>
                <td runat="server" class="itemClass">
                    <div runat="server" class="itemDiv">
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                            <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                    <div runat="server" style="float: left;">
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
                    <div runat="server" style="float: left;">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB" >
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
                    <div runat="server" style="float: left;">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB" >
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
                    <div runat="server" style="float: left;">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB" >
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
                    <div runat="server" style="float: left;">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB" >
                        <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                </td>
            </SelectedItemTemplate>
        </asp:ListView>
        <br />
        <asp:SqlDataSource ID="NewItemsDB" runat="server" ConnectionString="<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>" SelectCommand="SELECT top(5) Price, Description, PicturePath, ItemID FROM Items WHERE ({ fn CURDATE() } - PublishDate <= 30) ORDER BY PublishDate"></asp:SqlDataSource>
    </div>    
</asp:Content>
