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

        public int IntMaDDH
        {
            get { return intMaDDH; }
            set { intMaDDH = value; }
        }
        public int IntMaTangPham
        {
            get { return intMaTangPham; }
            set { intMaTangPham = value; }
        }
        public int IntSoLuong
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
                lstParam.Add(new SqlParameter("@matangpham", IntMaTangPham));
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
        public int ThemChiTietDonDatHang(int intDiemThuong)
        {
            int res = 0;
            try
            {
                // add tham số
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maddh", intMaDDH));
                lstParam.Add(new SqlParameter("@matangpham", IntMaTangPham));
                lstParam.Add(new SqlParameter("@soluong", intSoLuong));
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
        /// <returns></returns>
        public int XoaChiTietDonDatHang()
        {
            int res = 0;
            try
            {
                // add tham số
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@maddh", intMaDDH));
                lstParam.Add(new SqlParameter("@matangpham", IntMaTangPham));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spXoaChiTietDonDatHang", lstParam);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        #endregion

    }
}
