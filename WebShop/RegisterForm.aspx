<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="WebShop.RegisterForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerHolder" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="server">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>  
     <style type ="text/css" >  
        label.error {             
            color: red;   
            display:inline-flex ;                 
        }  
        #part1{
            position:relative;
            float:left;

            padding-left:20%;
        }
        #part2{
            position:relative;
            float:right;
            padding-right:20%;
        }
        #part3{
            position:absolute;
            bottom:2%;
            padding-left:40%;
            padding-right:40%;
        }
    </style>  
     <script type ="text/javascript" >      
        
         jQuery.validator.addMethod("lettersonly", function(value, element) {
             return this.optional(element) || /^[a-zA-z]+$/i.test(value);
         }, "Letters only please");
         jQuery.validator.addMethod("lettersNumbers", function(value, element) {
             return this.optional(element) || /^[a-zA-Z0-9]+$/i.test(value);
         }, "Letters and numbers only please");
         function valid () {  
             $("#form1").validate({  
                 errorElement: 'span', 
                 errorClass: "error",
                 rules: {  
                     <%=registerUserNameTB.UniqueID %>:{  
                            required:true  ,
                            minlength:3 ,
                            maxlength:8,
                            lettersonly: true
                        },   
                        <%=registerPasswordTB.UniqueID %>:{  
                        required:true  ,
                        minlength: 5,
                        maxlength:10 ,
                        lettersNumbers:true
                    }, 
                        <%=registerIDTB.UniqueID %>:{  
                        required:true  
                    }, 
                        <%=registerFirstNameTB.UniqueID %>:{  
                        required:true  
                    }, 
                        <%=registerLastNameTB.UniqueID %>:{  
                        required:true  
                    }, 
                        <%=registerNicknameTB.UniqueID %>:{  
                          
                    }, 
                        <%=registerPhoneNumTB.UniqueID %>:{  
                        
                    }, 
                        <%=registerCellphoneTB.UniqueID %>:{  
                        required:true  
                    }, 
                        <%=registerAdrressTB.UniqueID %>:{  
                        required:true  
                    }, 
                        <%=registerCityTB.UniqueID %>:{  
                        required:true  
                    }, 
                        <%=registerCountryDDL.UniqueID %>:{  
                       
                    }, 
                        <%=registerMailTB.UniqueID %>:{  
                        required:true ,
                        email: true
                    }, 
                        <%=registerCreditCardTB.UniqueID %>:{  
                        required: true  
                    }, 
                    },  
                    messages: {  
                        //This section we need to place our custom   
                        //validation message for each control.  
                        <%=registerUserNameTB.UniqueID %>:{  
                        required: "required." ,
                        minlength:"username at least 3 characters",
                        maxlength:"username maximum 8 characters",
                        lettersonly:"username can only contain characters"
                    },  
                    <%=registerPasswordTB.UniqueID %>:{  
                        required: "required.",
                        minlength:"password at least 5 characters",
                        maxlength:"password maximum 10 characters",
                        lettersonly:"password can only contain characters"
                    }, 
                    <%=registerIDTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                    <%=registerFirstNameTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                    <%=registerLastNameTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                    <%=registerNicknameTB.UniqueID %>:{  
                         
                    }, 
                    <%=registerPhoneNumTB.UniqueID %>:{  
                        
                    }, 
                    <%=registerCellphoneTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                    <%=registerAdrressTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                    <%=registerCityTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                    <%=registerCountryDDL.UniqueID %>:{  
                        
                    }, 
                    <%=registerMailTB.UniqueID %>:{  
                        required: "required."  ,
                        email: "Please enter a valid email address."
                    },     
                    <%=registerCreditCardTB.UniqueID %>:{  
                        required: "required."  
                    }, 
                },  
                    onkeyup:false,
                    onblur: true,
                    onfocusout: function (element) { $(element).valid() }
                });  
        };         
    </script>

     <div>
        
         <div id="part1">
             <asp:Label ID="registerFirstNameLB" runat="server" Text="First Name: "></asp:Label>
             <asp:TextBox ID="registerFirstNameTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerLastNameLB" runat="server" Text="Last Name: "></asp:Label>
             <asp:TextBox ID="registerLastNameTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerNicknameLB" runat="server" Text="Nick Name: "></asp:Label>
             <asp:TextBox ID="registerNicknameTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerIDLB" runat="server" Text="Id number: "></asp:Label>
             <asp:TextBox ID="registerIDTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerPhoneNumLB" runat="server" Text="Phone number: "></asp:Label>
             <asp:TextBox ID="registerPhoneNumTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerCellPhoneLB" runat="server" Text="Cellphone number: "></asp:Label>
             <asp:TextBox ID="registerCellphoneTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerCountryLB" runat="server" Text="Country: "></asp:Label>
             <asp:DropDownList ID="registerCountryDDL" runat="server"></asp:DropDownList>
             <br />
             <asp:Label ID="registerCityLB" runat="server" Text="City: "></asp:Label>
             <asp:TextBox ID="registerCityTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerAddressLB" runat="server" Text="Address: "></asp:Label>
             <asp:TextBox ID="registerAdrressTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerMailLB" runat="server" Text="E-Mail: "></asp:Label>
             <asp:TextBox ID="registerMailTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerUsernameLB" runat="server" Text="User Name: "></asp:Label>
             <asp:TextBox ID="registerUserNameTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerPassLB" runat="server" Text="Password: "></asp:Label>
             <asp:TextBox ID="registerPasswordTB" runat="server"></asp:TextBox>
             <br />
             <asp:Label ID="registerCreditCardLB" runat="server" Text="Credit Card number: "></asp:Label>
             <asp:TextBox ID="registerCreditCardTB" runat="server"></asp:TextBox>
             <br />
         </div>
         <div id="part2">
             <asp:SqlDataSource ID="catCheckSQL" runat="server" ConnectionString='<%$ ConnectionStrings:WebShopDBAss3ConnectionString %>' SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]"></asp:SqlDataSource>
             <asp:Label ID="Label1" runat="server" Text="Categories:"></asp:Label>
             <asp:CheckBoxList ID="catsCBL" runat="server" DataSourceID="catCheckSQL" DataTextField="CategoryName" DataValueField="CategoryID">
             </asp:CheckBoxList>
         </div>
         <div id="part3">
             <asp:Button ID="registerRegisterButton" runat="server" Text="Register" CssClass="loginSectionB" OnClientClick="valid()" OnClick="registerRegisterButton_Click" />
             <asp:Label ID="validLBL" runat="server"></asp:Label>
         </div>
    </div>
</asp:Content>
