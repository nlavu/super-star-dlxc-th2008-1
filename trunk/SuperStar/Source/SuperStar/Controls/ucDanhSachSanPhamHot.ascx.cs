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

namespace ShoppingHere.Controls
{
    public partial class ucDanhSachSanPhamHot : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<SanPham> lstSanPham = SanPham.LayDsSanPhamHot();
            this.dlDanhSachSanPhamHot.DataSource = lstSanPham;
            this.dlDanhSachSanPhamHot.DataBind();
        }
    }
}