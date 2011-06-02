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
    public partial class ucQuanLyTaiKhoan : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<TaiKhoan> lstTaiKhoan = new List<TaiKhoan>();
            lstTaiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoLoaiTaiKhoan(3);
            dlDanhSachTaiKhoan.DataSource = lstTaiKhoan;
            dlDanhSachTaiKhoan.DataBind();
            if (!Page.IsPostBack)
            {
                

                dropListTaiKhoan.DataSource = lstTaiKhoan;
                //dropListTaiKhoan.DataMember = "MaTaiKhoan";
                dropListTaiKhoan.DataValueField = "MaTaiKhoan";
                dropListTaiKhoan.DataTextField = "TenTaiKhoan";

                dropListTaiKhoan.DataBind();
            }
           
        }

        protected void btnThayDoi_Click(object sender, EventArgs e)
        {
            List<TaiKhoan> lstTaiKhoan = new List<TaiKhoan>();
            lstTaiKhoan = TaiKhoan.LayThongTinTaiKhoanTheoLoaiTaiKhoan(3);
            dlDanhSachTaiKhoan.DataSource = lstTaiKhoan;
            dlDanhSachTaiKhoan.DataBind();
            if (!Page.IsPostBack)
            {


                dropListTaiKhoan.DataSource = lstTaiKhoan;
                //dropListTaiKhoan.DataMember = "MaTaiKhoan";
                dropListTaiKhoan.DataValueField = "MaTaiKhoan";
                dropListTaiKhoan.DataTextField = "TenTaiKhoan";

                dropListTaiKhoan.DataBind();
            }
            //ListItem lstMaTaiKhoan = new ListItem();
            //lstMaTaiKhoan = dropListTaiKhoan.SelectedItem;
            //int a = int.Parse(dropListLoaiTaiKhoan.);
            int maTaiKhoan = int.Parse(dropListTaiKhoan.SelectedValue.ToString());
           
            KhachHang khachHang = new KhachHang();
            khachHang = KhachHang.LayThongTinKhachHangTheoMa(maTaiKhoan);

            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();
            lstDonDatHang = DonDatHang.LayDSDonDatHangTheoMaKhachHang(maTaiKhoan);
            int countDDH = lstDonDatHang.Count;

            if (countDDH != 0)
            {
                lblTenTK.Text = khachHang.HoTen;
                lblThongBaoCapLaiQuyen.Text = " đã mua sản phẩm nên không thể chuyển thành đại lý!";
            }
            else
            {
                int res = 0;
                DaiLy daiLy = new DaiLy();
                
                daiLy.MaDaiLy = khachHang.MaKhachHang;
                daiLy.TenDaiLy = khachHang.HoTen;
                daiLy.Email = khachHang.Email;
                daiLy.SoDienThoai = khachHang.SoDienThoai;
                daiLy.NguoiDaiDien = khachHang.HoTen;
                res = daiLy.ThemDaiLy();
                if (res != 0)
                {
                    res = khachHang.XoaKhachHang();
                    lblThongBaoCapLaiQuyen.Text = " đã được chuyển thành đại lý!";
                    lblTenTK.Text = khachHang.HoTen;
                }
                
            }
        }



    } 
}
