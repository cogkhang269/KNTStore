using System;
using System.Collections.Generic;

namespace KNT.Models;

public partial class HinhAnhSanPham
{
    public int MaHinhAnh { get; set; }

    public int MaSanPham { get; set; }

    public string DuongDanHinh { get; set; } = null!;

    public bool HinhChinh { get; set; }

    public DateTime NgayTao { get; set; }

    public virtual SanPham MaSanPhamNavigation { get; set; } = null!;
}
