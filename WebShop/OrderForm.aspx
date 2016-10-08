<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderForm.aspx.cs" Inherits="WebShop.OrderForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
    
    <asp:Label runat="server" ID="missingTitle" Text="Tho Following items are missing:" CssClass="orderTitle"></asp:Label>
    <div runat="server" id="missingLV" style="padding-left:42%; padding-top:0%;">
    <asp:ListView ID="itemsStockLV" runat="server">
        <AlternatingItemTemplate>
           <tr style="">
                 <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Missing") %>' runat="server" ID="avilableLabel" /></td>
               
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("Missing") %>' runat="server" ID="avilableTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("Missing") %>' runat="server" ID="avilableTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
           <tr style="">
                 <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Missing") %>' runat="server" ID="avilableLabel" /></td>
               
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                            <tr runat="server" style="">
                                <th runat="server">Name</th>
                                <th runat="server">Missing</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style=""></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Label Text='<%# Eval("Missing") %>' runat="server" ID="avilableLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    </div>
    <div style="padding-left:37%; padding-top:2%;">
            <asp:Label runat="server" ID="Label1" Text="Select Shipment Date:" ></asp:Label>
            
                <script type="text/javascript">
                    function dateSelectionChanged(sender, args) {
                        selectedDate = sender.get_selectedDate();
                        var currentDate = new Date();
                        var x = selectedDate - currentDate;
                        x = x / (60 * 60 * 24 * 1000);
                        if (x < 6) {
                            alert("Date should at least a week from now");
                            document.getElementById('<%=txtDate.ClientID%>').value="";
                        }
                    }
                </script>
                <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       
                <ajaxtoolkit:CalendarExtender ID="CalendarExtender1" runat="server"
                        OnClientDateSelectionChanged="dateSelectionChanged"
                        TargetControlID="txtDate" PopupButtonID="imgCalendar">
                </ajaxtoolkit:CalendarExtender>       
            <asp:UpdatePanel runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CurrencyDDL" EventName="SelectedIndexChanged" />
                </Triggers>
                <ContentTemplate>
                    <div style="padding-left:20px;">
                    <asp:Label ID="totalLBL" runat="server" Text="TotalPrice: "></asp:Label>
                    <asp:Label ID="totalPriceLBL" runat="server"></asp:Label>
                    <asp:DropDownList ID="CurrencyDDL" CssClass="ddl" runat="server" OnSelectedIndexChanged="CurrencyDDL_SelectedIndexChanged" AutoPostBack="true">

                        <asp:ListItem>NIS</asp:ListItem>
                        <asp:ListItem>American Dollar</asp:ListItem>
                    </asp:DropDownList>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        <div style="padding-left:40px;">
            <asp:Button ID="OrderButton" runat="server" Text="Purchase" CssClass="loginSectionB" OnClick="OrderButton_Click" />
           <div id="orderRecived" runat="server">
               <asp:Label ID="orderRecived1" runat="server" Text="Your Order Accepted."></asp:Label> <br />
               <asp:Label ID="orderRecived2" runat="server" Text="Order Number: "></asp:Label>
               <asp:Label ID="orderIdLBL" runat="server"></asp:Label>
            </div>
        </div>
      </div>
    
    <br />
    
</asp:Content>
