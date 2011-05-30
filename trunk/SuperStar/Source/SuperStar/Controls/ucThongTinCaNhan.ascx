<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucThongTinCaNhan.ascx.cs" Inherits="SuperStar.Controls.ucThongTinCaNhan" %>

<table id="tbThongTinCaNhan" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" valign="middle" width="30%">
            <asp:Image ID="imgAvatar" runat="server" Height="100px" Width="100px" />
        </td>
        
        <td width="70%">
            <span>Tên tài khoản :  <asp:Label ID="lblTenTaiKhoan" runat="server"></asp:Label></span><br />
            <span>Mật khẩu      : <asp:Label ID="lblMatKhau" runat="server"></asp:Label></span><br />
            <span>Loại tài khoản: <asp:Label ID="lblLoaiTaiKhoan" runat="server"></asp:Label></span><br />
            <asp:Label ID="lblHoTen" runat="server"></asp:Label><asp:Label ID="lblTen" runat="server"></asp:Label><br />
            <span>Địa chỉ       : <asp:Label ID="lblDiaChi" runat="server"></asp:Label></span><br />
            <span>Số điện thoại : <asp:Label ID="lblSoDienThoai" runat="server"></asp:Label></span><br />
            <span>Email         : <asp:Label ID="lblEmail" runat="server"></asp:Label></span><br />
            <asp:Label ID="lblDaiDien" runat="server"></asp:Label><asp:Label ID="lblNguoiDaiDien" runat="server"></asp:Label>
         
        </td>
    </tr>
</table>