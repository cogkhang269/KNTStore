using System;
using System.Collections.Generic;

namespace KNT.Models;

public partial class GioHang
{
    public int MaGioHang { get; set; }

    public Guid MaNguoiDung { get; set; }

    public int MaSanPham { get; set; }

    public int SoLuong { get; set; }

    public decimal GiaDonVi { get; set; }

    public DateTime NgayTao { get; set; }

    public virtual User MaNguoiDungNavigation { get; set; } = null!;

    public virtual SanPham MaSanPhamNavigation { get; set; } = null!;
}
