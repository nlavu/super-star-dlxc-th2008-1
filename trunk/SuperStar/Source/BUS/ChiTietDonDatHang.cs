using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class ChiTietDonDatHang : SqlDataAccessHelper
    {
        #region Member Variables
        int intMaDDH = int.MinValue;  
        int intMaTangPham = int.MinValue;
        int intSoLuong = int.MinValue;
        #endregion

        #region Properties
        public int MaDDH
        {
            get { return intMaDDH; }
            set { intMaDDH = value; }
        }
        public int MaTangPham
        {
            get { return intMaTangPham; }
            set { intMaTangPham = value; }
        }
        public int SoLuong
        {
            get { return intSoLuong; }
            set { intSoLuong = value; }
        }
        #endregion

        #region method

        /// <summary>
        /// Cập nhật chi tiết đơn đặt hàng
        /// </summary>
        /// <param name="intDiemThuong"></param>
        /// <returns></returns>
        public int CapNhatChiTietDonDatHang(int intDiemThuong)
        {
            int res = 0;
            try
            {
                // add tham số

                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maddh", intMaDDH));
                lstParam.Add(new SqlParameter("@matangpham", intMaTangPham));
                lstParam.Add(new SqlParameter("@soluong", intSoLuong));
                lstParam.Add(new SqlParameter("@diemthuong", intDiemThuong));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatChiTietDonDatHang", lstParam);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }
        
        /// <summary>
        /// Thêm chi tiết đơn đặt hàng
        /// </summary>
        /// <param name="intDiemThuong"></param>
        /// <returns></returns>
        public static int ThemChiTietDonDatHang(ChiTietDonDatHang ctDDH,int intDiemThuong)
        {
            int res = 0;
            try
            {
                // add tham số
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maddh", ctDDH.MaDDH));
                lstParam.Add(new SqlParameter("@matangpham", ctDDH.MaTangPham));
                lstParam.Add(new SqlParameter("@soluong", ctDDH.SoLuong));
                lstParam.Add(new SqlParameter("@diemthuong", intDiemThuong));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemChiTietDonDatHang", lstParam);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }


        /// <summary>
        /// Xoá chi tiết đơn đặt hàng
        /// </summary>
        /// <param name="maddh">mã đơn đặt hàng</param>
        /// <param name="matangpham">mã tặng phẩm</param>
        /// <returns></returns>
        public static int XoaChiTietDonDatHang(int maddh, int matangpham)
        {
            int res = 0;
            try
            {
                // add tham số
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maddh", maddh));
                lstParam.Add(new SqlParameter("@matangpham", matangpham));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spXoaChiTietDonDatHang", lstParam);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        /// <summary>
        /// Lấy ds chi tiết đơn đặt hàng theo mã ddh
        /// </summary>
        /// <param name="maddh">mã đơn đặt hàng</param>
        /// <returns></returns>
        public static List<ChiTietDonDatHang> LayDSChiTietDDHTheoMaDDH(int maddh)
        {
            List<ChiTietDonDatHang> lstChiTietDDH = new List<ChiTietDonDatHang>();

            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@maddh", maddh));
                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayDSChiTietDDHTheoMaDDH", lstParams);

                foreach (DataRow dtRow in dt.Rows)
                {
                    ChiTietDonDatHang chiTietDDH = new ChiTietDonDatHang();
                    chiTietDDH.MaDDH = int.Parse(dtRow["MaDDH"].ToString());
                    chiTietDDH.MaTangPham = int.Parse(dtRow["MaTangPham"].ToString());
                    chiTietDDH.SoLuong = int.Parse(dtRow["SoLuong"].ToString());


                    lstChiTietDDH.Add(chiTietDDH);
                }

            }
            catch (Exception e)
            {
                lstChiTietDDH = new List<ChiTietDonDatHang>();
                throw e;
            }
            return lstChiTietDDH;
        }

        #endregion

    }
}