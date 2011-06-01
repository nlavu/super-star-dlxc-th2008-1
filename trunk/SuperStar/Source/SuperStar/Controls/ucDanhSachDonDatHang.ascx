<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDanhSachDonDatHang.ascx.cs" Inherits="SuperStar.Controls.ucDanhSachDonDatHang" %>


<asp:Panel runat="server" ID="pnlThongBao">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
        <tr>
            <td align="center">
                <div class="blue">Thông báo</div>
            </td>
        </tr>
        <tr>
            <td align="left" class="mess" >
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
            <th>
                Cập nhật</th>
           
        </tr>
    </thead>
     <asp:DataList ID="dlDsDonDatHang_KH" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlDanhSachTangPhamResource1" 
        onitemdatabound="dlDsDonDatHang_KH_ItemDataBound">
          <ItemTemplate>
                    <tr>
                        <td align="center"><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td align="center"><%#Eval("SoLuongDat") %></td>
                        <td align="right"><%#Eval("ThanhTien") %> </td>
                        <td align="center"><%#Eval("TenTrangThai") %></td>
                        <td style="color:#E9F5F9;" align="center">
                            <asp:ImageButton ID="imgBtnHuy" ImageUrl="~/image/deleteButton.png" runat="server" Text="Hủy" OnClick="btnHuyDDH_Click" />
                        </td>
                        <td style="color:#E9F5F9;" align="center">
                            <asp:ImageButton ID="imgBtnCapNhat" ImageUrl="~/image/editButton.gif" runat="server" Text="Cập nhật" OnClick="btnCapNhatDDH_Click" />
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="7">
                            <div class="info-line">Ngày đặt: <%#Eval("NgayDat") %></div>
                            
                            <div class="info-line"> Đại lý nhận hàng: <%#Eval("TenDaiLy")%></div>
                            
                            <div class="info-line">Thời gian nhận hàng từ ngày <%#Eval("NhanHangTuNgay") %> đến ngày <%#Eval("NhanHangDenNgay") %></div>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="7">
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
                        <td align="center"><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td align="center"><%#Eval("SoLuongDat") %></td>
                        <td align="right"><%#Eval("ThanhTien") %> </td>
                        <td align="center"><%#Eval("TenTrangThai") %></td>
                        <td style="color:#E9F5F9;" align="center">
                            <asp:ImageButton ID="imgBtnNhanHang" runat="server" Text="Hủy" OnClick="btnNhanHang_Click" />
                        </td>                       
                    </tr> 
                    <tr>
                        <td colspan="6">
                            <div class="info-line">Ngày đặt: <%#Eval("NgayDat") %></div>
                            
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
            <th>
                Cập nhật</th>
           
        </tr>
    </thead>
     <asp:DataList ID="dlDSDonDatHang_QuanLy" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" 
                    RepeatLayout="Flow" CellPadding="0" BorderWidth="0px" 
                    meta:resourcekey="dlDanhSachTangPhamResource1" 
        onitemdatabound="dlDSDonDatHang_QuanLy_ItemDataBound">
           <ItemTemplate>
                    <tr>
                        <td align="center"><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td align="center"><%#Eval("SoLuongDat") %></td>
                        <td align="right"><%#Eval("ThanhTien") %> </td>
                        <td align="center"><%#Eval("TenTrangThai") %></td>
                        <td style="color:#E9F5F9;" align="center">
                            <asp:ImageButton ID="imgBtnHuy" ImageUrl="~/image/deleteButton.png" runat="server" Text="Hủy" OnClick="btnHuyDDH_Click" />
                        </td>
                        <td style="color:#E9F5F9;" align="center">
                            <asp:ImageButton ID="imgBtnCapNhat" ImageUrl="~/image/editButton.gif" runat="server" Text="Cập nhật" OnClick="btnCapNhatDDH_Click" />
                        </td>                      
                    </tr> 
                    <tr>
                        <td colspan="7">
                            <div class="info-line">Ngày đặt: <%#Eval("NgayDat") %></div>
                            
                            <div class="info-line"> Đại lý nhận hàng: <%#Eval("TenDaiLy")%></div>
                            
                            <div class="info-line">Thời gian nhận hàng từ ngày <%#Eval("NhanHangTuNgay") %> đến ngày <%#Eval("NhanHangDenNgay") %></div>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="7">
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