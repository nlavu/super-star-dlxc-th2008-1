<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucQuanLyTaiKhoan.ascx.cs" Inherits="SuperStar.Controls.ucQuanLyTaiKhoan" %>
  
<style type="text/css">
    .style1
    {
        color: #00CCFF;
    }
</style>
  
<script>
function CapNhatQuyen()
{
    var dlDSTK = $('#dlDSTaiKhoan');
    
}

</script> 

<asp:Panel ID="panelDSTaiKhoan" runat="server">
    <table width="100%" border="0" cellpadding="5" cellspacing="0" 
    class="rounded-corner">
        <tr>
            <th width="95" >
                Tên Tài Khoản</th>
            <th width="109">
                Loại Tài Khoản</th>
            <th width="103">
                Ảnh Đại Điện</th>
            
            
        </tr>
       
        <asp:DataList ID="dlDanhSachTaiKhoan" runat="server" BorderWidth="0px" 
            CellPadding="0" meta:resourcekey="dlDanhSachTaiKhoanResource1" 
            RepeatColumns="1" RepeatDirection="Horizontal" RepeatLayout="Flow" >
            <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("TenTaiKhoan")%>
                    </td>
                    <td>
                        <%#Eval("LoaiTK")%>
                    </td>
                    <td>
                       <img src="<%#Eval("AnhDaiDien")%>" />
                    </td>
                     
                </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <tr>
                    <td>
                        <%#Eval("TenTaiKhoan")%>
                    </td>
                    <td>
                        <%#Eval("LoaiTK")%>
                    </td>
                    <td>
                        <img src="<%#Eval("AnhDaiDien")%>" />
                    </td>
                    
                </tr>
            </AlternatingItemTemplate>
        </asp:DataList>
    </table>
    <br />
    <span class="style1">CẤP MỚÍ QUYỀN</span><br />
    Chọn khách hàng cần chuyển thành đại lý:
    <asp:DropDownList ID="dropListTaiKhoan" runat="server">
    </asp:DropDownList>
   
    <asp:Button ID="btnThayDoi" runat="server" onclick="btnThayDoi_Click" 
        Text="Cấp quyền" />

    <br />
    <hr />
    <br />
    <span class="info-line"><span class="link-3"><a href="#"><asp:Label ID="lblTenTK" runat="server"></asp:Label></a></span></span>
    <asp:Label ID="lblThongBaoCapLaiQuyen" runat="server"></asp:Label>
</asp:Panel>







