<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDangKy.ascx.cs" Inherits="ShoppingHere.Controls.ucDangKy" %>


<asp:Panel runat="server" ID="panelDangKy">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr>
        	<th><h2><div class="blue">ĐĂNG KÝ</div>
                <h2>
                </h2>
                </h2></th>
      	</tr>
      <tr>
        <td>
			<table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
              <tr>
                <td width="37%" align="right">Tên tài khoản:</td>
                <td width="63%"><label for="txtTenTaiKhoan"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtTenTaiKhoan" runat="server" /></td>
            </tr>
              <tr>
                <td align="right">Mật khẩu:</td>
                <td><label for="txtMatKhau1"></label>
                <asp:TextBox TextMode="Password" ID="txtMatKhau1" runat="server" /></td>
            </tr>
              <tr>
                <td align="right">Xác nhận mật khẩu:</td>
                <td><label for="txtMatKhau2"></label>
                <asp:TextBox TextMode="Password" ID="txtMatKhau2" runat="server"/></td>
            </tr>
          </table>                          
        </td>
      </tr>                      
      <tr>
        <td>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="37%" align="right">Họ tên:</td>
                  <td width="63%">
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtHoTen" Columns="30" />
                  </td>
                </tr>
                <tr>
                  <td align="right">Email:</td>
                  <td>
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtEmail" size="30" />
                  </td>
                </tr>
                <tr>
                  <td align="right">Địa chỉ:</td>
                  <td>
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtDiaChi" size="50" />
                  </td>
                </tr>
                <tr>
                  <td align="right">Số điện thoại:</td>
                  <td>
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtSoDienThoai" />
                  </td>
                </tr>
                <tr>
                  <td align="right">Ảnh đại diện:</td>
                  <td>
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtAnhDaiDien" />
                  </td>
                </tr>
              </table>
        </td>
      </tr>
      <tr align="center" valign="middle">
        <td>
        	<asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" 
                onclick="btnDangKy_Click" />
       	    <asp:Button ID="btnHuy" Text="Hủy đăng ký" runat="server" 
                onclick="btnHuy_Click" /></td>
      </tr>
    </table>
</asp:Panel>