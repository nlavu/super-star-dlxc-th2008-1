<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDatHang.ascx.cs" Inherits="ShoppingHere.Controls.ucDonDatHang" %>


<asp:Panel ID="panelDatHang" runat="server" 
    meta:resourcekey="panelDatHangResource1">
    <div class="order-wrapper">
    	<div class="order">
        	<h3>ĐƠN ĐẶT HÀNG </h3>
        	<table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th >Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th >Tổng điểm thưởng</th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTenSanPham" runat="server" 
                            meta:resourcekey="lblTenSanPhamResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSoLuongMuaSP" runat="server" MaxLength="10" size="10" 
                            meta:resourcekey="txtSoLuongMuaSPResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblThanhTien" runat="server" 
                            meta:resourcekey="lblThanhTienResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDiemThuong" runat="server" 
                            meta:resourcekey="lblDiemThuongResource1"></asp:Label>
                    </td>
                </tr>
   		  </table>
      </div>
        <!--end .order-->
        <div class="select-gift">
        	<h3>CHỌN TẶNG PHẨM</h3>
   	        <table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th width="95" >Tên tặng phẩm</th>
                    <th width="109">Số lượng còn lại</th>
                    <th width="103">Điểm thưởng YC</th>
                    <th width="111">Số lượng tối đa</th>
                    <th width="63" >#</th>
                </tr>
                <asp:DataList ID="dlDanhSachTangPham" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                        RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlDanhSachTangPhamResource1">
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#Eval("TenTangPham")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongConLai")%>
                        </td>
                        <td>
                            <%#Eval("DiemThuongYC")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongToiDa")%>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSoLuongMuaTP" runat="server" size="10" MaxLength="5" 
                                meta:resourcekey="txtSoLuongMuaTPResource1"></asp:TextBox>
                        </td>
                    </tr>
                 </ItemTemplate>
                 <AlternatingItemTemplate>
                     <tr>
                        <td>
                            <%#Eval("TenTangPham")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongConLai")%>
                        </td>
                        <td>
                            <%#Eval("DiemThuongYC")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongToiDa")%>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSoLuongMuaTP" runat="server" size="10" MaxLength="5" 
                                meta:resourcekey="txtSoLuongMuaTPResource2"></asp:TextBox>
                        </td>
                    </tr>
                 </AlternatingItemTemplate>
                 </asp:DataList>
      		</table>
    </div>
        <!--end .select-gift-->
        <div class="select-agent">
        	<h3> Chọn Đại Lý
        	    <asp:DropDownList ID="dropListDaiLy" runat="server" 
                    meta:resourcekey="dropListDaiLyResource1">
                </asp:DropDownList>
        	</h3>
            
        </div>
        <!--end .select-agent-->
      <div class="select-buy">
          <asp:ImageButton ID="imgButtonBuy" runat="server" ImageUrl="~/image/buy.jpg"
              onclick="imgButtonBuy_Click" />
        </div>
	</div>
    <!--end .order-wrapper--> 
</asp:Panel>