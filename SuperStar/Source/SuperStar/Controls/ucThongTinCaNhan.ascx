<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucThongTinCaNhan.ascx.cs" Inherits="SuperStar.Controls.ucThongTinCaNhan" %>

<table id="tbThongTinCaNhan" border="0" cellpadding="5" cellspacing="0">
    <tr>
        <td align="center" valign="middle" width="40%">
            <asp:Image ID="imgAvatar" runat="server" Height="100px" Width="100px" />
        </td>
        
        <td width="60%">
            <table width="100%" style="border-left: 1px dashed #CCC" cellspacing="0" cellpadding="5">
                <tr>
                    <td align="right">
                        Tên tài khoản :  
                    </td>
                    <td>
                        <asp:Label ID="lblTenTaiKhoan" runat="server"></asp:Label>
                    </td>                        
                </tr>
                <tr>
                    <td align="right">
                        Loại tài khoản: 
                    </td>
                    <td>
                        <asp:Label ID="lblLoaiTaiKhoan" runat="server"></asp:Label>
                    </td>                        
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblNhanHoTen" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTen" runat="server"></asp:Label>
                    </td>                        
                </tr>
                <tr>
                    <td align="right">
                        Địa chỉ:
                    </td>
                    <td>
                        <asp:Label ID="lblDiaChi" runat="server"></asp:Label>
                    </td>                       
                </tr>
                <tr>
                    <td align="right">
                        Số điện thoại:
                    </td>
                    <td>
                        <asp:Label ID="lblSoDienThoai" runat="server"></asp:Label>
                    </td>                       
                </tr>
                <tr>
                    <td align="right">
                        Email:
                    </td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                    </td>                       
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblDaiDien" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblNguoiDaiDien" runat="server"></asp:Label>
                    </td>                       
                </tr>
                
            </table>           
         
        </td>
    </tr>
</table>