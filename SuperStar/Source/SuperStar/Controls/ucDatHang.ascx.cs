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
    public partial class ucDonDatHang : System.Web.UI.UserControl
    {
        int maSanPham = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // kiểm tra đã đăng nhập chưa
             int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                Response.Redirect("../Index.aspx");
            }
            
            if (int.TryParse((Request.QueryString["maSanPham"]),out maSanPham))
            {
                // sản phẩm
                BUS.SanPham sp = BUS.SanPham.LaySanPhamTheoMa(maSanPham);
                lblTenSanPham.Text = sp.TenSanPham;                
                hidDonGia.Value = sp.DonGia.ToString();
                hidDiemThuongSP.Value = sp.DiemThuong.ToString();

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