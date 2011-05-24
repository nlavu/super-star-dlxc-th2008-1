<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSanPhamNoiBat.ascx.cs" Inherits="ShoppingHere.Controls.ucSanPhamNoiBat" %>

<asp:Panel runat="server" ID="panelSanPhamNoiBat">
    <div class="productWrapper">
   	  <div class="product">
            <div class="productContent">
                <div class="productImage">
            		<a href="../ChiTietSanPham.aspx"><img src="image-product/043.jpg" width="180" height="180" /></a>
                  	<div class="Time">
                    	Thời gian còn lại:<br />
                        <span class="TimeNumber">12 : 00 : 00</span>
                    </div>
              </div>
                <!--end ProductImage-->
                <div class="productInfo">
                	<div class="name" >
                    	<a href="chi_tiet_san_pham.html" >TÊN SẢN PHẨM </a>
                    </div>
                    <div class="info-line">Giá: <span class="price">200.000 VnD</span> </div>
                    <div class="info-line">Điểm thưởng: <span class="score">10 </span></div>
                    <div class="info-line"> Còn lại <span class="number-product">100</span> sản phẩm</div>
                    <div class="info-line"> cái nút mua ở đây [ to + bự =)) ]</div>
                  	<div class=""><span class="more-detail"><a href="../ChiTietSanPham.aspx">Xem chi tiết >></a> </span></Div>
   			  </div>  
                <!--end ProductInfo-->
            </div>
            <!--end ProductContent-->
      </div>                               
   </div>                         
   <!--end ProductWrapper-->
</asp:Panel>