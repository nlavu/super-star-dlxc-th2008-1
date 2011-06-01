<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucThemTangPham.ascx.cs" Inherits="SuperStar.Controls.ucThemTangPham" %>

<asp:Panel runat="server" ID="pnlThongBao">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
    <tr><td align="center"><div class="boxTitle">THÔNG BÁO</div></td></tr>
    <tr><td align="center"><div class="blue"><asp:Label runat="server" ID="lblThongBao"></asp:Label></div></td></tr>
    <tr><td align="center"><asp:HyperLink ID="hpRedirect" runat="server" ></asp:HyperLink></td></tr>
    </table>
</asp:Panel>

<asp:Panel runat="server" ID="pnlThemTangPham">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
            <td colspan="2" align="center"><div class="boxTitle">THÊM TẶNG PHẨM</div></td>
        </tr>
        <tr>
            <td width="37%" align="right">Chọn sản phẩm</td>
            <td width="63%"><label for="txtTenSanPham"></label>
                <asp:DropDownList runat ="server" ID="dropSanPham" Width="150" ></asp:DropDownList> 
            </td>
        </tr>
        <tr>
            <td width="37%" align="right">Tên tặng phẩm </td>
            <td width="63%"><label for="txtTenTangPham"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtTenTangPham" runat="server" size="30"/>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblTenTangPham" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
            <td width="37%" align="right">Điểm thưởng yêu cầu </td>
            <td width="63%"><label for="txtDiemThuongYC"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtDiemThuongYC" runat="server" size="30"/>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblDiemThuongYC" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
            <td width="37%" align="right">Số lượng </td>
            <td width="63%"><label for="txtSoLuong"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtSoLuongTP" runat="server" size="30"/>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblSoLuongTP" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
            <td width="37%" align="right">Số lượng tối đa mỗi đơn hàng có thể chọn</td><td width="63%"><label for="txtSoLuongToiDa"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtSoLuongToiDa" runat="server" size="30"/> 
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblSoLuongTPToiDa" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
          <td align="right">Hình ảnh tặng phẩm:</td><td>
              <asp:FileUpload ID="fileUploadTP" runat="server" />
              &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblHinhAnhTP" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        
        
        <tr align="center" valign="middle">
            <td colspan="2">
        	    <asp:Button ID="btnThemTangPham" runat="server" Text="Thêm tặng phẩm" onclick="btnThemTangPham_Click" 
        	            /> &nbsp;&nbsp;&nbsp;&nbsp;
       	        <asp:Button ID="btnHuy" Text="Hủy" runat="server" onclick="btnHuy_Click" />
            </td>
        </tr>
    </table>
</asp:Panel>