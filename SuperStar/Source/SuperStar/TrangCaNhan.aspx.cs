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

namespace SuperStar
{
    public partial class TrangCaNhan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ucDSDonDatHang.Visible = false;
            ucQuanLySanPham.Visible = false;
            ucQuanLyTaiKhoan.Visible = false;
            ucThongTinCaNhan.Visible = false;
            ucDSDonDatHang.Visible = false;
            int iDaDangNhap = (Int32)Session["IsLogin"];
            if (iDaDangNhap == 0)
            {
                Response.Redirect("Index.aspx");
            }
            else
            {
                TaiKhoan taiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoMaTaiKhoan((Int32)Session["Id"]);
                string type = Request.QueryString["type"];

                if (type == null)
                {
                    ucThongTinCaNhan.Visible = true;                 
                }
                else
                {
                    switch (type)
                    {
                        case "sp":
                            if (taiKhoan.LoaiTK == 1)
                                ucQuanLySanPham.Visible = true;
                            break;
                        case "tk":
                            if (taiKhoan.LoaiTK == 1)
                                ucQuanLyTaiKhoan.Visible = true;
                            break;
                        case "dsddh":
                            ucDSDonDatHang.Visible = true;
                            break;
                    }
                }
            }
        }
    }
}
