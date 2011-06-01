using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class DonDatHang : SqlDataAccessHelper
    {
        #region Member Variables
        private int maDDH = int.MinValue;
        private DateTime ngayDat = DateTime.Parse("1/1/1900");
        private int soLuongDat = int.MinValue;
        private int trangThai = 1;
        private int maKhachHang = int.MinValue;
        private int maSanPham = int.MinValue;
        private int maDaiLy = int.MinValue;
        private DateTime ngayNhanHang = DateTime.MaxValue;
        private float thanhTien = float.MinValue;
        private string tenDaiLy = String.Empty;
        private string tenSanPham = String.Empty;
        private DateTime nhanHangTuNgay = DateTime.MaxValue;
        private DateTime nhanHangDenNgay = DateTime.MaxValue;
        private string tenTrangThai = String.Empty;       

        #endregion

        #region Properties

        public string TenTrangThai
        {
            get { return tenTrangThai; }
            set { tenTrangThai = value; }
        }

        public DateTime NhanHangDenNgay
        {
            get { return nhanHangDenNgay; }
            set { nhanHangDenNgay = value; }
        }

        public DateTime NhanHangTuNgay
        {
            get { return nhanHangTuNgay; }
            set { nhanHangTuNgay = value; }
        }


        public string TenSanPham
        {
            get { return tenSanPham; }
            set { tenSanPham = value; }
        }

        public string TenDaiLy
        {
            get { return tenDaiLy; }
            set { tenDaiLy = value; }
        }
        
        public int MaDDH
        {
            get { return maDDH; }
            set { maDDH = value; }
        }

        public DateTime NgayDat
        {
            get { return ngayDat; }
            set { ngayDat = value; }
        }

        public int SoLuongDat
        {
            get { return soLuongDat; }
            set { soLuongDat = value; }
        }

        public int TrangThai
        {
            get { return trangThai; }
            set { trangThai = value; }
        }

        public int MaKhachHang
        {
            get { return maKhachHang; }
            set { maKhachHang = value; }
        }

        public int MaSanPham
        {
            get { return maSanPham; }
            set { maSanPham = value; }
        }

        public int MaDaiLy
        {
            get { return maDaiLy; }
            set { maDaiLy = value; }
        }

        public DateTime NgayNhanHang
        {
            get { return ngayNhanHang; }
            set { ngayNhanHang = value; }
        }
        public float ThanhTien
        {
            get { return thanhTien; }
            set { thanhTien = value; }
        }
        #endregion

        #region Method
        /// <summary>
        /// Thêm đơn đặt hàng
        /// ngọc hà :28/5/2011
        /// </summary>
        /// <param name="ddh">đơn đặt hàng</param>
        /// <returns></returns>   
        public static int ThemDonDatHang(DonDatHang ddh)
        {
            int res = 0;
           
            try
            {
                int MaDonDatHang = 0;
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@ngaydat", ddh.ngayDat));
                lstParams.Add(new SqlParameter("@soluongdat", ddh.soLuongDat));
                lstParams.Add(new SqlParameter("@trangthai",ddh.trangThai));
                lstParams.Add(new SqlParameter("@makhachhang", ddh.maKhachHang));
                lstParams.Add(new SqlParameter("@masanpham", ddh.maSanPham));
                lstParams.Add(new SqlParameter("@madaily", ddh.maDaiLy));
                lstParams.Add(new SqlParameter("@thanhtien", ddh.thanhTien));
                lstParams.Add(new SqlParameter("@ngaynhanhang", ddh.ngayNhanHang));
                SqlParameter param = new SqlParameter("@maddh", MaDonDatHang);
                param.Direction = ParameterDirection.Output;
                lstParams.Add(param);

                if (SqlDataAccessHelper.ExecuteNoneQuery("spThemDonDatHang", lstParams) > 0)
                {
                    ddh.MaDDH = int.Parse(param.Value.ToString());
                    res = 1;
                }

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        /// <summary>
        /// Hủy đặt hàng
        /// Ngọc Hà :28/5/2011
        /// </summary>
        /// <returns></returns>
        public static int HuyDonDatHang(int iMaDDH)
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", iMaDDH));
                
                res = SqlDataAccessHelper.ExecuteNoneQuery("spHuyDonDatHang", lstParams);


            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        /// <summary>
        /// Cập nhật trạng thái đơn đặt hàng
        /// Ngọc Hà :28/5/2011
        /// </summary>
        /// <returns></returns>
        public int CapNhatTrangThaiDonDatHang()
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", MaDDH));
                lstParams.Add(new SqlParameter("@trangthai", TrangThai));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatTrangThaiDonDatHang", lstParams);


            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        /// <summary>
        /// Cập nhật ngày nhận của đơn đặt hàng
        /// Ngọc Hà :28/5/2011
        /// </summary>
        /// <returns></returns>
        public int CapNhatNgayNhanHangCuaDonDatHang()
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", MaDDH));
                lstParams.Add(new SqlParameter("@ngaynhanhang", NgayNhanHang));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatNgayNhanHangCuaDDH", lstParams);


            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }
        /// <summary>
        /// Lấy ds đơn đặt hàng 
        /// Thu Hà  : 1/6/2011
        /// </summary>
        /// <returns></returns>
        public static List<DonDatHang> LayDSDonDatHang()
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {                
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHang");

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {
                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.TenTrangThai = BUS.TrangThai.LayTrangThaiTheoMa(donDatHang.TrangThai).TenTrangThai;
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.TenSanPham = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).TenSanPham;
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.TenDaiLy = BUS.DaiLy.LayThongTinDaiLyTheoMa(donDatHang.MaDaiLy).TenDaiLy;
                    donDatHang.NhanHangTuNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianBD_NhanHang;
                    donDatHang.NhanHangDenNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianKT_NhanHang;

                    try
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    }
                    catch
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse("1/1/1900");
                    }
                    donDatHang.ThanhTien = float.Parse(dtRow["ThanhTien"].ToString());

                    lstDonDatHang.Add(donDatHang);

                }

            }
            catch (Exception e)
            {
                lstDonDatHang = new List<DonDatHang>();
                throw e;
            }
            return lstDonDatHang;
        }

        /// <summary>
        /// Lấy ds đơn đặt hàng theo mã sản phẩm
        /// Ngọc Hà :28/5/2011
        /// </summary>
        /// <param name="maSanPham">mã sản phẩm</param>
        /// <returns></returns>
        public static List<DonDatHang> LayDSDonDatHangTheoMaSanPham(int maSanPham)
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@masanpham", maSanPham));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaSanPham", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {
                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.TenTrangThai = BUS.TrangThai.LayTrangThaiTheoMa(donDatHang.TrangThai).TenTrangThai;
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.TenSanPham = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).TenSanPham;
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.TenDaiLy = BUS.DaiLy.LayThongTinDaiLyTheoMa(donDatHang.MaDaiLy).TenDaiLy;
                    donDatHang.NhanHangTuNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianBD_NhanHang;
                    donDatHang.NhanHangDenNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianKT_NhanHang;

                    try
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    }
                    catch
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse("1/1/1900");
                    }
                    donDatHang.ThanhTien = float.Parse(dtRow["ThanhTien"].ToString());

                    lstDonDatHang.Add(donDatHang);
                    
                }

            }
            catch (Exception e)
            {
                lstDonDatHang = new List<DonDatHang>();
                throw e;
            }
            return lstDonDatHang;
        }

        /// <summary>
        /// Lấy ds đơn đặt hàng theo mã khách hàng
        /// Ngọc Hà :28/5/2011
        /// Edit    : Thu Hà - 1/6/2011
        /// </summary>
        /// <param name="maKH">Mã khách hàng</param>
        /// <returns></returns>
        public static List<DonDatHang> LayDSDonDatHangTheoMaKhachHang(int maKH)
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@makhachhang", maKH));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaKhachHang", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {

                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.TenTrangThai = BUS.TrangThai.LayTrangThaiTheoMa(donDatHang.TrangThai).TenTrangThai;
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.TenSanPham = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).TenSanPham;
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.TenDaiLy = BUS.DaiLy.LayThongTinDaiLyTheoMa(donDatHang.MaDaiLy).TenDaiLy;
                    donDatHang.NhanHangTuNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianBD_NhanHang;
                    donDatHang.NhanHangDenNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianKT_NhanHang;

                    try
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    }
                    catch
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse("1/1/1900");
                    }
                    donDatHang.ThanhTien = float.Parse(dtRow["ThanhTien"].ToString());

                    lstDonDatHang.Add(donDatHang);
                }

            }
            catch (Exception e)
            {
                lstDonDatHang = new List<DonDatHang>();
                throw e;
            }
            return lstDonDatHang;
        }

        /// <summary>
        /// Lấy ds đơn đặt hàng theo mã đại lý
        /// Ngọc Hà :28/5/2011
        /// </summary>
        /// <param name="maDaiLy">mã đại lý nhận hàng</param>
        /// <returns></returns>
        public static List<DonDatHang> LayDSDonDatHangTheoMaDaiLyNhanHang(int maDaiLy)
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@madaily", maDaiLy));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaDaiLy", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {

                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.TenTrangThai = BUS.TrangThai.LayTrangThaiTheoMa(donDatHang.TrangThai).TenTrangThai;
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.TenSanPham = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).TenSanPham;
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.TenDaiLy = BUS.DaiLy.LayThongTinDaiLyTheoMa(donDatHang.MaDaiLy).TenDaiLy;
                    donDatHang.NhanHangTuNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianBD_NhanHang;
                    donDatHang.NhanHangDenNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianKT_NhanHang;

                    try
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    }
                    catch
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse("1/1/1900");
                    }
                    donDatHang.ThanhTien = float.Parse(dtRow["ThanhTien"].ToString());

                    lstDonDatHang.Add(donDatHang);

                }

            }
            catch (Exception e)
            {

                throw e;
            }
            return lstDonDatHang;
        }

        /// <summary>
        /// Lấy đơn đặt hàng theo mã ddh
        /// Ngọc Hà :28/5/2011
        /// Thu Ha
        /// 1/6/2011
        /// </summary>
        /// <param name="maddh">mã đơn đặt hàng</param>
        /// <returns></returns>
        public static DonDatHang LayDonDatHangTheoMaDDH(int maddh)
        {
            DonDatHang donDatHang = new DonDatHang();
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", maddh));

                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDonDatHangTheoMaDDH", lstParams);

                if (dtDonDatHang.Rows.Count>0)
                {
                    DataRow dtRow = dtDonDatHang.Rows[0];               
                    
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    // thu ha
                    donDatHang.TenTrangThai = BUS.TrangThai.LayTrangThaiTheoMa(donDatHang.TrangThai).TenTrangThai;
                    
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.TenSanPham = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).TenSanPham;
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.TenDaiLy = BUS.DaiLy.LayThongTinDaiLyTheoMa(donDatHang.MaDaiLy).TenDaiLy;
                    donDatHang.NhanHangTuNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianBD_NhanHang;
                    donDatHang.NhanHangDenNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianKT_NhanHang;

                    try
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    }
                    catch
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse("1/1/1900");
                    }
                    donDatHang.ThanhTien = float.Parse(dtRow["ThanhTien"].ToString());

                }
            }
            catch (Exception e)
            {
                donDatHang = new DonDatHang();
                throw e;
            }
            return donDatHang;
        }

        /// <summary>
        /// Lấy đơn đặt hàng theo mã ddh
        /// Ngọc Hà :28/5/2011
        /// </summary>
        /// <param name="ngayBatDau"></param>
        /// <param name="ngayKetThuc"></param>
        /// <returns></returns>
        public static List<DonDatHang> LayDSDonDatHangTheoNgayDat(DateTime ngayBatDau, DateTime ngayKetThuc)
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@ngaybatdau", ngayBatDau));
                lstParams.Add(new SqlParameter("@ngayketthuc", ngayKetThuc));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoNgayDat", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {
                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.TenTrangThai = BUS.TrangThai.LayTrangThaiTheoMa(donDatHang.TrangThai).TenTrangThai;
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.TenSanPham = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).TenSanPham;
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.TenDaiLy = BUS.DaiLy.LayThongTinDaiLyTheoMa(donDatHang.MaDaiLy).TenDaiLy;
                    donDatHang.NhanHangTuNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianBD_NhanHang;
                    donDatHang.NhanHangDenNgay = BUS.SanPham.LaySanPhamTheoMa(donDatHang.MaSanPham).ThoiGianKT_NhanHang;

                    try
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    }
                    catch
                    {
                        donDatHang.NgayNhanHang = DateTime.Parse("1/1/1900");
                    }
                    donDatHang.ThanhTien = float.Parse(dtRow["ThanhTien"].ToString());

                    lstDonDatHang.Add(donDatHang);
                }

            }
            catch (Exception e)
            {

                throw e;
            }
            return lstDonDatHang;
        }
        #endregion
    }
}
