<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDangKy.ascx.cs" Inherits="ShoppingHere.Controls.ucDangKy" %>



<asp:Panel runat="server" ID="pnlKetQuaDangKy">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
        <tr>
            <td align="center">
                Chúc mừng <a href="../Index.aspx"><asp:Label ID="lblTenNguoiDung" runat="server"></asp:Label></a> đã đăng ký thành công.
            </td>
        </tr>
        <tr>
            <td align="center">
                <a href="../Index.aspx">Click vào đây để về trang chủ</a> hoặc về <a href="#">trang thông tin cá nhân</a>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel runat="server" ID="pnlThongBaoLoi">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
        <tr>
            <td align="center">
                <asp:Label runat="server" ID="lblThongBaoLoi" ></asp:Label>
            </td>
        </tr>       
    </table>
</asp:Panel>


<asp:Panel runat="server" ID="pnlDangKy">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr>
        	<th>
        	    <h2>
        	    <div class="blue">ĐĂNG KÝ</div>                    
                    <h2>
                    </h2>
                    <h2>
                    </h2>
                </h2>
           </th>
      	</tr>
      <tr>
        <td>
			<table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
              <tr>
                <td width="37%" align="right">Tên tài khoản <span class="mess">(*)</span></td>
                <td width="63%"><label for="txtTenTaiKhoan"></label>
                    <asp:TextBox TextMode="SingleLine" ID="txtTenTaiKhoan" runat="server" /> 
                    <asp:RequiredFieldValidator ID="requiredValidatorTenTaiKhoan" runat="server" 
                        ControlToValidate="txtTenTaiKhoan" Display="Dynamic" 
                        ErrorMessage="Chưa nhập tên tài khoản" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTenTaiKhoan" 
                        ErrorMessage="Tên tài khoản có chiều dài từ 6 đến 20, chứa kí tự A-Z, a-z, 0 -9, _" 
                        SetFocusOnError="True" ValidationExpression="[A-Z,a-z,0-9,_]{6,20}\S"></asp:RegularExpressionValidator>
                                  
                 </td>
              </tr>            
              <tr>
                <td align="right">Mật khẩu <span class="mess">(*)</span></td>
                <td><label for="txtMatKhau1"></label>
                    <asp:TextBox TextMode="Password" ID="txtMatKhau1" runat="server" />
                    <asp:RequiredFieldValidator ID="requiredValidatorMatKhau" runat="server" 
                        ControlToValidate="txtMatKhau1" Display="Dynamic" 
                        ErrorMessage="Chưa nhập mật khẩu" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="validatorMatKhau" runat="server" 
                        ControlToValidate="txtMatKhau1" Display="Dynamic" 
                        ErrorMessage="Mật khẩu có chiều dài lớn hơn bằng 6 và nhỏ hơn bằng 20" 
                        SetFocusOnError="True" ValidationExpression=".{6,20}"></asp:RegularExpressionValidator>
                
                </td>
              </tr>              
              <tr>
                <td align="right">Xác nhận mật khẩu <span class="mess">(*)</span></td>
                <td>
                    <label for="txtMatKhau2"></label>
                    <asp:TextBox TextMode="Password" ID="txtMatKhau2" runat="server"/>
                    <asp:RequiredFieldValidator ID="requiredValidatorMatKhau2" runat="server" 
                        ControlToValidate="txtMatKhau2" Display="Dynamic" 
                        ErrorMessage="Chưa xác nhận mật khẩu" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="compareMatKhau" runat="server" 
                        ControlToCompare="txtMatKhau1" ControlToValidate="txtMatKhau2" 
                        ErrorMessage="Mật khẩu không khớp" SetFocusOnError="True"></asp:CompareValidator>
                </td>
            </tr>
          </table>                          
        </td>
      </tr>                      
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="37%" align="right">Họ tên <span class="mess">(*)</span></td>
                  <td width="63%">
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtHoTen" Columns="30" />
                      <asp:RequiredFieldValidator ID="validateHoTen" runat="server" 
                          ControlToValidate="txtHoTen" ErrorMessage="Chưa nhập họ tên" 
                          SetFocusOnError="True"></asp:RequiredFieldValidator>
                  </td>
                </tr>
                <tr>
                  <td align="right" class="style1">Email <span class="mess">(*)</span></td>
                  <td class="style1">
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtEmail" size="30" 
                          Height="22px" />
                      <asp:RequiredFieldValidator ID="requiredValidatorEmail" runat="server" 
                          ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Chưa nhập email" 
                          SetFocusOnError="True"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="validatorEmail" runat="server" 
                          ControlToValidate="txtEmail" ErrorMessage="Email không hợp lệ" 
                          SetFocusOnError="True" 
                          ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                  </td>
                </tr>
                <tr>
                  <td align="right">Địa chỉ <span class="mess">(*)</span></td>
                  <td >
                        <asp:TextBox TextMode="SingleLine" runat="server" ID="txtDiaChi" size="50" />
                        <asp:RequiredFieldValidator ID="validatorDiaChi" runat="server" ControlToValidate="txtDiaChi"
                          ErrorMessage="Chưa nhập địa chỉ" SetFocusOnError="True"></asp:RequiredFieldValidator>
                   </td>
                </tr>                
                <tr>
                  <td align="right">Số điện thoại <span class="mess">(*)</span></td>
                  <td>
                    <asp:TextBox TextMode="SingleLine" runat="server" ID="txtSoDienThoai" />
                      <asp:RequiredFieldValidator ID="requiredValidatorSodienThoai" runat="server" 
                          ControlToValidate="txtSoDienThoai" ErrorMessage="Chưa nhập số điện thoại"></asp:RequiredFieldValidator>
                      <asp:RegularExpressionValidator ID="validatorSoDienThoai" runat="server" 
                          ControlToValidate="txtSoDienThoai" ErrorMessage="Số điện thoại không hợp lệ." 
                          SetFocusOnError="True" ValidationExpression="\d{8}|\d{12}"></asp:RegularExpressionValidator>
                  </td>
                </tr>                
                <tr>
                  <td align="right">Ảnh đại diện:</td>
                  <td>
                      <asp:FileUpload ID="fileUpload" runat="server" />
                  </td>
                </tr>
              </table>
        </td>
      </tr>
      <tr align="center" valign="middle">
        <td>
        	<asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" 
                onclick="btnDangKy_Click" /> &nbsp;&nbsp;&nbsp;&nbsp;
       	    <asp:Button ID="btnHuy" Text="Hủy đăng ký" runat="server" 
                onclick="btnHuy_Click" /></td>
      </tr>
    </table>
</asp:Panel>