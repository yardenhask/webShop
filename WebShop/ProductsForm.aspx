<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductsForm.aspx.cs" Inherits="WebShop.ProductsForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
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
            top:130px;
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
            max-width: 200px;
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
        .cartB{
            position:relative;
            float:right;
            font-size:18px;
            align-content:center; 
            align-items:center;
        }
        .addToCartProducts{
            position:absolute;
            bottom:0%;
            left:40%;
        }
    </style>
       
     <asp:ScriptManager ID="ScriptManager2" runat="server" />
     <asp:Label ID="addedToCartLBL" runat="server"  CssClass="addToCartProducts" ></asp:Label>

    <div id="allProducts" runat="server" style="position: absolute;left:0;top:5%;height:80%;width:80%;" >
        <asp:Label runat="server" Text="Products" style="font-size:45px; font-weight:bolder; padding-left:40%;"></asp:Label>  
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div runat="server" style="padding-left:40px;">
                <asp:Label runat="server" Text="Filter by:" style="padding-left:5px; font-size:30px;"></asp:Label>
                <asp:DropDownList ID="catDDL" runat="server" AppendDataBoundItems="true" CssClass="ddl" DataSourceID="SqlCats" DataTextField="CategoryName" DataValueField="CategoryName">
                    <asp:ListItem Text=" " Value=" " />
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="SqlCats" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT [CategoryName] FROM [Categories]"></asp:SqlDataSource>
                <asp:Button ID="selectCatB" runat="server" Text="select" CssClass="loginSectionB" Width="150" OnClick="selectCatB_Click" />
                <asp:Button ID="initB" runat="server" Text="initialize" CssClass="loginSectionB" Width="150" OnClick="initB_Click" />
                <asp:Button ID="ProductsSortInc" runat="server" Text="Price low to high" CssClass="loginSectionB" Width="150" OnClick="ProductsSortInc_Click" />
                <asp:Button ID="ProductsSortDec" runat="server" Text="Price high to low"  CssClass="loginSectionB" Width="150" OnClick="ProductsSortDec_Click" />
               </div>
                <asp:Label ID="sortinOn" runat="server" Visible="false" Text=""></asp:Label>
                <div runat="server" style="padding-left:50px; padding-top:20px;">
                <asp:ListView ID="ListViewAllProducts" runat="server" GroupItemCount="6" OnPagePropertiesChanged="ListViewAllProducts_PagePropertiesChanged" DataKeyNames="ItemID" OnItemCommand="ListView_ItemCommand" EnablePersistedSelection="true" >
                     <AlternatingItemTemplate>
                         <td runat="server" class="itemClass">
                             <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="150" Width="150" />
                                    <span class="itemDetails"><span style="position: absolute; width: 120px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                            <div runat="server" style="float: left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                <asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                            </div>
                            <div runat="server" class="cartB">
                                <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </div>
                             <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="ItemIDLabel" visible="false"/>
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
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                <asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                            </div>
                            <div runat="server" class="cartB">
                                <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </div>
                             <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="ItemIDLabel" visible="false"/>
                        </td>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data .</td>
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
                            <div runat="server" style="float: left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                <asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                            </div>
                            <div runat="server" class="cartB">
                                <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </div>
                             <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="ItemIDLabel" visible="false"/>
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
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                <asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                            </div>
                            <div runat="server" class="cartB">
                                <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </div>
                             <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="ItemIDLabel" visible="false"/>
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
                                <td runat="server" style="padding-left:48%;">
                                    <asp:DataPager runat="server" PageSize="6" ID="DataPager1" EnableViewState="false">
                                        <Fields>
                                            <asp:NumericPagerField></asp:NumericPagerField>
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
                            <div runat="server" style="float: left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                                <asp:Label Text='<%# Eval("CategoryName") %>' runat="server" ID="CategoryNameLabel" /><br />
                            </div>
                            <div runat="server" class="cartB">
                                <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </div>
                             <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="ItemIDLabel" visible="false"/>
                        </td>
                    </SelectedItemTemplate>
                </asp:ListView>
                    </div>

               
            </ContentTemplate>
           
        </asp:UpdatePanel>
    </div>

    <div id="recommended" runat="server" style="position: absolute;left:80%;top:5%;height:80%;width:40%;">
        <asp:Label runat="server" Text="Recommended" style="font-size:40px; font-weight:bolder;"></asp:Label>  
        <br />
        <asp:ListView ID="ListViewRecommended" runat="server" DataSourceID="SqlRecommended" DataKeyNames="ItemID" OnItemCommand="ListView_ItemCommand" EnablePersistedSelection="true">
            <AlternatingItemTemplate>
                 <td runat="server" class="itemClass2" >
                    <div runat="server" class="itemDiv2" >
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage2" ImageUrl='<%# Eval("PicturePath") %>' Height="100" Width="100" />
                            <span class="itemDetails2"><span style=" width: 80px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                  <div runat="server" style="padding-left:15px; padding-bottom:15px;">
                    <div runat="server" style="">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB2">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                      </div>
                </td>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                 <td runat="server" class="itemClass2" >
                    <div runat="server" class="itemDiv2" >
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage2" ImageUrl='<%# Eval("PicturePath") %>' Height="100" Width="100" />
                            <span class="itemDetails2"><span style=" width: 80px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                  <div runat="server" style="padding-left:15px; padding-bottom:15px;">
                    <div runat="server" style="">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB2">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                      </div>
                </td>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>No data for guest user.</span>




            </EmptyDataTemplate>
            <InsertItemTemplate>
                 <td runat="server" class="itemClass">
                     <span style="">
                         <div runat="server" class="itemDiv">
                                <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                                    <asp:Image ID="Image1" runat="server" CssClass="itemImage" ImageUrl='<%# Eval("PicturePath") %>' Height="100" Width="100" />
                                    <span class="itemDetails"><span style=" width: 80px; background: #D0D3A0;">Show Details </span></span>
                                </a>
                            </div>
                     </span>
                     <span style="">
                         <div runat="server" style="float: left;">
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="Label1" /><br />
                                Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="Label2" /><br />
                            </div>
                            <div runat="server" class="cartB">
                                <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                            </div>
                     </span>
                             <asp:Label Text='<%# Eval("ItemID") %>' runat="server" ID="Label3" visible="false"/>
                 </td>
            </InsertItemTemplate>
            <ItemTemplate>
              <td runat="server" class="itemClass2" >
                    <div runat="server" class="itemDiv2" >
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage2" ImageUrl='<%# Eval("PicturePath") %>' Height="100" Width="100" />
                            <span class="itemDetails2"><span style=" width: 80px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                  <div runat="server" style="padding-left:15px; padding-bottom:15px;">
                    <div runat="server" style="">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB2">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                      </div>
                </td>
            </ItemTemplate>
            <LayoutTemplate>
                <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                <div style="">
                    

                </div>




            </LayoutTemplate>
            <SelectedItemTemplate>
                 <td runat="server" class="itemClass2" >
                    <div runat="server" class="itemDiv2" >
                        <a href="ItemForm.aspx?itemid=<%# Eval("ItemID") %>">
                            <asp:Image ID="Image1" runat="server" CssClass="itemImage2" ImageUrl='<%# Eval("PicturePath") %>' Height="100" Width="100" />
                            <span class="itemDetails2"><span style=" width: 80px; background: #D0D3A0;">Show Details </span></span>
                        </a>
                    </div>
                  <div runat="server" style="padding-left:15px; padding-bottom:15px;">
                    <div runat="server" style="">
                        <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                        Price:<asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" /><br />
                    </div>
                    <asp:Panel ID="bestSellerAddToCart" runat="server" CssClass="addToCartB2">
                          <asp:LinkButton ID="addToCartB" runat="server" CommandName="select" BorderWidth="1" Text="  + Cart" Width="40" ForeColor="#546E50" BorderColor="#546E50" BackColor="#D0D3A0"></asp:LinkButton>
                    </asp:Panel>
                      </div>
                </td>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlRecommended" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT top 3  Items.ItemID, Items.Description, Items.PicturePath, Items.Price FROM ClientCategory INNER JOIN ItemCategories ON ClientCategory.CategoryID = ItemCategories.CategoryID INNER JOIN Items ON ItemCategories.ItemID = Items.ItemID WHERE (ClientCategory.ClientID = @clientid) ORDER BY Items.Price">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="clientid" Name="clientid"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
      </div>


</asp:Content>
