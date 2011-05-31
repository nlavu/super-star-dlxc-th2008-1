using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BUS;

namespace SuperStar.Controls
{
    public partial class ucDangSanPham : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int DaDangNhap = (Int32)Session["IsLogin"];
            string Authentication = (string)Session["Authentication"];
            if (DaDangNhap == 0 || Authentication.CompareTo("QuanLy") != 0)
            {
                pnlDangSanPham.Visible = false;
                pnlThongBao.Visible = true;

                List<BUS.DanhMucSanPham> lstDanhMucSP = BUS.DanhMucSanPham.LayDanhMucSanPham();
                this.dropLoaiSanPham.DataSource = lstDanhMucSP;
                this.dropLoaiSanPham.DataMember = "TenLoaiSanPham";
                this.dropLoaiSanPham.DataTextField = "Ma";
                this.dropLoaiSanPham.DataBind();
            }
            else
            {
                pnlDangSanPham.Visible = true;
                pnlThongBao.Visible = false;
            }
        }

        protected void btnDangSanPham_Click(object sender, EventArgs e)
        {
            SanPham sanPham = new SanPham();
            sanPham.TenSanPham = txtTenSanPham.Text.Trim();

        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {

        }
    }
}