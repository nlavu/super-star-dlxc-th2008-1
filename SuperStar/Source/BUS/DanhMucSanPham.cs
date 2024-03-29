﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class DanhMucSanPham :SqlDataAccessHelper
    {
        #region Member Variables
        int _ma = int.MinValue;

        string _tenLoaiSanPham = string.Empty;

        #endregion

        #region Properties

        public int Ma
        {
            get { return _ma; }
            set { _ma = value; }
        }


        public string TenLoaiSanPham
        {
            get { return _tenLoaiSanPham; }
            set { _tenLoaiSanPham = value; }
        }
        #endregion

        #region method

        /// <summary>
        /// Lấy Danh Mục Sản Phẩm :
        /// Anh Vũ
        /// </summary>
        /// <returns></returns>        
        public static List<DanhMucSanPham> LayDanhMucSanPham()
        {
            List<DanhMucSanPham> lstDanhMucSanPham = new List<DanhMucSanPham>();
            try
            {
                DataTable dtDanhMucSanPham = new DataTable();
                dtDanhMucSanPham = SqlDataAccessHelper.ExecuteQuery("spLayDanhMucSanPham");
                foreach (DataRow dtRow in dtDanhMucSanPham.Rows)
                {
                    DanhMucSanPham danhMucSanPham = new DanhMucSanPham();
                    danhMucSanPham._ma = int.Parse(dtRow["Ma"].ToString());
                    danhMucSanPham._tenLoaiSanPham = dtRow["TenLoaiSanPham"].ToString();
                    lstDanhMucSanPham.Add(danhMucSanPham);
                }
            }
            catch (Exception e)
            {
                
            }
            return lstDanhMucSanPham;
        }

        #endregion
    }
}
