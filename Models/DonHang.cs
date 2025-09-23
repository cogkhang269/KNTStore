using System;
using System.Collections.Generic;

namespace KNT.Models;

public partial class DonHang
{
    public int MaDonHang { get; set; }

    public string SoDonHang { get; set; } = null!;

    public Guid? MaNguoiDung { get; set; }

    public string TenKhachHang { get; set; } = null!;

    public string EmailKhachHang { get; set; } = null!;

    public string SoDienThoaiKhachHang { get; set; } = null!;

    public string DiaChiGiaoHang { get; set; } = null!;

    public decimal TongTien { get; set; }

    public string TrangThaiDonHang { get; set; } = null!;

    public string? PhuongThucThanhToan { get; set; }

    public DateTime NgayTao { get; set; }

    public virtual ICollection<ChiTietDonHang> ChiTietDonHangs { get; set; } = new List<ChiTietDonHang>();

    public virtual User? MaNguoiDungNavigation { get; set; }
}
