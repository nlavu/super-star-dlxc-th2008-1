<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="SuperStar.DangKy" 
    Title="Đăng ký :: SuperStar" MasterPageFile="~/MasterPages/Customer.Master" %>

<%@ Register Src="~/Controls/ucDangKy.ascx" TagName="DangKy" TagPrefix="UC" %>

<asp:Content ID="idHeader" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
<!--header-->
</asp:Content>

<asp:Content ID="idPrimaryContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder_primary_content">
    <div class="primary-content"> 
  		<div>
  		    <UC:DangKy ID="ucDangKy" runat="server" />
  		</div>
    </div>
      <!--emd primary-content-->
</asp:Content>



        

