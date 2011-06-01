<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDatHang.ascx.cs" Inherits="SuperStar.Controls.ucDonDatHang" %>

<asp:Panel runat="server" ID="pnlThongBao">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
        <tr>
            <td align="center">
                <div class="blue">Bạn phải là thành viên của website mới được quyền mua hàng.</div>
            </td>
        </tr>
        <tr>
            <td align="center" class="link-3" >
                <a href="../DangNhap.aspx">Click vào đây để đăng nhập</a> hoặc <a href="../DangKy.aspx"> đăng ký mới</a>
            </td>
        </tr>
    </table>
</asp:Panel>

<asp:Panel runat="server" ID="pnlKetQuaDatHang">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
        <tr>
            <th align="left">
                <div class="order-title">KẾT QUẢ ĐẶT HÀNG</div>
            </th>
        </tr>
        <tr>
            <td align="center">
                <asp:Label runat="server" ID="lblKetQuaDatHang" ></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>

<asp:Panel ID="panelDatHang" runat="server" 
    meta:resourcekey="panelDatHangResource1">
    <div class="order-wrapper">
    	<div class="order">
        	<span class="order-title"> ĐƠN ĐẶT HÀNG </span>
        	<br />
        	<span class="mess"><asp:Label runat="server" ID="lblLoiSanPham"></asp:Label></span>
        	<br />
        	<br />
        	<table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th >Tên sản phẩm</th>
                    <th class="style2">Số lượng</th>
                    <th class="style1">Thành tiền</th>
                    <th >Tổng điểm thưởng</th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTenSanPham" runat="server" 
                            meta:resourcekey="lblTenSanPhamResource1"></asp:Label>                       
                    </td>
                    <td >                       
                        <asp:TextBox runat="server" ID="txtSoLuongMuaSP" TextMode="SingleLine" AutoPostBack="true" 
                            MaxLength="10" size="10" ontextchanged="txtSoLuongMuaSP_TextChanged" ></asp:TextBox>                        
                    </td>
                    <td>
                        <asp:Label ID="lblThanhTien" runat="server" ></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTongDiemThuong" runat="server"></asp:Label>
                    </td>
                </tr>
   		  </table>
      </div>
        <!--end .order-->
        <div class="select-gift">
        	<span class="order-title"> CHỌN TẶNG PHẨM</span><br />
        	<span>Điểm thưởng còn lại : <asp:Label CssClass="mess" ID="lblDiemThuongConLai" runat="server"></asp:Label></span><br />
        	<asp:Label CssClass="mess" ID="lblLoiChonTP" runat="server" ></asp:Label>
        	<br />
   	        <table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th width="95" >Tên tặng phẩm</th>
                    <th width="109">Số lượng còn lại</th>
                    <th width="103">Điểm thưởng YC</th>
                    <th width="111">Số lượng tối đa</th>
                    <th width="63" >Số lượng</th>
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
                                meta:resourcekey="txtSoLuongMuaTPResource1" TextMode="SingleLine" AutoPostBack="false">
                            </asp:TextBox>
                            <asp:HiddenField ID="hidMaTangPham" Value='<%# Eval("MaTangPham") %>' runat="server"/>
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
                             <asp:TextBox ID="txtSoLuongTP" runat="server" size="10" MaxLength="5" 
                                meta:resourcekey="txtSoLuongMuaTPResource1" TextMode="SingleLine" AutoPostBack="false" >
                            </asp:TextBox>
                            <asp:HiddenField ID="hidMaTangPham" Value='<%# Eval("MaTangPham") %>' runat="server" />
                        </td>
                    </tr>
                 </AlternatingItemTemplate>
                 </asp:DataList>
      		</table>
    </div>
        <!--end .select-gift-->
        <div class="select-agent">
        	<span class="order-title"> Chọn Đại Lý</span>
        	    <asp:DropDownList ID="dropListDaiLy" runat="server" Width="100"
                    meta:resourcekey="dropListDaiLyResource1">
                </asp:DropDownList>        	
            
        </div>
        <!--end .select-agent-->
      <div class="select-buy">
          <asp:ImageButton ID="imgButtonThanhToan" runat="server" ImageUrl="~/image/btn_thanhtoan.gif"
              onclick="imgButtonThanhToan_Click" />
       </div>
	</div>
    <!--end .order-wrapper--> 
</asp:Panel>