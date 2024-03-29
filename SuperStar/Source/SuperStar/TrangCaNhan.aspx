﻿<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeBehind="TrangCaNhan.aspx.cs" 
Inherits="SuperStar.TrangCaNhan" MasterPageFile="~/MasterPages/Customer.Master" Title="Trang cá nhân :: SuperStar" %>

<%@ Register Src="~/Controls/ucDanhMucSanPham.ascx" TagName="DanhMucSanPham" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucThongTinTaiKhoan.ascx" TagName="ThongTinTaiKhoan" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucThongTinCaNhan.ascx" TagName="ThongTinCaNhan" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucDanhSachDonDatHang.ascx" TagName="DSDonDatHang" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucQuanLySanPham.ascx" TagName="QuanLySanPham" TagPrefix="UC" %>
<%@ Register Src="~/Controls/ucQuanLyTaiKhoan.ascx" TagName="QuanLyTaiKhoan" TagPrefix="UC" %>


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
  		    <UC:ThongTinCaNhan runat="server" ID="ucThongTinCaNhan"/>
  		</div>
  		<div>
  		    <UC:DSDonDatHang runat="server" ID="ucDSDonDatHang"/>
  		</div>
  		<div>
  		    <UC:QuanLySanPham runat="server" ID="ucQuanLySanPham"/>
  		</div>
  		<div>
  		    <UC:QuanLyTaiKhoan runat="server" ID="ucQuanLyTaiKhoan"/>
  		</div>
    </div>
    <!--emd primary-content-->
</asp:Content>

<asp:Content ID="idSideBar" ContentPlaceHolderID="ContentPlaceHolder_sidebar" runat="server">
    <div class="sidebar">           
        <div>
            <UC:ThongTinTaiKhoan runat="server" ID="UCThongTinTaiKhoan" />
        </div>
        <!--end .Thông tin tài khoản-->
    </div>
    <!--end .Sidebar-->
</asp:Content>


        

