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
            ImageButton btnHuy = (ImageButton)sender;
            DataListItem dlItem = (DataListItem)btnHuy.Parent;
            HiddenField hidMaDDH = dlItem.FindControl("hidMaDDH") as HiddenField;

            int trangThai = BUS.DonDatHang.LayDonDatHangTheoMaDDH(int.Parse(hidMaDDH.Value)).TrangThai;
            if (trangThai > 1)
            {
                lblThongBao.Text = "Không thể thực hiện thao tác. Đơn hàng " + hidMaDDH.Value + " đã " + TrangThai.LayTrangThaiTheoMa(trangThai).TenTrangThai + ".";
                pnlThongBao.Visible = true;
                return;
            }

            int res = BUS.DonDatHang.HuyDonDatHang(int.Parse(hidMaDDH.Value));
            if (res >= 1)
            {
                lblThongBao.Text = "Hủy đơn hàng " + hidMaDDH.Value + " thành công.";
                pnlThongBao.Visible = true;

                //load lại ds đơn đặt hàng
                List<BUS.DonDatHang> lstDonDatHang = BUS.DonDatHang.LayDSDonDatHangTheoMaKhachHang((Int32)Session["Id"]);
                dlDsDonDatHang_KH.DataSource = lstDonDatHang;
                dlDsDonDatHang_KH.DataBind();
                dlDsDonDatHang_KH.Visible = true;

                return;                
            }
            //throw new NotImplementedException();
        }

        protected void dlDsDonDatHang_DaiLy_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            HiddenField hidMaDDH = e.Item.FindControl("hidMaDDH") as HiddenField;

            List<ChiTietDonDatHang> lstChiTietDDH = new List<ChiTietDonDatHang>();
            lstChiTietDDH = ChiTietDonDatHang.LayDSChiTietDDHTheoMaDDH(int.Parse(hidMaDDH.Value));

            DataList dl = e.Item.FindControl("dlDSChiTietDDH") as DataList;
            dl.DataSource = lstChiTietDDH;
            dl.DataBind();

            ImageButton imgNhanHang = e.Item.FindControl("imgBtnNhanHang") as ImageButton;
            int trangThai = BUS.DonDatHang.LayDonDatHangTheoMaDDH(int.Parse(hidMaDDH.Value)).TrangThai;
            switch (trangThai)
            {
                case 1:
                case 2:
                case 3:
                    imgNhanHang.ImageUrl = "~/image/uncheckButton.gif";
                    imgNhanHang.AlternateText = "Chưa nhận hàng";
                    break;
                case 4:
                    imgNhanHang.ImageUrl = "~/image/checkButton.gif";
                    imgNhanHang.AlternateText = "Đã nhận hàng";
                    break;
                case 5:
                    imgNhanHang.ImageUrl = "~/image/canceButton.jpg";
                    imgNhanHang.AlternateText = "Đã hết thời gian nhận hàng";
                    break;
            }
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


        protected void btnCapNhatDDH_Click(object sender, EventArgs e)
        {
            ImageButton btnCapNhat = (ImageButton)sender;
            DataListItem dlItem = (DataListItem)btnCapNhat.Parent;
            HiddenField hidMaDDH = dlItem.FindControl("hidMaDDH") as HiddenField;

            int trangThai = BUS.DonDatHang.LayDonDatHangTheoMaDDH(int.Parse(hidMaDDH.Value)).TrangThai;
            if (trangThai > 1)
            {
                lblThongBao.Text = "Không thể thực hiện thao tác. Đơn hàng "+hidMaDDH.Value+" đã " + TrangThai.LayTrangThaiTheoMa(trangThai).TenTrangThai + ".";
                pnlThongBao.Visible = true;
                return;
            }

            //int res = BUS.DonDatHang.HuyDonDatHang(int.Parse(hidMaDDH.Value));
            //if (res >= 1)
            //{
            //    lblThongBao.Text = "Hủy đơn hàng " + hidMaDDH.Value + " thành công.";
            //    pnlThongBao.Visible = true;
            //    return;                
            //}
            //throw new NotImplementedException();
        }
        protected void btnNhanHang_Click(object sender, EventArgs e)
        {
            ImageButton btnNhanHang = (ImageButton)sender;
            DataListItem dlItem = (DataListItem)btnNhanHang.Parent;
            HiddenField hidMaDDH = dlItem.FindControl("hidMaDDH") as HiddenField;

            int trangThai = BUS.DonDatHang.LayDonDatHangTheoMaDDH(int.Parse(hidMaDDH.Value)).TrangThai;
            if (trangThai < 3)
            {
                lblThongBao.Text = "Chưa đến thời gian nhận hàng.";
                pnlThongBao.Visible = true;
                return;
            }
            if (trangThai == 3)
            {
                BUS.DonDatHang ddh = BUS.DonDatHang.LayDonDatHangTheoMaDDH(int.Parse(hidMaDDH.Value));
                ddh.NgayNhanHang = DateTime.Now;
                ddh.TrangThai = 4;
                ddh.CapNhatTrangThaiDonDatHang();
                ddh.CapNhatNgayNhanHangCuaDonDatHang();
                
                lblThongBao.Text = "Đơn hàng số "+hidMaDDH.Value+" đã giao.";
                pnlThongBao.Visible = true;

                //load lại ds đơn đặt hàng
                List<BUS.DonDatHang> lstDonDatHang = BUS.DonDatHang.LayDSDonDatHangTheoMaDaiLyNhanHang((Int32)Session["Id"]);
                dlDsDonDatHang_DaiLy.DataSource = lstDonDatHang;
                dlDsDonDatHang_DaiLy.DataBind();
                pnlDSDonDatHang_DaiLy.Visible = true;

                return;
            }
            if (trangThai == 4)
            {
                lblThongBao.Text = "Không thể thực hiện giao tác.Đơn hàng số " + hidMaDDH.Value + " đã giao.";
                pnlThongBao.Visible = true;
            }
            if (trangThai == 5)
            {
                lblThongBao.Text = "Đơn hàng số " + hidMaDDH.Value + " đã hết thời hạn nhận hàng. Không thể thực hiện giao tác.";
                pnlThongBao.Visible = true;
            }           
        }

    }
}