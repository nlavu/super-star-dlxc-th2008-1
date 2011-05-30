<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucDanhMucSanPham.ascx.cs" Inherits="SuperStar.Controls.ucDanhMucSanPham" %>

<asp:Panel runat="server" ID="panelDanhMucCauHoi">
    <div id="Menu_content"> 
        <asp:GridView ID = "grvDanhMucSanPham" runat = "server" AllowPaging="false" ShowHeader="false" 
        ShowFooter="false" GridLines="None" AutoGenerateColumns="false" BorderStyle="None">
            <Columns>
            <asp:TemplateField>                
                <ItemTemplate>
                    <span class="menu_item"><a href="?page=home"> <%# Eval("TenLoaiSanPham") %> </a></span>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>      
        </asp:GridView>
    </div>
    <!--end #Menu_Content-->
</asp:Panel>