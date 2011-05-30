<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSanPhamNoiBat.ascx.cs" Inherits="SuperStar.Controls.ucSanPhamNoiBat" %>

<asp:Panel runat="server" ID="panelSanPhamNoiBat">
    <div class="productWrapper">
   	  <div class="product">
            <div class="productContent">
                <div class="productImage">
            		<asp:Image  runat="server" ImageUrl="" width="180" height="180" ID="imgSanPham"/>
                    <div class="Time">
                    	Thời gian còn lại:<br />
                        <span class="TimeNumber">12 : 00 : 00</span>
                    </div>
                    <!--end .Time-->
       		   	</div>
                <!--end ProductImage-->
                <div class="productInfo">
                	<div class="name" >
                    	<asp:HyperLink ID="hpTenSanPham" runat="server" ></asp:HyperLink>
                    </div>
                    <div class="info-line">Giá: <span class="price"><asp:Label runat="server" ID = "lbGiaSanPham" ></asp:Label> VnD</span> </div>
                    <div class="info-line">Điểm thưởng: <span class="score"><asp:Label runat="server" ID = "lbDiemThuong" ></asp:Label>/sản phẩm </span></div>
                    <div class="info-line"> 
                    	Đã bán <span class="number-product"><asp:Label runat="server" ID = "lbSoLuongSPDaBan" ></asp:Label></span> sản phẩm | 
                        Còn lại <span class="number-product"><asp:Label runat="server" ID = "lbSoLuongTon" ></asp:Label></span> sản phẩm</div>
                    <!--div class="info-line"> cái nút mua ở đây</div-->                                          	
                   
                        <asp:Button runat="server" ID ="btnMua" class="button-order" 
                        onclick="btnMua_Click" />
                       
                  
   			  </div>  
                <!--end ProductInfo-->
            </div>
            <!--end ProductContent-->
      </div>                               
   </div>                           
   <!--end ProductWrapper-->
</asp:Panel>