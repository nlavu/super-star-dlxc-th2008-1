<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDangNhap.ascx.cs" Inherits="ShoppingHere.Controls.ucDangNhap" %>

<asp:Panel runat="server" ID="panelDangNhap">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr>
        	<th><h2><div class="blue">ĐĂNG NHẬP</div></h2></th>
      	</tr>
      <tr>
        <td>
			<table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
              <tr>
                <td width="37%" align="right">Tên tài khoản:</td>
                <td width="63%"><label for="txtTenTaiKhoan"></label>
                <input type="text" name="txtTenTaiKhoan" id="txtTenTaiKhoan" /></td>
            </tr>
              <tr>
                <td align="right">Mật khẩu:</td>
                <td><label for="txtMatKhau1"></label>
                <input type="text" name="txtMatKhau1" id="txtMatKhau1" /></td>
            </tr>                            
          </table>                          
        </td>
      </tr> 
      <tr align="center" valign="middle">
        <td>
        	<div class="blue"> <a href="#">Đăng nhập </a> | <a href="#">Quên mật khẩu </a></div> 
          
   	    </td>
      </tr>
    </table>
</asp:Panel>