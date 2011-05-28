<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDangNhap.ascx.cs" Inherits="ShoppingHere.Controls.ucDangNhap" %>

<asp:Panel runat="server" ID="pnlKetQuaDangNhap">
<table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
<tr><td align="center">Chúc mừng <a href="../Index.aspx"><asp:Label ID="lblTenNguoiDung" runat="server"></asp:Label></a> đã đăng nhập thành công.</td></tr>
<tr><td align="center"><a href="../Index.aspx">Click vào đây để về trang chủ</a></td></tr>
</table>
</asp:Panel>

<asp:Panel runat="server" ID="pnlDangNhap">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr>
        	<th><h2><div class="blue">ĐĂNG NHẬP</div></h2></th>
      	</tr>
      <tr>
        <td>
			<table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
              <tr>
                <td width="37%" align="right">Tên tài khoản:</td>
                <td width="40%"><label for="txtTenTaiKhoan"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtTenTaiKhoan" runat="server"></asp:TextBox>
                </td>
                <td align="left"><asp:Label runat="server" ID="lblLoi1"></asp:Label></td>
            </tr>
              <tr>
                <td align="right">Mật khẩu:</td>
                <td><label for="txtMatKhau"></label>
                <asp:TextBox TextMode="Password" ID="txtMatKhau" runat="server" MaxLength="20"></asp:TextBox></td>
                <td align="left"><asp:Label runat="server" ID="lblLoi2"></asp:Label></td>
            </tr>  
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnDangNhap" runat="server" Text="Đăng nhập" onclick="btnDangNhap_Click" />
                </td>
            </tr>                        
          </table>                          
        </td>
      </tr> 
      <tr align="center" valign="middle">
        <td>
        	<div class="blue"> <a href="#">Quên mật khẩu? </a> | <a href="DangKy.aspx">Đăng ký </a></div> 
          
   	    </td>
      </tr>
    </table>
</asp:Panel>