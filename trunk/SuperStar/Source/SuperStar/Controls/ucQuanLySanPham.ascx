<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucQuanLySanPham.ascx.cs" Inherits="SuperStar.Controls.ucQuanLySanPham" %>

<style type="text/css">
    .style6
    {
        width: 50px;
    }
    .style7
    {
        width: 25px;
    }
    .style8
    {
        width: 21px;
    }
</style>

<asp:Panel ID="panelQuanLySanPham" runat="server" 
    meta:resourcekey="panelQuanLySanPhamResource1">
    <div class="order-wrapper">
        <span class="order-title"> QUẢN LÝ SẢN PHẨM</span>
        <br />
        <br />
        <div class="quanlysanpham">
        	<span class="order-title"> Danh Sách Sản Phẩm Còn Thời Hạn Mua Và Còn Hàng</span>
   	        <table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th class="style7">Mã sản phẩm</th>
                    <th class="style7">Tên sản phẩm</th>
                    <th class="style8">Số lượng tồn</th>
                    <th class="style6">Thời gian BD Bán</th>
                    <th class="style6">Thời gian KT Bán</th>
                    <th class="style6">Thời gian BD Nhận Hàng</th>
                    <th class="style6"> Thời gian KT Nhận Hàng</th>
                </tr>
                <asp:DataList ID="dlQuanLySanPhamConHan" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                        RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlQuanLySanPhamConHanResource1">
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#Eval("MaSanPham")%>
                        </td>
                        <td>
                            <%#Eval("TenSanPham")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongTon")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_NhanHang")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_NhanHang")%>
                        </td>
                    </tr>
                 </ItemTemplate>
                 <AlternatingItemTemplate>
                     <tr>
                        <td>
                            <%#Eval("TenSanPham")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongTon")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_NhanHang")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_NhanHang")%>
                        </td>
                    </tr>
                 </AlternatingItemTemplate>
                 </asp:DataList>
      		</table>
    </div>
    <br />
    <div class="quanlysanpham">
        	<span class="order-title"> Danh Sách Sản Phẩm Hết Thời Hạn Mua Hoặc Hết Hàng</span>
   	        <table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th class="style7">Mã sản phẩm</th>
                    <th class="style7" >Tên sản phẩm</th>
                    <th class="style8">Số lượng tồn</th>
                    <th class="style6">Thời gian BD Bán</th>
                    <th class="style6">Thời gian KT Bán</th>
                    <th class="style6" >Thời gian BD Nhận Hàng</th>
                    <th class="style6"> Thời gian KT Nhận Hàng</th>
                </tr>
                <asp:DataList ID="dlQuanLySanPhamHetHan" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                        RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlQuanLySanPhamHetHanResource1">
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#Eval("MaSanPham")%>
                        </td>
                        <td>
                            <%#Eval("TenSanPham")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongTon")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_NhanHang")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_NhanHang")%>
                        </td>
                    </tr>
                 </ItemTemplate>
                 <AlternatingItemTemplate>
                     <tr>
                        <td>
                            <%#Eval("TenSanPham")%>
                        </td>
                        <td>
                            <%#Eval("SoLuongTon")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_Ban")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianBD_NhanHang")%>
                        </td>
                        <td>
                            <%#Eval("ThoiGianKT_NhanHang")%>
                        </td>
                    </tr>
                 </AlternatingItemTemplate>
                 </asp:DataList>
      		</table>
    </div>
	</div>
    <!--end .order-wrapper--> 
</asp:Panel>