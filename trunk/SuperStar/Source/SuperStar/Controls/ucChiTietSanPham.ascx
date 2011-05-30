<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucChiTietSanPham.ascx.cs" Inherits="ShoppingHere.Controls.ChiTietSanPham" %>


<asp:Panel runat="server" ID="panelChiTietSanPham">
   <table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr>
      	<td>
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
		</td>
      </tr>
	  <tr>
	    <td>
   	    <div class="group-product">
            <div class="header-group-product">
              	<div class="group-product_header_left"> 
                	<span class="group-product_text">Tặng phẩm </span>
                </div>
        		<div class="group-product_header_right"></div>
             </div>
             <!--end .header-group-product-->
             <div class="group-content">
                    <asp:DataList ID="dlDanhSachTangPham" runat="server" RepeatColumns="4" RepeatDirection="horizontal" RepeatLayout="table" 
CellPadding="0" CellSpacing="0" BorderWidth="0">
            <ItemTemplate>
                <table width="100%">
                    <tr>
                        <td>
                            <div class="list-product-wrapper">
           	                  <div class="list-product">
           		                <div class="list-product-content">
               	                  <div class="list-product-image">
           		  		                <img src="<%#Eval("HinhAnh") %>" />
                                  </div>
                                  <div class="list-product-info">
                  		                <div class="name" ><a href="ChiTietSanPham.aspx?maSanPham=<%#Eval("MaSanPham") %>"><%#Eval("TenTangPham") %></a></a></div>
                                        <div class="info-line">Điểm yêu cầu: <span class="price"><%#Eval("DiemThuongYC") %></span> </div>
                                        <div class="info-line">Số lượng tối đa: <span class="score"><%#Eval("SoLuongToiDa") %> </span></div>
                                        <div class="info-line"> Còn lại <span class="number-product"><%#Eval("SoLuongConLai") %></span></div>
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
       		  		                    <img src="<%#Eval("HinhAnh") %>" />
                                  </div>
                                  <div class="list-product-info">
              		                    <div class="name" ><a href="ChiTietSanPham.aspx?maSanPham=<%#Eval("MaSanPham") %>"><%#Eval("TenTangPham") %></a></a></div>
                                        <div class="info-line">Điểm yêu cầu: <span class="price"><%#Eval("DiemThuongYC") %></span> </div>
                                        <div class="info-line">Số lượng tối đa: <span class="score"><%#Eval("SoLuongToiDa") %> </span></div>
                                        <div class="info-line"> Còn lại <span class="number-product"><%#Eval("SoLuongConLai") %></span></div>
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
             <!--end group-content-->                           
   	    </div>
        <!--end group-product-->
        </td>              		    
      </tr>
	  <tr>
	    <td>
        	<div class="group-product">
            <div class="header-group-product">
              	<div class="group-product_header_left"> 
                	<span class="group-product_text">Thông tin chi tiết </span>
                </div>
        		<div class="group-product_header_right"></div>
              <div class="group-content">Content for  class "group-content" Goes Here</div>
            </div>
   	    </div>
        </td>              		    
      </tr>
</table>

</asp:Panel>