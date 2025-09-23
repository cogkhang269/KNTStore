using System;
using System.Collections.Generic;

namespace KNT.Models;

public partial class DanhMuc
{
    public int MaDanhMuc { get; set; }

    public string TenDanhMuc { get; set; } = null!;

    public string? MoTa { get; set; }

    public string? DuongDanHinh { get; set; }

    public bool DangHoatDong { get; set; }

    public DateTime NgayTao { get; set; }

    public virtual ICollection<SanPham> SanPhams { get; set; } = new List<SanPham>();
}
