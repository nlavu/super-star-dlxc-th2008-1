using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using BUS;
using System.Collections.Generic;

namespace SuperStar.Controls
{
    public partial class ucQuanLySanPham : System.Web.UI.UserControl
    {

        int maSanPham = 0;
        int maSanPhamXem = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            // kiểm tra đã đăng nhập chưa
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                Response.Redirect("../Index.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    List<BUS.SanPham> lstSanPhamConHan = BUS.SanPham.LayDsSanPhamConThoiHanMuaVaConHang();
                    this.dlQuanLySanPhamConHan.DataSource = lstSanPhamConHan;
                    this.dlQuanLySanPhamConHan.DataBind();

                    List<BUS.SanPham> lstSanPhamHetHan = BUS.SanPham.LayDsSanPhamHetThoiHanMuaHoacHetHang();
                    this.dlQuanLySanPhamHetHan.DataSource = lstSanPhamHetHan;
                    this.dlQuanLySanPhamHetHan.DataBind();
                }
            }
            List<BUS.SanPham> lstSanPham = BUS.SanPham.LayDsSanPhamConThoiHanMuaVaConHang();
            if (!Page.IsPostBack)
            {


                dropListSanPham.DataSource = lstSanPham;
                //dropListTaiKhoan.DataMember = "MaTaiKhoan";
                dropListSanPham.DataValueField = "MaSanPham";
                dropListSanPham.DataTextField = "TenSanPham";

                dropListSanPham.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < dlQuanLySanPhamConHan.Items.Count; i++)
            {
                TextBox txtSLSPMoi = dlQuanLySanPhamConHan.Items[i].FindControl("txtSLSPMoi") as TextBox;
                int soluongSPMoi = 0;
                if (!int.TryParse(txtSLSPMoi.Text, out soluongSPMoi))
                {
                    lblLoiSLSP.Text = "Số lượng sản phẩm phải là số.";
                    txtSLSPMoi.Focus();
                    return;
                    
                }
                if (soluongSPMoi == 0)
                {
                    continue;
                }

                HiddenField hidField = dlQuanLySanPhamConHan.Items[i].FindControl("hidMaSanPham") as HiddenField;
                BUS.SanPham sanPham = BUS.SanPham.LaySanPhamTheoMa(int.Parse(hidField.Value));
                // kiểm tra số lượng sản phẩm mới
                
                if (soluongSPMoi < sanPham.SoLuongSP)
                {
                    lblLoiSLSP.Text = "Số lượng sản phẩm " + sanPham.TenSanPham + " phải lớn hơn số lượng sản phẩm ban đầu!";
                    txtSLSPMoi.Focus();
                    continue;
                }
                if (int.Parse(txtSLSPMoi.Text) == sanPham.SoLuongSP)
                    continue;
                int res = sanPham.CapNhatSoLuongBanDau(soluongSPMoi);
               
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            
            maSanPhamXem = int.Parse(dropListSanPham.SelectedItem.Value);
            List<TangPham> lstTangPham = TangPham.LayDSTangPhamTheoMaSP(maSanPhamXem);
            dlDanhSachTangPham.DataSource = lstTangPham;
            //dropListTaiKhoan.DataMember = "MaTaiKhoan";
            dlDanhSachTangPham.DataBind();
            dlDanhSachTangPham.Visible = true;
            Button3.Visible = true;
            dlQuanLySanPhamConHan.Visible = false;
            Button1.Visible = false;
        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < dlDanhSachTangPham.Items.Count; i++)
            {
             

                TextBox txtSLTPMoi = dlDanhSachTangPham.Items[i].FindControl("txtSLTPMoi") as TextBox;
                int soluongTPMoi = 0;
                if (!int.TryParse(txtSLTPMoi.Text, out soluongTPMoi))
                {
                    lblLoiSLTP.Text = "Số lượng tặng phẩm phải là số.";
                    txtSLTPMoi.Focus();
                    return;

                }
                if (soluongTPMoi == 0)
                {
                    continue;
                }

                HiddenField hidField = dlDanhSachTangPham.Items[i].FindControl("hidMaTangPham") as HiddenField;
                TangPham tangPham = TangPham.LayTangPhamTheoMa(int.Parse(hidField.Value));
                // kiểm tra số lượng sản mới
                
                if (soluongTPMoi < tangPham.SoLuongTP)
                {
                    lblLoiSLTP.Text = "Số lượng tặng phẩm " + tangPham.TenTangPham + " phải lớn hơn số lượng tặng phẩm ban đầu!";
                    txtSLTPMoi.Focus();
                    continue;
                }
                tangPham.SoLuongTP = soluongTPMoi;
                int res = tangPham.CapNhatTangPham();
                
            }
        }

       
    }
}