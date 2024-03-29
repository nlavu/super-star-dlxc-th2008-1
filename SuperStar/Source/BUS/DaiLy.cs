﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class DaiLy
    {
        #region Member Variables

        int _maDaiLy = int.MinValue;

        string _tenDaiLy = string.Empty;

        string _diaChi = string.Empty;

        string _email = string.Empty;

        string _soDienThoai = string.Empty;

        string _nguoiDaiDien = string.Empty;

        #endregion

        #region Properties

        public int MaDaiLy
        {
            get { return _maDaiLy; }
            set { _maDaiLy = value; }
        }

        public string TenDaiLy
        {
            get { return _tenDaiLy; }
            set { _tenDaiLy = value; }
        }

        public string DiaChi
        {
            get { return _diaChi; }
            set { _diaChi = value; }
        }

        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }

        public string SoDienThoai
        {
            get { return _soDienThoai; }
            set { _soDienThoai = value; }
        }

        public string NguoiDaiDien
        {
            get { return _nguoiDaiDien; }
            set { _nguoiDaiDien = value; }
        }
        #endregion

        #region Method
        ///còn các hàm thêm, xóa, sửa thông tin đại lý
        public int CapNhatThongTinTaiKhoanDaiLy()
        {
            int res;
            try
            {
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@madaily", this.MaDaiLy));
                lstParam.Add(new SqlParameter("@tendaily", this.TenDaiLy));
                lstParam.Add(new SqlParameter("@diachi", this.DiaChi));
                lstParam.Add(new SqlParameter("@email", this.Email));
                lstParam.Add(new SqlParameter("@sodienthoai", this.SoDienThoai));
                lstParam.Add(new SqlParameter("@nguoidaidien", this.NguoiDaiDien));

                res = SqlDataAccessHelper.ExecuteNoneQuery("spCapNhatThongTinTaiKhoanDaiLy", lstParam);
            }
            catch (Exception e)
            {
                throw e;
            }

            return res;
        }
        /// <summary>
        /// Lấy ds đại lý
        /// </summary>
        /// <returns></returns>
        public static List<DaiLy> LayDSDaiLy()
        {
            List<DaiLy> lstDaiLy = new List<DaiLy>();
            try
            {
                DataTable dt = new DataTable();
                dt = SqlDataAccessHelper.ExecuteQuery("spLayDanhSachDaiLy");

                foreach (DataRow dr in dt.Rows)
                {
                    DaiLy daiLy = new DaiLy();
                    daiLy._maDaiLy = int.Parse(dr["MaDaiLy"].ToString());
                    daiLy._tenDaiLy = dr["TenDaiLy"].ToString();
                    daiLy._diaChi = dr["DiaChi"].ToString();
                    daiLy._email = dr["Email"].ToString();
                    daiLy._nguoiDaiDien = dr["NguoiDaiDien"].ToString();
                    daiLy._soDienThoai = dr["SoDienThoai"].ToString();

                    lstDaiLy.Add(daiLy);
                }
            }

            catch (Exception e)
            {
                lstDaiLy = null;
                throw (e);
            }

            return lstDaiLy;
        }
        /// <summary>
        /// Lấy thông tin đại lý theo mã đại lý   
        /// </summary>
        /// <param name="intMaDaiLy"></param>
        /// <returns></returns>
        public static DaiLy LayThongTinDaiLyTheoMa(int intMaDaiLy)
        {
            DaiLy daiLy = new DaiLy();
            try
            {
                DataTable dt = new DataTable();
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@madaily", intMaDaiLy));
                dt = SqlDataAccessHelper.ExecuteQuery("spLayThongTinDaiLyTheoMa", lstParam);

                DataRow dr = dt.Rows[0];
                daiLy._maDaiLy = int.Parse(dr["MaDaiLy"].ToString());
                daiLy._tenDaiLy = dr["TenDaiLy"].ToString();
                daiLy._diaChi = dr["DiaChi"].ToString();
                daiLy._email = dr["Email"].ToString();
                daiLy._nguoiDaiDien = dr["NguoiDaiDien"].ToString();
                daiLy._soDienThoai = dr["SoDienThoai"].ToString();
            }

            catch (Exception e)
            {
                daiLy = null;
                throw (e);
            }

            return daiLy;
        }
        /// <summary>
        ///  Lấy thông tin đại lý theo tên đại lý  
        /// </summary>
        /// <param name="strTenDaiLy"></param>
        /// <returns></returns>
        public static List<DaiLy> LayThongTinDaiLyTheoTen(string strTenDaiLy)
        {
            List<DaiLy> lstDaiLy = new List<DaiLy>();
            try
            {
                DataTable dt = new DataTable();
                List<SqlParameter> lstParam = new List<SqlParameter>();
                lstParam.Add(new SqlParameter("@madaily", strTenDaiLy));
                dt = SqlDataAccessHelper.ExecuteQuery("spLayThongTinDaiLyTheoTen", lstParam);

                foreach (DataRow dr in dt.Rows)
                {
                    DaiLy daiLy = new DaiLy();
                    daiLy._maDaiLy = int.Parse(dr["MaDaiLy"].ToString());
                    daiLy._tenDaiLy = dr["TenDaiLy"].ToString();
                    daiLy._diaChi = dr["DiaChi"].ToString();
                    daiLy._email = dr["Email"].ToString();
                    daiLy._nguoiDaiDien = dr["NguoiDaiDien"].ToString();
                    daiLy._soDienThoai = dr["SoDienThoai"].ToString();

                    lstDaiLy.Add(daiLy);
                }
            }

            catch (Exception e)
            {

                throw (e);
            }

            return lstDaiLy;
        }


        /// <summary>
        /// Thêm đại lý
        /// Anh Vũ
        /// </summary>
        /// <returns></returns>
        public int ThemDaiLy()
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@madaily", _maDaiLy));
                lstParams.Add(new SqlParameter("@tendaily", _tenDaiLy));
                lstParams.Add(new SqlParameter("@diachi", _diaChi));
                lstParams.Add(new SqlParameter("@email", _email));
                lstParams.Add(new SqlParameter("@sodienthoai", _soDienThoai));
                lstParams.Add(new SqlParameter("@nguoidaidien", _nguoiDaiDien));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spThemDaiLy", lstParams);

            }
            catch (Exception e)
            {
                res = 0;
                throw e;
            }
            return res;
        }

        /// <summary>
        /// Xoá Đại Lý
        /// Anh Vũ
        /// </summary>
        /// <returns></returns>
        public int XoaDaiLy()
        {
            int res;
            try
            {
                List<SqlParameter> lstParams = new List<SqlParameter>();
                lstParams.Add(new SqlParameter("@madaily", _maDaiLy));
                res = SqlDataAccessHelper.ExecuteNoneQuery("spXoaDaiLy", lstParams);

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
