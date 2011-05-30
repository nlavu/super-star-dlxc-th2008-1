<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="SuperStar.DangNhap" 
   Title="Đăng nhập:: SuperStar" MasterPageFile="~/MasterPages/Customer.Master" %>

<%@ Register Src="~/Controls/ucDangNhap.ascx" TagName="DangNhap" TagPrefix="UC" %>

<asp:Content ID="idHeader" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
<!--header-->
</asp:Content>

<asp:Content ID="idPrimaryContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder_primary_content">
    <div class="primary-content"> 
      	<UC:DangNhap runat="server" ID="ucDangNhap" />
    </div>
      <!--emd primary-content-->
</asp:Content>



        
