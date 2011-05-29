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

namespace ShoppingHere.Controls
{
    public partial class ucSanPhamNoiBat : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SanPham sanPham = new SanPham();
            int maSanPham = 1;//Request.QueryString("maSanPham");
            sanPham = SanPham.LaySanPhamTheoMa(maSanPham);
            imgSanPham.ImageUrl = sanPham.HinhAnh;
            hrTenSanPham.Text = sanPham.TenSanPham;
            lbGiaSanPham.Text = sanPham.DonGia.ToString();
            lbDiemThuong.Text = sanPham.DiemThuong.ToString();
            lbSoLuongSPDaBan.Text = (sanPham.SoLuongSP - sanPham.SoLuongTon).ToString();
            lbSoLuongTon.Text = sanPham.SoLuongTon.ToString();
            
        }
    }
}