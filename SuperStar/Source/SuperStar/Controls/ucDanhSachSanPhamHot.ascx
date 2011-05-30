<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDanhSachSanPhamHot.ascx.cs" Inherits="SuperStar.Controls.ucDanhSachSanPhamHot" %>

<asp:Panel runat="server" ID="panelDanhSachSanPhamHot" >
<div class="group-product">        
    <div class="group-content">
    <asp:DataList ID="dlDanhSachSanPhamHot" runat="server" RepeatColumns="4" RepeatDirection="horizontal" 
        CellPadding="0" CellSpacing="0" BorderWidth="0">
        <ItemTemplate>             
            <div class="list-product-wrapper">
              <div class="list-product">
	            <div class="list-product-content">
   	              <div class="list-product-image">
	  		            <img src="../image-product/ipod.JPG" />
                  </div>
                  <div class="list-product-info">
      		            <div class="name" ><a href="ChiTietSanPham.aspx?maSanPham=<%#Eval("MaSanPham") %>" ><%#Eval("TenSanPham") %> </a></div>
                        <div class="info-line">Giá: <span class="price"><%#Eval("DonGia") %></span> </div>
                        <div class="info-line">Điểm thưởng: <span class="score"><%#Eval("DiemThuong") %> </span></div>
                        <div class="info-line"> Còn lại <span class="number-product"><%#Eval("SoLuongTon") %></span></div>
                  </div>
	            </div>
              </div>
            </div>                      
        </ItemTemplate>
        <AlternatingItemTemplate>            
           <div class="list-product-wrapper">
              <div class="list-product">
                <div class="list-product-content">
                  <div class="list-product-image">
  		                <img src="../image-product/ipod.JPG" />
                  </div>
                  <div class="list-product-info">
  		                <div class="name" ><a href="ChiTietSanPham.aspx?maSanPham=<%#Eval("MaSanPham") %>"><%#Eval("TenSanPham") %> </a></div>
                        <div class="info-line">Giá: <span class="price"><%#Eval("DonGia") %></span> </div>
                        <div class="info-line">Điểm thưởng: <span class="score"><%#Eval("DiemThuong") %> </span></div>
                        <div class="info-line"> Còn lại <span class="number-product"><%#Eval("SoLuongTon") %></span></div>
                  </div>
                </div>
              </div>
            </div>                  
        </AlternatingItemTemplate>                       
    </asp:DataList>
    </div> 
    <!--end group-content-->                           
</div>
<!--end group-product-->
</asp:Panel>
