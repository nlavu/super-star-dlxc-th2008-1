<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucThongTinTaiKhoan.ascx.cs" Inherits="ShoppingHere.Controls.ucThongTinTaiKhoan" %>

<asp:Panel runat="server" ID="panelThongTinTaiKhoan">
    <div class="boxWrapper">
        <div class="box">
            <div class="boxTitle">Thông tin tài khoản</div>
            <div class="boxContent">	
                <div class="boxContentMain">
                    
                      <table width="100%" border="0" cellpadding="2">
                          <tr>
                            <td width="27%" align="center" valign="middle">
                            	<img src="image/profile_48c.png" width="48" height="48" />
                            </td>
                            <td width="73%">
                                    Chào bạn <asp:Label ID="lblTenTaiKhoan" runat="server"> <span class="link-3"><a href="#"></a></span></asp:Label>
                                    <br />
                                    <br />
                                    Mã tài khoản : <asp:Label ID="lblMaTaiKhoan" runat="server"></asp:Label>
                             	    <br />
                                    <br />
                             	    Loại TK : <asp:Label ID="lblLoaiTaiKhoan" runat="server"></asp:Label>
                             	    <br />
                                    <br />
                             	 <asp:Button runat="server" ID="btnDangXuat" Text="Đăng xuất" 
                                        onclick="btnDangXuat_Click" />
                            </td>
                          </tr>
                        </table>
                       
                </div>
            </div>           			
        </div>              
    </div>
    <!--end .Thông tin tài khoản-->
</asp:Panel>