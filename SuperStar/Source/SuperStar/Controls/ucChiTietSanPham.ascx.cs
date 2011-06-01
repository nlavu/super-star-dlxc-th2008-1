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
    public partial class ChiTietSanPham : System.Web.UI.UserControl
    {
        int maSanPham = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            BUS.SanPham sanPham = new BUS.SanPham();
           
            // maSanPham = 1; 
            //lấy mã sản phẩm từ danh sách sản phẩm
            if (!int.TryParse(Request.QueryString["maSanPham"], out maSanPham))
            {
                Response.Redirect("Index.aspx");
            }

            sanPham = BUS.SanPham.LaySanPhamTheoMa(maSanPham);
            imgSanPham.ImageUrl = sanPham.HinhAnh;
            hpTenSanPham.Text = sanPham.TenSanPham;
            hpTenSanPham.NavigateUrl = "../ChiTietSanPham.aspx?maSanPham=" + sanPham.MaSanPham.ToString();
            lbGiaSanPham.Text = String.Format("{0:N0}",sanPham.DonGia);
            lbDiemThuong.Text = sanPham.DiemThuong.ToString();
            lbSoLuongSPDaBan.Text = (sanPham.SoLuongSP - sanPham.SoLuongTon).ToString();
            lbSoLuongTon.Text = sanPham.SoLuongTon.ToString();

            List<TangPham> lstTangPham = new List<TangPham>();
            lstTangPham = TangPham.LayDSTangPhamTheoMaSP(maSanPham);
            this.dlDanhSachTangPham.DataSource = lstTangPham;
            this.dlDanhSachTangPham.DataBind();
        }

        protected void btnMua_Click(object sender, EventArgs e)
        {
            Response.Redirect("DatHang.aspx?maSanPham=" + maSanPham.ToString());
        }
    }
}