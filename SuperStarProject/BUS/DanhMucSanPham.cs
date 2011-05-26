using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class DanhMucSanPham
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


    }
}
