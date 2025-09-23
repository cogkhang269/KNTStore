using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace KNT.Models;

public partial class KntstoreDbContext : DbContext
{
    public KntstoreDbContext()
    {
    }

    public KntstoreDbContext(DbContextOptions<KntstoreDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<ChiTietDonHang> ChiTietDonHangs { get; set; }

    public virtual DbSet<DanhMuc> DanhMucs { get; set; }

    public virtual DbSet<DonHang> DonHangs { get; set; }

    public virtual DbSet<GioHang> GioHangs { get; set; }

    public virtual DbSet<HinhAnhSanPham> HinhAnhSanPhams { get; set; }

    public virtual DbSet<SanPham> SanPhams { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=DESKTOP-9DCLD5S;Database=KNTStoreDB;User Id=sa;Password=demo123;Trust Server Certificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ChiTietDonHang>(entity =>
        {
            entity.HasKey(e => e.MaChiTietDonHang).HasName("PK__ChiTietD__4B0B45DD2504903C");

            entity.ToTable("ChiTietDonHang");

            entity.Property(e => e.GiaDonVi).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TenSanPham).HasMaxLength(200);

            entity.HasOne(d => d.MaDonHangNavigation).WithMany(p => p.ChiTietDonHangs)
                .HasForeignKey(d => d.MaDonHang)
                .HasConstraintName("FK__ChiTietDo__MaDon__59FA5E80");

            entity.HasOne(d => d.MaSanPhamNavigation).WithMany(p => p.ChiTietDonHangs)
                .HasForeignKey(d => d.MaSanPham)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ChiTietDo__MaSan__5AEE82B9");
        });

        modelBuilder.Entity<DanhMuc>(entity =>
        {
            entity.HasKey(e => e.MaDanhMuc).HasName("PK__DanhMuc__B37508877BFDC363");

            entity.ToTable("DanhMuc");

            entity.Property(e => e.DangHoatDong).HasDefaultValue(true);
            entity.Property(e => e.DuongDanHinh).HasMaxLength(255);
            entity.Property(e => e.MoTa).HasMaxLength(500);
            entity.Property(e => e.NgayTao).HasDefaultValueSql("(getdate())");
            entity.Property(e => e.TenDanhMuc).HasMaxLength(100);
        });

        modelBuilder.Entity<DonHang>(entity =>
        {
            entity.HasKey(e => e.MaDonHang).HasName("PK__DonHang__129584ADD8E1C4CF");

            entity.ToTable("DonHang");

            entity.HasIndex(e => e.SoDonHang, "UQ__DonHang__4A22B7ACEF0A8767").IsUnique();

            entity.Property(e => e.DiaChiGiaoHang).HasMaxLength(255);
            entity.Property(e => e.EmailKhachHang).HasMaxLength(255);
            entity.Property(e => e.NgayTao).HasDefaultValueSql("(getdate())");
            entity.Property(e => e.PhuongThucThanhToan).HasMaxLength(50);
            entity.Property(e => e.SoDienThoaiKhachHang).HasMaxLength(15);
            entity.Property(e => e.SoDonHang).HasMaxLength(50);
            entity.Property(e => e.TenKhachHang).HasMaxLength(100);
            entity.Property(e => e.TongTien).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TrangThaiDonHang)
                .HasMaxLength(20)
                .HasDefaultValue("Pending");

            entity.HasOne(d => d.MaNguoiDungNavigation).WithMany(p => p.DonHangs)
                .HasForeignKey(d => d.MaNguoiDung)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__DonHang__MaNguoi__571DF1D5");
        });

        modelBuilder.Entity<GioHang>(entity =>
        {
            entity.HasKey(e => e.MaGioHang).HasName("PK__GioHang__F5001DA3801110CB");

            entity.ToTable("GioHang");

            entity.HasIndex(e => new { e.MaNguoiDung, e.MaSanPham }, "UQ__GioHang__0A95A32198E36B8C").IsUnique();

            entity.Property(e => e.GiaDonVi).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.NgayTao).HasDefaultValueSql("(getdate())");
            entity.Property(e => e.SoLuong).HasDefaultValue(1);

            entity.HasOne(d => d.MaNguoiDungNavigation).WithMany(p => p.GioHangs)
                .HasForeignKey(d => d.MaNguoiDung)
                .HasConstraintName("FK__GioHang__MaNguoi__5070F446");

            entity.HasOne(d => d.MaSanPhamNavigation).WithMany(p => p.GioHangs)
                .HasForeignKey(d => d.MaSanPham)
                .HasConstraintName("FK__GioHang__MaSanPh__5165187F");
        });

        modelBuilder.Entity<HinhAnhSanPham>(entity =>
        {
            entity.HasKey(e => e.MaHinhAnh).HasName("PK__HinhAnhS__A9C37A9B17378C87");

            entity.ToTable("HinhAnhSanPham");

            entity.Property(e => e.DuongDanHinh).HasMaxLength(255);
            entity.Property(e => e.NgayTao).HasDefaultValueSql("(getdate())");

            entity.HasOne(d => d.MaSanPhamNavigation).WithMany(p => p.HinhAnhSanPhams)
                .HasForeignKey(d => d.MaSanPham)
                .HasConstraintName("FK__HinhAnhSa__MaSan__4AB81AF0");
        });

        modelBuilder.Entity<SanPham>(entity =>
        {
            entity.HasKey(e => e.MaSanPham).HasName("PK__SanPham__FAC7442D40D9B6C6");

            entity.ToTable("SanPham");

            entity.HasIndex(e => e.MaSku, "UQ__SanPham__318FCC49B4FFFFBD").IsUnique();

            entity.Property(e => e.DangHoatDong).HasDefaultValue(true);
            entity.Property(e => e.DuongDanHinhChinh).HasMaxLength(255);
            entity.Property(e => e.Gia).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.GiaKhuyenMai).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.MaSku)
                .HasMaxLength(100)
                .HasColumnName("MaSKU");
            entity.Property(e => e.MoTa).HasMaxLength(1000);
            entity.Property(e => e.NgayTao).HasDefaultValueSql("(getdate())");
            entity.Property(e => e.TenSanPham).HasMaxLength(200);
            entity.Property(e => e.ThuongHieu).HasMaxLength(100);

            entity.HasOne(d => d.MaDanhMucNavigation).WithMany(p => p.SanPhams)
                .HasForeignKey(d => d.MaDanhMuc)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__SanPham__MaDanhM__45F365D3");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__1788CC4C6F105CF9");

            entity.HasIndex(e => e.Email, "UQ__Users__A9D105349F08F564").IsUnique();

            entity.Property(e => e.UserId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.Address).HasMaxLength(255);
            entity.Property(e => e.City).HasMaxLength(100);
            entity.Property(e => e.CreatedAt).HasDefaultValueSql("(getdate())");
            entity.Property(e => e.Email).HasMaxLength(255);
            entity.Property(e => e.FullName).HasMaxLength(100);
            entity.Property(e => e.IsActive).HasDefaultValue(true);
            entity.Property(e => e.PasswordHash).HasMaxLength(255);
            entity.Property(e => e.PhoneNumber).HasMaxLength(15);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
