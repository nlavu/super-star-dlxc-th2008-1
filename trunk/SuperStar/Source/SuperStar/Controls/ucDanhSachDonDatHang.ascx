<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDanhSachDonDatHang.ascx.cs" Inherits="SuperStar.Controls.ucDanhSachDonDatHang" %>


<asp:Panel runat="server" ID="pnlThongBao">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
        <tr>
            <td align="center">
                <div class="blue">Thông báo</div>
            </td>
        </tr>
        <tr>
            <td align="left" class="link-3" >
                <asp:Label runat="server" ID="lblThongBao"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>

<asp:Panel ID="pnlDSDonDatHang_KH" runat="server">
<table width="100%" class="table-danhsach">
    <thead>
        <tr>
            <th>
                Mã DDH</th>
            <th>
                Tên sản phẩm</th>
            <th>
                Số lượng</th>
            <th>
                Thành tiền</th>
            <th>
                Trạng thái</th>
            <th>
                Hủy</th>
           
        </tr>
    </thead>
     <asp:DataList ID="dlDsDonDatHang_KH" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlDanhSachTangPhamResource1">
          <ItemTemplate>
                    <tr>
                        <td><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td><%#Eval("SoLuongDat") %></td>
                        <td><%#Eval("ThanhTien") %> </td>
                        <td><%#Eval("TenTrangThai") %></td>
                        <td><asp:Button ID="btnHuyDDH" runat="server" Text="Hủy" OnClick="btnHuyDDH_Click" /></td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            Ngày đặt: <%#Eval("NgayDat") %>
                            <br />
                            Đại lý nhận hàng: <%#Eval("TenDaiLy")%>
                            <br />
                            Thời gian nhận hàng từ ngày <%#Eval("NhanHangTuNgay") %> đến ngày <%#Eval("NhanHangDenNgay") %>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            <table width="100%" cellpadding="5" cellspacing ="0">
                            <asp:HiddenField runat="server" ID="hidMaDDH" Value='<%#Eval("MaDDH") %>' />                            
                            <asp:DataList ID="dlDSChiTietDDH" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" >
                                <HeaderTemplate>                                    
                                     <tr>
                                            <td>Tên tặng phẩm</td>
                                            <td>Số lượng</td>
                                      </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%#Eval("TenTangPham") %></td>
                                        <td><%#Eval("SoLuong") %></td>
                                    </tr>
                                </ItemTemplate>                                
                            </asp:DataList>
                            </table>
                           
                        </td>
                    </tr>                        
           </ItemTemplate>
     </asp:DataList> 
</table>
</asp:Panel>


<asp:Panel ID="pnlDSDonDatHang_DaiLy" runat="server">
<table width="100%" class="table-danhsach">
    <thead>
        <tr>
            <th>
                Mã DDH</th>
            <th>
                Tên sản phẩm</th>
            <th>
                Số lượng</th>
            <th>
                Thành tiền</th>
            <th>
                Trạng thái</th>
            <th>Đã nhận hàng</th>
           
        </tr>
    </thead>
     <asp:DataList ID="dlDsDonDatHang_DaiLy" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlDanhSachTangPhamResource1" 
        onitemdatabound="dlDsDonDatHang_DaiLy_ItemDataBound">
           <ItemTemplate>
                    <tr>
                        <td><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td><%#Eval("SoLuongDat") %></td>
                        <td><%#Eval("ThanhTien") %> </td>
                        <td><%#Eval("TenTrangThai") %></td>
                        <td><asp:Button ID="btnHuyDDH" runat="server" Text="Hủy" OnClick="btnHuyDDH_Click" /></td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            Ngày đặt: <%#Eval("NgayDat") %>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            <table width="100%" cellpadding="5" cellspacing ="0">
                            <asp:HiddenField runat="server" ID="hidMaDDH" Value='<%#Eval("MaDDH") %>' />                            
                            <asp:DataList ID="dlDSChiTietDDH" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" >
                                <HeaderTemplate>                                    
                                     <tr>
                                            <td>Tên tặng phẩm</td>
                                            <td>Số lượng</td>
                                      </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%#Eval("TenTangPham") %></td>
                                        <td><%#Eval("SoLuong") %></td>
                                    </tr>
                                </ItemTemplate>                                
                            </asp:DataList>
                            </table>
                           
                        </td>
                    </tr>                        
           </ItemTemplate>
     </asp:DataList> 
</table>
</asp:Panel>



<asp:Panel ID="pnlDSDonDatHang_QuanLy" runat="server">
<table width="100%" class="table-danhsach">
    <thead>
        <tr>
            <th>
                Mã DDH</th>
            <th>
                Tên sản phẩm</th>
            <th>
                Số lượng</th>
            <th>
                Thành tiền</th>
            <th>
                Trạng thái</th>
            <th>
                Hủy</th>
           
        </tr>
    </thead>
     <asp:DataList ID="dlDSDonDatHang_QuanLy" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlDanhSachTangPhamResource1" 
        onitemdatabound="dlDSDonDatHang_QuanLy_ItemDataBound">
           <ItemTemplate>
                    <tr>
                        <td><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td><%#Eval("SoLuongDat") %></td>
                        <td><%#Eval("ThanhTien") %> </td>
                        <td><%#Eval("TenTrangThai") %></td>
                        <td><asp:Button ID="btnHuyDDH" runat="server" Text="Hủy" OnClick="btnHuyDDH_Click" /></td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            Ngày đặt: <%#Eval("NgayDat") %>
                            <br />
                            Đại lý nhận hàng: <%#Eval("TenDaiLy")%>
                            <br />
                            Thời gian nhận hàng từ ngày <%#Eval("NhanHangTuNgay") %> đến ngày <%#Eval("NhanHangDenNgay") %>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="6">
                            <table width="100%" cellpadding="5" cellspacing ="0">
                            <asp:HiddenField runat="server" ID="hidMaDDH" Value='<%#Eval("MaDDH") %>' />                            
                            <asp:DataList ID="dlDSChiTietDDH" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" >
                                <HeaderTemplate>                                    
                                     <tr>
                                            <td>Tên tặng phẩm</td>
                                            <td>Số lượng</td>
                                      </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%#Eval("TenTangPham") %></td>
                                        <td><%#Eval("SoLuong") %></td>
                                    </tr>
                                </ItemTemplate>                               
                            </asp:DataList>                            
                            </table>
                        </td>
                    </tr>                        
           </ItemTemplate>
     </asp:DataList> 
</table>
</asp:Panel>