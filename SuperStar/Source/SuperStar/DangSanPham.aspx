﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangSanPham.aspx.cs" Inherits="SuperStar.DangSanPham"
MasterPageFile="~/MasterPages/Customer.Master" Title="Đăng sản phẩm :: SuperStar" %>



<%@ Register Src="~/Controls/ucDanhMucSanPham.ascx" TagName="DanhMucSanPham" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucThongTinTaiKhoan.ascx" TagName="ThongTinTaiKhoan" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucDangSanPham.ascx" TagName="DangSanPham" TagPrefix="UC" %>


<asp:Content ID="idHeader" ContentPlaceHolderID="ContentPlaceHolder_header" runat="server">
<!--header-->
</asp:Content>

<asp:Content ID="idDanhMucSanPham" ContentPlaceHolderID="ContentPlaceHolder_danhmuc_sanpam" runat="server">
    <div class="danhmuc-sanpham">
  		<div id="Menu">
            <div id="Menu_header">
            	<div class="menu_header_left"> <span class="menu_text">DANH MỤC SẢN PHẨM</span></div>
            	<div class="menu_header_right"> </div>
            </div>
            <!--end #Menu_header-->
            <div>
                <UC:DanhMucSanPham runat="server" id="idUCDanhMucSanPham" />
            </div>
            <!--end #Menu_Content-->
       </div>			
       <!--end #Menu-->                   
  </div>
  <!--end .danhmuc-sanpham -->
</asp:Content>

<asp:Content ID="idPrimaryContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder_primary_content">
    <div class="primary-content"> 
  		<div>
  		    <UC:DangSanPham ID="ucDangSanPham" runat="server" />
  		</div>
</div>
  <!--emd primary-content-->
</asp:Content>

<asp:Content ID="idSideBar" ContentPlaceHolderID="ContentPlaceHolder_sidebar" runat="server">
    <div class="sidebar">           
        <div>
            <UC:ThongTinTaiKhoan runat="server" id="UcThongTinTaiKhoan" />
        </div>
        <!--end .Thông tin tài khoản-->
    </div>
    <!--end .Sidebar-->
</asp:Content>


        

