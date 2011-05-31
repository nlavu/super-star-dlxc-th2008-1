<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDangSanPham.ascx.cs" Inherits="SuperStar.Controls.ucDangSanPham" %>

<asp:Panel runat="server" ID="pnlThongBao">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
    <tr><td align="center"><div class="blue">Bạn không đủ quyền để truy cập vào khu vực này</div></td></tr>
    <tr><td align="center"><a href="../Index.aspx">Click vào đây để về trang chủ</a></td></tr>
    </table>
</asp:Panel>


<asp:Panel runat="server" ID="pnlDangSanPham">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr>
        	<th align="center" colspan="2">
        	    <h2>
        	    <div class="blue">ĐĂNG SẢN PHẨM</div>
                </h2>
           </th>
      	</tr>      
          <tr>
            <td width="37%" align="right">Tên sản phẩm <span class="mess">(*)</span></td>
            <td width="63%"><label for="txtTenSanPham"></label>
                <asp:TextBox TextMode="SingleLine" ID="txtTenSanPham" runat="server" size="30"/> 
                <asp:RequiredFieldValidator ID="requiredValidatorTenSanPham" runat="server" 
                    ControlToValidate="txtTenSanPham" Display="Dynamic" 
                    ErrorMessage="Chưa nhập tên sản phẩm" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                              
             </td>
          </tr> 
          <tr>
            <td width="37%" align="right">Loại sản phẩm <span class="mess">(*)</span></td>
            <td width="63%"><label for="txtTenSanPham"></label>
                <asp:DropDownList runat ="server" ID="dropLoaiSanPham" Width="150" ></asp:DropDownList>   
                             
            </td>
          </tr> 
          <tr>
            <td align="right">Đơn giá <span class="mess">(*)</span></td>
            <td><label for="txtDonGia"></label>
                <asp:TextBox ID="txtDonGia" runat="server" />
                <asp:RequiredFieldValidator ID="requiredValidatorDonGia" runat="server" 
                    ControlToValidate="txtDonGia" Display="Dynamic" 
                    ErrorMessage="Chưa nhập đơn giá" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="validatorDonGia" runat="server" 
                    ControlToValidate="txtDonGia" Display="Dynamic" 
                    ErrorMessage="Đơn giá chỉ chứa số" 
                    SetFocusOnError="True" ValidationExpression="[0-9,,]"></asp:RegularExpressionValidator>
            
            </td>
          </tr>      
         <tr>
            <td align="right">Số lượng <span class="mess">(*)</span></td>
            <td>
                <label for="txtSoLuong"></label>
                <asp:TextBox ID="txtSoLuong" runat="server"/>
                <asp:RequiredFieldValidator ID="requiredValidatorSoLuong" runat="server" 
                    ControlToValidate="txtSoLuong" Display="Dynamic" 
                    ErrorMessage="Chưa nhập số lượng" SetFocusOnError="True"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="validatorSoLuong" runat="server" 
                    ControlToValidate="txtSoLuong" Display="Dynamic" 
                    ErrorMessage="Số lượng chỉ chứa số" 
                    SetFocusOnError="True" ValidationExpression="[0-9]"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
          <td width="37%" align="right">Điểm thưởng <span class="mess">(*)</span></td>
          <td width="63%">
            <asp:TextBox TextMode="SingleLine" runat="server" ID="txtDiemThuong" />
              <asp:RequiredFieldValidator ID="validateDiemThuong" runat="server" 
                  ControlToValidate="txtDiemThuong" ErrorMessage="Chưa nhập điểm thưởng" 
                  SetFocusOnError="True"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator ID="validatorDiemThuong" runat="server" 
                    ControlToValidate="txtDiemThuong" Display="Dynamic" 
                    ErrorMessage="Điểm thưởng chỉ chứa số" 
                    SetFocusOnError="True" ValidationExpression="[0-9]"></asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td width="37%" align="right">Thời gian bắt đầu bán <span class="mess">(*)</span></td>
          <td width="63%">
            <asp:TextBox TextMode="SingleLine" runat="server" ID="TextBox1" />
          </td>
        </tr>
        <tr>
          <td width="37%" align="right">Thời gian kết thúc bán <span class="mess">(*)</span></td>
          <td width="63%">
            <asp:TextBox TextMode="SingleLine" runat="server" ID="TextBox2" />
          </td>
        </tr>
        
        <tr>
          <td width="37%" align="right">Thời gian bắt đầu nhận hàng <span class="mess">(*)</span></td>
          <td width="63%">
            <asp:TextBox TextMode="SingleLine" runat="server" ID="TextBox3" />
          </td>
        </tr>
        <tr>
          <td width="37%" align="right">Thời gian kết thúc nhận hàng <span class="mess">(*)</span></td>
          <td width="63%">
            <asp:TextBox TextMode="SingleLine" runat="server" ID="TextBox4" />
          </td>
        </tr>        
        <tr>
          <td align="right">Hình ảnh:</td>
          <td>
              <asp:FileUpload ID="fileUpload" runat="server" />
          </td>
        </tr>
        
        <tr>
          <td width="37%" align="right">Thông tin sản phẩm <span class="mess">(*)</span></td>
          <td width="63%">            
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtThongTinSP" size="70" Columns="40" 
                    Rows="8"/>
          </td>
        </tr>
      
      <tr align="center" valign="middle">
        <td colspan="2">
        	<asp:Button ID="btnDangSanPham" runat="server" Text="Đăng Sản Phẩm" 
        	        onclick="btnDangSanPham_Click" /> &nbsp;&nbsp;&nbsp;&nbsp;
       	    <asp:Button ID="btnHuy" Text="Hủy" runat="server" onclick="btnHuy_Click"/>
        </td>
      </tr>
    </table>
</asp:Panel>