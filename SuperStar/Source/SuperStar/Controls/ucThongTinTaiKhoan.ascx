<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucThongTinTaiKhoan.ascx.cs" Inherits="SuperStar.Controls.ucThongTinTaiKhoan" %>

<asp:Panel runat="server" ID="panelThongTinTaiKhoan">
    <div class="boxWrapper">
        <div class="box">
            <div class="boxTitle">Thông tin tài khoản</div>
            <div class="boxContent">	
                <div class="boxContentMain">                    
                      <table width="100%" border="0" cellpadding="2">
                          <tr>
                            <td width="27%" align="center" valign="middle">
                                <asp:Image ID="imgAvatar" runat="server" Height="100px" Width="100px" />
                            </td>                            
                          </tr>
                          <tr>
                             <td width="73%">
                                    <span class="info-line">Chào bạn <span class="link-3"><a href="#"><asp:Label ID="lblTenTaiKhoan" runat="server"></asp:Label></a></span></span>
                                    <br />  
                                    <br />                                                                   
                             	    <span class="info-line">Loại Tài Khoản : <asp:Label ID="lblLoaiTaiKhoan" runat="server"></asp:Label></span>
                             	    <br />                                   
                            </td>
                          </tr>
                          <tr>
                            <td >
                                <span class="link-3">
                                    <asp:HyperLink ID="hpThongTinCaNhan" runat="server">Thông tin cá nhân</asp:HyperLink>
                                </span>                                
                            </td>                           
                          </tr>
                          <tr>
                            
                          </tr>
                            <td >
                                <span class="link-3">
                                    <asp:HyperLink ID="hpDSDonDatHang" runat="server"></asp:HyperLink>
                                </span>                            
                            </td>                            
                          <tr>
                          </tr>
                            <td >
                                <span class="link-3">
                                    <asp:HyperLink ID="hpQuanLyTaiKhoan" runat="server"></asp:HyperLink>  
                                </span>                          
                            </td>                             
                          <tr>
                            <td >
                                <span class="link-3">
                                    <asp:HyperLink ID="hpQuanLySanPham" runat="server"></asp:HyperLink>
                                </span>                            
                            </td> 
                          </tr>
                          <tr>
                            <td align="center">
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