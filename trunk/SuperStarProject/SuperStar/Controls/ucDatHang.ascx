<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDatHang.ascx.cs" Inherits="ShoppingHere.Controls.ucDonDatHang" %>


<asp:Panel ID="panelDatHang" runat="server">
    <div class="order-wrapper">
    	<div class="order">
        	<h3>ĐƠN ĐẶT HÀNG (vô asp dùng group OR Jquery)</h3>
        	<table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th >Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th >Tổng điểm thưởng</th>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>text box</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
   		  </table>
      </div>
        <!--end .order-->
        <div class="select-gift">
        	<h3>CHỌN TẶNG PHẨM(vô asp dùng group OR Jquery)</h3>
   	  <table width="100%" border="0" cellpadding="5" cellspacing="0" class="rounded-corner">
                <tr>
                    <th width="95" >Tên tặng phẩm</th>
                    <th width="109">Số lượng còn lại</th>
                    <th width="103">Điểm thưởng YC</th>
                    <th width="111">Số lượng tối đa</th>
                    <th width="63" >#</th>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>text box</td>
                </tr>
      		</table>
    </div>
        <!--end .select-gift-->
        <div class="select-agent">
        	<h3> Chọn Đại Lý</h3>
            COmbobox
        </div>
        <!--end .select-agent-->
      <div class="select-buy">Button để ở đây </div>
	</div>
    <!--end .order-wrapper--> 
</asp:Panel>