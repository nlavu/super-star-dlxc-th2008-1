<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDanhSachDonDatHang.ascx.cs" Inherits="SuperStar.Controls.ucDanhSachDonDatHang" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Panel ID="pnlDSDonDatHang" runat="server">

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
        </tr>
    </thead>
    <asp:Accordion ID="accordionDSDDH" runat="server">
        <Panes>
            <asp:AccordionPane ID="accPaneDSDDH" runat="server">
                <Header>
                    <tr>
                        <td><%#Eval("MaDDH") %></td>
                        <td><%#Eval("TenSanPham") %></td>
                        <td><%#Eval("SoLuong") %></td>
                        <td><%#Eval("ThanhTien") %> </td>
                        <td><%#Eval("TrangThai") %></td>
                    </tr> 
                </Header>
                <Content>
                </Content>
            </asp:AccordionPane>
        </Panes>
    </asp:Accordion>      
</table>
</asp:Panel>

