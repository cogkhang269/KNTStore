

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'KNTStoreDB')
BEGIN
    CREATE DATABASE KNTStoreDB;
END
GO

USE KNTStoreDB;
GO

-- Tạo bảng Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
BEGIN
    CREATE TABLE Users (
        UserId uniqueidentifier PRIMARY KEY DEFAULT NEWID(),
        Email nvarchar(255) NOT NULL UNIQUE,
        PasswordHash nvarchar(255) NOT NULL,
        FullName nvarchar(100) NOT NULL,
        PhoneNumber nvarchar(15) NOT NULL,
        Address nvarchar(255),
        City nvarchar(100),
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        IsActive bit NOT NULL DEFAULT 1
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DanhMuc' AND xtype='U')
BEGIN
    CREATE TABLE DanhMuc (
        MaDanhMuc int IDENTITY(1,1) PRIMARY KEY,
        TenDanhMuc nvarchar(100) NOT NULL,
        MoTa nvarchar(500),
        DuongDanHinh nvarchar(255),
        DangHoatDong bit NOT NULL DEFAULT 1,
        NgayTao datetime2 NOT NULL DEFAULT GETDATE()
    );
END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SanPham' AND xtype='U')
BEGIN
    CREATE TABLE SanPham (
        MaSanPham int IDENTITY(1,1) PRIMARY KEY,
        TenSanPham nvarchar(200) NOT NULL,
        MoTa nvarchar(1000),
        MaSKU nvarchar(100) NOT NULL UNIQUE,
        Gia decimal(18,2) NOT NULL,
        GiaKhuyenMai decimal(18,2),
        DuongDanHinhChinh nvarchar(255),
        ThuongHieu nvarchar(100),
        SoLuongTon int NOT NULL DEFAULT 0,
        DangHoatDong bit NOT NULL DEFAULT 1,
        SanPhamNoiBat bit NOT NULL DEFAULT 0,
        NgayTao datetime2 NOT NULL DEFAULT GETDATE(),
        MaDanhMuc int NOT NULL,
        FOREIGN KEY (MaDanhMuc) REFERENCES DanhMuc(MaDanhMuc)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='HinhAnhSanPham' AND xtype='U')
BEGIN
    CREATE TABLE HinhAnhSanPham (
        MaHinhAnh int IDENTITY(1,1) PRIMARY KEY,
        MaSanPham int NOT NULL,
        DuongDanHinh nvarchar(255) NOT NULL,
        HinhChinh bit NOT NULL DEFAULT 0,
        NgayTao datetime2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham) ON DELETE CASCADE
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='GioHang' AND xtype='U')
BEGIN
    CREATE TABLE GioHang (
        MaGioHang int IDENTITY(1,1) PRIMARY KEY,
        MaNguoiDung uniqueidentifier NOT NULL,
        MaSanPham int NOT NULL,
        SoLuong int NOT NULL DEFAULT 1,
        GiaDonVi decimal(18,2) NOT NULL,
        NgayTao datetime2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (MaNguoiDung) REFERENCES Users(UserId) ON DELETE CASCADE,
        FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham) ON DELETE CASCADE,
        UNIQUE(MaNguoiDung, MaSanPham)
    );
END
GO

-- Tạo bảng DonHang
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='DonHang' AND xtype='U')
BEGIN
    CREATE TABLE DonHang (
        MaDonHang int IDENTITY(1,1) PRIMARY KEY,
        SoDonHang nvarchar(50) NOT NULL UNIQUE,
        MaNguoiDung uniqueidentifier,
        TenKhachHang nvarchar(100) NOT NULL,
        EmailKhachHang nvarchar(255) NOT NULL,
        SoDienThoaiKhachHang nvarchar(15) NOT NULL,
        DiaChiGiaoHang nvarchar(255) NOT NULL,
        TongTien decimal(18,2) NOT NULL,
        TrangThaiDonHang nvarchar(20) NOT NULL DEFAULT 'Pending',
        PhuongThucThanhToan nvarchar(50),
        NgayTao datetime2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (MaNguoiDung) REFERENCES Users(UserId) ON DELETE SET NULL
    );
END
GO

-- Tạo bảng ChiTietDonHang
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ChiTietDonHang' AND xtype='U')
BEGIN
    CREATE TABLE ChiTietDonHang (
        MaChiTietDonHang int IDENTITY(1,1) PRIMARY KEY,
        MaDonHang int NOT NULL,
        MaSanPham int NOT NULL,
        SoLuong int NOT NULL,
        GiaDonVi decimal(18,2) NOT NULL,
        TenSanPham nvarchar(200),
        FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang) ON DELETE CASCADE,
        FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
    );
END
GO

PRINT 'Database KNTStoreDB created successfully!';
PRINT 'All tables created successfully!';
