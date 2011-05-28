using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace BUS
{
    public class TrangThai
    {
        #region Member Variables
        int _maTrangThai = int.MinValue;

        string _tenTrangThai = string.Empty;

        #endregion

        #region Properties

        public int MaTrangThai
        {
            get { return _maTrangThai; }
            set { _maTrangThai = value; }
        }

        public string TenTrangThai
        {
            get { return _tenTrangThai; }
            set { _tenTrangThai = value; }
        }
        #endregion

        #region Methods


        #endregion
    }
}
