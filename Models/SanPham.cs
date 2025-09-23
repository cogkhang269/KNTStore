using System;
using System.Collections.Generic;

namespace KNT.Models;

public partial class SanPham
{
    public int MaSanPham { get; set; }

    public string TenSanPham { get; set; } = null!;

    public string? MoTa { get; set; }

    public string MaSku { get; set; } = null!;

    public decimal Gia { get; set; }

    public decimal? GiaKhuyenMai { get; set; }

    public string? DuongDanHinhChinh { get; set; }

    public string? ThuongHieu { get; set; }

    public int SoLuongTon { get; set; }

    public bool DangHoatDong { get; set; }

    public bool SanPhamNoiBat { get; set; }

    public DateTime NgayTao { get; set; }

    public int MaDanhMuc { get; set; }

    public virtual ICollection<ChiTietDonHang> ChiTietDonHangs { get; set; } = new List<ChiTietDonHang>();

    public virtual ICollection<GioHang> GioHangs { get; set; } = new List<GioHang>();

    public virtual ICollection<HinhAnhSanPham> HinhAnhSanPhams { get; set; } = new List<HinhAnhSanPham>();

    public virtual DanhMuc MaDanhMucNavigation { get; set; } = null!;
}
