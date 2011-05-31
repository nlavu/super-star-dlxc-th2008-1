<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDatHang.ascx.cs" Inherits="SuperStar.Controls.ucDonDatHang" %>

<script language="javascript" type="text/javascript">
 function funcCapNhatDDH(id)
 {
    var ddh = document.getElementById(id);    
    var dongia = document.getElementById("lblDonGia").value;
    
    var diemthuong = document.getElementById("lblDiemThuongSP").value;
    document.getElementById("lblThanhTien").value = dongia*ddh.value;
    document.getElementById("lblTongDiemThuong").value = diemthuong*ddh.value;
 }
</script>

<asp:Panel ID="panelDatHang" runat="server" 
    meta:resourcekey="panelDatHangResource1">
    <div class="order-wrapper">
    	<div class="order">
        	<span class="order-title"> ĐƠN ĐẶT HÀNG </span>
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
                        <asp:HiddenField ID="hidDonGia" runat="server" />
                        <asp:HiddenField ID="hidDiemThuongSP" runat="server" />
                    </td>
                    <td>                       
                        <input id="txtSoLuongMuaSP" type="text" maxlength="10" size="10" runat="server" onchange="funcCapNhatDDH(this.id)" value="1" />
                    </td>
                    <td>
                        <label id="lblThanhTien" ></label>
                    </td>
                    <td>
                        <label id="lblTongDiemThuong"></label>
                    </td>
                </tr>
   		  </table>
      </div>
        <!--end .order-->
        <div class="select-gift">
        	<span class="order-title"> CHỌN TẶNG PHẨM</span>
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
                            <asp:TextBox ID="txtSoLuongTP" runat="server" size="10" MaxLength="5" 
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
        	<span class="order-title"> Chọn Đại Lý</span>
        	    <asp:DropDownList ID="dropListDaiLy" runat="server" 
                    meta:resourcekey="dropListDaiLyResource1">
                </asp:DropDownList>
        	</h3 __designer:mapid="4c">
            
        </div>
        <!--end .select-agent-->
      <div class="select-buy">
          <asp:ImageButton ID="imgButtonBuy" runat="server" ImageUrl="~/image/btn_thanhtoan.gif"
              onclick="imgButtonBuy_Click" />
       </div>
	</div>
    <!--end .order-wrapper--> 
</asp:Panel>