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
                List<BUS.SanPham> lstSanPhamConHan = BUS.SanPham.LayDsSanPhamConThoiHanMuaVaConHang();
                this.dlQuanLySanPhamConHan.DataSource = lstSanPhamConHan;
                this.dlQuanLySanPhamConHan.DataBind();

                List<BUS.SanPham> lstSanPhamHetHan = BUS.SanPham.LayDsSanPhamHetThoiHanMuaHoacHetHang();
                this.dlQuanLySanPhamHetHan.DataSource = lstSanPhamHetHan;
                this.dlQuanLySanPhamHetHan.DataBind();
            }
        }
    }
}