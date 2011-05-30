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
    public partial class ucDonDatHang : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // kiểm tra đã đăng nhập chưa
             int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                Response.Redirect("../Index.aspx");
            }
            int maSanPham = 0;
            if (int.TryParse((Request.QueryString["maSanPham"]),out maSanPham))
            {
                // sản phẩm
                SanPham sp = SanPham.LaySanPhamTheoMa(maSanPham);
                lblTenSanPham.Text = sp.TenSanPham;
                txtSoLuongMuaSP.Text = "1";
                lblThanhTien.Text = sp.DonGia.ToString();
                lblDiemThuong.Text = sp.DiemThuong.ToString();

                // danh sách đại lý
                // bổ sung spLayDSDaiLy
                List<DaiLy> lstDaiLy = DaiLy.LayDSDaiLy();
                dropListDaiLy.DataMember = "MaDaiLy";
                dropListDaiLy.DataValueField = "TenDaiLy";
                dropListDaiLy.DataSource = lstDaiLy;
                dropListDaiLy.DataBind();

                // danh sách tặng phẩm
                List<TangPham> lstTangPham = TangPham.LayDSTangPhamTheoMaSP(maSanPham);
                dlDanhSachTangPham.DataSource = lstTangPham;
                dlDanhSachTangPham.DataBind();

            }
            else
            {
                Response.Redirect("../Index.aspx");
            }
        }

        protected void imgButtonBuy_Click(object sender, ImageClickEventArgs e)
        {

        }
    }
}