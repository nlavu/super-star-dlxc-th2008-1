<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDanhSachSanPham.ascx.cs" Inherits="ShoppingHere.Controls.ucDanhSachSanPham" %>


<asp:Panel runat="server" ID="panelDanhSachSanPhamHot" >
<div class="group-product">
<asp:DataList ID="dlDanhSachSanPham" runat="server" RepeatColumns="4" RepeatDirection="horizontal" RepeatLayout="table" 
CellPadding="0" CellSpacing="0" BorderWidth="0">
<ItemTemplate>
    <table width="100%">
        <tr>
            <td>
                <div class="list-product-wrapper">
           	      <div class="list-product">
           		    <div class="list-product-content">
               	      <div class="list-product-image">
           		  		    <img src="../image-product/ipod.JPG" />
                      </div>
                      <div class="list-product-info">
                  		    <div class="name" ><a href="chi_tiet_san_pham.html"><%#Eval("TenSanPham") %> </a></div>
                            <div class="info-line">Giá: <span class="price"><%#Eval("DonGia") %></span> </div>
                            <div class="info-line">Điểm thưởng: <span class="score"><%#Eval("DiemThuong") %> </span></div>
                            <div class="info-line"> Còn lại <span class="number-product"><%#Eval("SoLuongTon") %></span></div>
                      </div>
           		    </div>
           	      </div>
                </div>
            </td>
        </tr>
    </table>
</ItemTemplate>
<AlternatingItemTemplate>
    <table width="100%">
        <tr>
            <td>
               <div class="list-product-wrapper">
       	          <div class="list-product">
       		        <div class="list-product-content">
           	          <div class="list-product-image">
       		  		        <img src="../image-product/ipod.JPG" />
                      </div>
                      <div class="list-product-info">
              		        <div class="name" ><a href="chi_tiet_san_pham.html"><%#Eval("TenSanPham") %> </a></div>
                            <div class="info-line">Giá: <span class="price"><%#Eval("DonGia") %></span> </div>
                            <div class="info-line">Điểm thưởng: <span class="score"><%#Eval("DiemThuong") %> </span></div>
                            <div class="info-line"> Còn lại <span class="number-product"><%#Eval("SoLuongTon") %></span></div>
                      </div>
       		        </div>
       	          </div>
                </div>
            </td>
        </tr>
    </table>
</AlternatingItemTemplate>                       
</asp:DataList>
</div>
    <!--end group-product-->
</asp:Panel>
