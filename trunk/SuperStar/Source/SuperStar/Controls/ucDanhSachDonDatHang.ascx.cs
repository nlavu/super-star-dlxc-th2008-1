using System;
using System.Collections;
using System.Collections.Generic;
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

namespace SuperStar.Controls
{
    public partial class ucDanhSachDonDatHang : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            pnlDSDonDatHang_KH.Visible = false;
            pnlDSDonDatHang_DaiLy.Visible = false;
            pnlDSDonDatHang_QuanLy.Visible = false;
            pnlThongBao.Visible = false;

            
            // kiểm tra đã đăng nhập chưa
            int iDaDangNhap = (Int32)Session["IsLogin"];
            string Authentication = (string)Session["Authentication"];            
            if (iDaDangNhap == 0)
            {
                Response.Redirect("Index.apsx");
                return;
            }
            if (Authentication.CompareTo("KhachHang") == 0)
            {
                List<BUS.DonDatHang> lstDonDatHang = BUS.DonDatHang.LayDSDonDatHangTheoMaKhachHang((Int32)Session["Id"]);
                dlDsDonDatHang_KH.DataSource = lstDonDatHang;
                dlDsDonDatHang_KH.DataBind();
                pnlDSDonDatHang_KH.Visible = true;
            }
            if (Authentication.CompareTo("DaiLy") == 0)
            {
                List<BUS.DonDatHang> lstDonDatHang = BUS.DonDatHang.LayDSDonDatHangTheoMaDaiLyNhanHang((Int32)Session["Id"]);
                dlDsDonDatHang_DaiLy.DataSource = lstDonDatHang;
                dlDsDonDatHang_DaiLy.DataBind();
                pnlDSDonDatHang_DaiLy.Visible = true;
            }
            if (Authentication.CompareTo("QuanLy") == 0)
            {
                List<BUS.DonDatHang> lstDonDatHang = BUS.DonDatHang.LayDSDonDatHang();
                dlDSDonDatHang_QuanLy.DataSource = lstDonDatHang;
                dlDSDonDatHang_QuanLy.DataBind();
                pnlDSDonDatHang_QuanLy.Visible = true;
            }
        }

        protected void dlDsDonDatHang_KH_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HiddenField hidMaDDH = e.Item.FindControl("hidMaDDH") as HiddenField;

            List<ChiTietDonDatHang> lstChiTietDDH = new List<ChiTietDonDatHang>();
            lstChiTietDDH = ChiTietDonDatHang.LayDSChiTietDDHTheoMaDDH(int.Parse(hidMaDDH.Value));

            DataList dl = e.Item.FindControl("dlDSChiTietDDH") as DataList;
            dl.DataSource = lstChiTietDDH;
            dl.DataBind();            

        }

        protected void btnHuyDDH_Click(object sender, EventArgs e)
        {
            Button btnHuy = (Button)sender;
            DataListItem dlItem = (DataListItem)btnHuy.Parent;
            HiddenField hidMaDDH = dlItem.FindControl("hidMaDDH") as HiddenField;

            if (BUS.DonDatHang.LayDonDatHangTheoMaDDH(int.Parse(hidMaDDH.Value)).TrangThai == 6)
            {
                return;
            }

            int res = BUS.DonDatHang.HuyDonDatHang(int.Parse(hidMaDDH.Value));
            if (res >= 1)
            {
                lblThongBao.Text = "Hủy đơn hàng thành công.";
                pnlThongBao.Visible = true;

            }
            throw new NotImplementedException();
        }

        protected void dlDsDonDatHang_DaiLy_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HiddenField hidMaDDH = e.Item.FindControl("hidMaDDH") as HiddenField;

            List<ChiTietDonDatHang> lstChiTietDDH = new List<ChiTietDonDatHang>();
            lstChiTietDDH = ChiTietDonDatHang.LayDSChiTietDDHTheoMaDDH(int.Parse(hidMaDDH.Value));

            DataList dl = e.Item.FindControl("dlDSChiTietDDH") as DataList;
            dl.DataSource = lstChiTietDDH;
            dl.DataBind(); 
        }

        protected void dlDSDonDatHang_QuanLy_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HiddenField hidMaDDH = e.Item.FindControl("hidMaDDH") as HiddenField;

            List<ChiTietDonDatHang> lstChiTietDDH = new List<ChiTietDonDatHang>();
            lstChiTietDDH = ChiTietDonDatHang.LayDSChiTietDDHTheoMaDDH(int.Parse(hidMaDDH.Value));

            DataList dl = e.Item.FindControl("dlDSChiTietDDH") as DataList;
            dl.DataSource = lstChiTietDDH;
            dl.DataBind(); 
        }



    }
}