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
        #endregion

        #region Properties

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

        public int ThemDonDatHang()
        {
            int res;
           
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@ngaydat", NgayDat));
                lstParams.Add(new SqlParameter("@soluongdat", SoLuongDat));
                lstParams.Add(new SqlParameter("@trangthai",TrangThai));
                lstParams.Add(new SqlParameter("@makhachhang", MaKhachHang));
                lstParams.Add(new SqlParameter("@masanpham", MaSanPham));
                lstParams.Add(new SqlParameter("@madaily", MaDaiLy));
                lstParams.Add(new SqlParameter("@thanhtien", ThanhTien));
                lstParams.Add(new SqlParameter("@ngaynhanhang", NgayNhanHang));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemDonDatHang",lstParams);


            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        public int HuyDonDatHang()
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", MaDDH));
                
                res = SqlDataAccessHelper.ExecuteNoneQuery("spHuyDonDatHang", lstParams);


            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

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

        public List<DonDatHang> LayDSDonDatHangTheoMaSanPham()
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@masanpham", MaSanPham));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaSanPham", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {
                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    donDatHang.ThanhTien = float.Parse(dtRow["MaDDH"].ToString());

                    lstDonDatHang.Add(donDatHang);
                    
                }

            }
            catch (Exception e)
            {
               
                throw e;
            }
            return lstDonDatHang;
        }

        public List<DonDatHang> LayDSDonDatHangTheoMaKhachHang()
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@makhachang", MaKhachHang));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaKhachHang", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {

                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    donDatHang.ThanhTien = float.Parse(dtRow["MaDDH"].ToString());

                    lstDonDatHang.Add(donDatHang);

                }

            }
            catch (Exception e)
            {

                throw e;
            }
            return lstDonDatHang;
        }

        public List<DonDatHang> LayDSDonDatHangTheoMaDaiLyNhanHang()
        {
            List<DonDatHang> lstDonDatHang = new List<DonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@madaily", MaDaiLy));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaDaiLy", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {

                    DonDatHang donDatHang = new DonDatHang();
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    donDatHang.ThanhTien = float.Parse(dtRow["MaDDH"].ToString());

                    lstDonDatHang.Add(donDatHang);

                }

            }
            catch (Exception e)
            {

                throw e;
            }
            return lstDonDatHang;
        }

        public DonDatHang LayDSDonDatHangTheoMaDDH()
        {
            DonDatHang donDatHang = new DonDatHang();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", maDDH));
                DataTable dtDonDatHang = new DataTable();
                dtDonDatHang = SqlDataAccessHelper.ExecuteQuery("spLayDSDonDatHangTheoMaDDH", lstParams);

                foreach (DataRow dtRow in dtDonDatHang.Rows)
                {

                    
                    donDatHang.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    donDatHang.NgayDat = DateTime.Parse(dtRow["NgayDat"].ToString());
                    donDatHang.SoLuongDat = int.Parse(dtRow["SoLuongDat"].ToString());
                    donDatHang.TrangThai = int.Parse(dtRow["TrangThai"].ToString());
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    donDatHang.ThanhTien = float.Parse(dtRow["MaDDH"].ToString());

                    

                }

            }
            catch (Exception e)
            {

                throw e;
            }
            return donDatHang;
        }
        public List<DonDatHang> LayDSDonDatHangTheoNgayDat(DateTime ngayBatDau, DateTime ngayKetThuc)
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
                    donDatHang.MaKhachHang = int.Parse(dtRow["MaKhachHang"].ToString());
                    donDatHang.MaSanPham = int.Parse(dtRow["MaSanPham"].ToString());
                    donDatHang.MaDaiLy = int.Parse(dtRow["MaDaiLy"].ToString());
                    donDatHang.NgayNhanHang = DateTime.Parse(dtRow["NgayNhanHang"].ToString());
                    donDatHang.ThanhTien = float.Parse(dtRow["MaDDH"].ToString());

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
