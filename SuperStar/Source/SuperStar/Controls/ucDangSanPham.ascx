<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDangSanPham.ascx.cs" Inherits="SuperStar.Controls.ucDangSanPham" %>

<asp:Panel runat="server" ID="pnlThongBao">
    <table width="100%" style="border-bottom: 1px dashed #CCC" cellspacing="0" cellpadding="5">
    <tr><td align="center"><div class="boxTitle">THÔNG BÁO</div></td></tr>
    <tr><td align="center"><div class="blue"><asp:Label runat="server" ID="lblThongBao"></asp:Label></div></td></tr>
    <tr><td align="center"><asp:HyperLink ID="hpRedirect" runat="server" ></asp:HyperLink></td></tr>
    </table>
</asp:Panel>


<asp:Panel runat="server" ID="pnlDangSanPham">
    <table width="100%" border="0" cellspacing="0" cellpadding="5">
    	<tr>
        	<th align="center" colspan="2">
        	    <h2>
        	    <div class="blue">ĐĂNG SẢN PHẨM</div>
                    <h2>
                    </h2>
                    <h2>
                    </h2>
                    <h2>
                    </h2>
                    <h2>
                    </h2>
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
                    SetFocusOnError="True" ValidationExpression="^\s*\d+\s*$"></asp:RegularExpressionValidator>
            
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
                    SetFocusOnError="True" ValidationExpression="^\s*\d+\s*$"></asp:RegularExpressionValidator>
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
                    SetFocusOnError="True" ValidationExpression="^\s*\d+\s*$"></asp:RegularExpressionValidator>
          </td>
        </tr>
        <tr>
          <td width="37%" align="right">Thời gian bắt đầu bán <span class="mess">(*)</span></td>
          <td width="63%">
            <input type="text" class="datepicker" runat="server" id="dtpThoiGianBDBan" />
          </td>
        </tr>
        <tr>
          <td width="37%" align="right">Thời gian kết thúc bán <span class="mess">(*)</span></td>
          <td width="63%">
            <input type="text" class="datepicker" runat="server" id="dtpThoiGianKTBan" />
           <asp:CompareValidator Type="Date" runat="server" ControlToCompare="dtpThoiGianKTBan" Operator="LessThan" 
                ControlToValidate="dtpThoiGianBDBan" ErrorMessage="Thời gian kết thúc bán phải lớn hơn thời gian bắt đầu bán hàng."
                ID="compareKTBan_BDBan" Display="Dynamic" SetFocusOnError="false"></asp:CompareValidator>
          </td></tr><tr>
          <td width="37%" align="right">Thời gian bắt đầu nhận hàng <span class="mess">(*)</span></td><td width="63%">
            <input type="text" class="datepicker" runat="server" id="dtpThoiGianBDNhan" />
            <asp:CompareValidator Type="Date" runat="server" ControlToCompare="dtpThoiGianBDNhan" Operator="LessThan" 
                ControlToValidate="dtpThoiGianKTBan" ErrorMessage="Thời gian bắt đầu nhận hàng phải lớn hơn thời gian kết thúc bán hàng."
                ID="compareBDNhan_KTBan" Display="Dynamic" SetFocusOnError="false"></asp:CompareValidator>
          </td>
        </tr>
        <tr>
          <td width="37%" align="right">Thời gian kết thúc nhận hàng <span class="mess">(*)</span></td><td width="63%">
            <input type="text" class="datepicker" runat="server" id="dtpThoiGianKTNhan" />
            <asp:CompareValidator Type="Date" runat="server" ControlToCompare="dtpThoiGianKTNhan" Operator="LessThan" 
                ControlToValidate="dtpThoiGianBDNhan" ErrorMessage="Thời gian kết thúc nhận hàng phải lớn hơn thời gian bắt đầu nhận hàng"
                ID="compareKTNhan_BDNhan" Display="Dynamic" SetFocusOnError="false"></asp:CompareValidator>
          </td>
        </tr>        
        <tr>
          <td align="right">Hình ảnh:</td><td>
              <asp:FileUpload ID="fileUpload" runat="server" />
          </td>
        </tr>
        
        <tr>
          <td width="37%" align="right">Thông tin sản phẩm <span class="mess">(*)</span></td><td width="63%">            
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtThongTinSP" size="70" Columns="40" 
                    Rows="8"/>
          </td>
        </tr>
        
        <tr>
            <td colspan="2" align ="center">----------------------------------------------------</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><div class="blue">TẶNG PHẨM</div></td></tr>
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
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnThemTangPham" runat="server" Text="Thêm" 
                    onclick="btnThemTangPham_Click"/> &nbsp;&nbsp;&nbsp;&nbsp;
        	</td>
        </tr>
        
        <tr>
            <td colspan="2" align="center">----------------------------------------------------</td>
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


