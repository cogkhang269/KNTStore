-- Script tạo cơ sở dữ liệu KNT Store
-- Chạy script này để tạo database và các bảng

USE master;
GO

-- Tạo database nếu chưa tồn tại
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
        UserId int IDENTITY(1,1) PRIMARY KEY,
        Username nvarchar(100) NOT NULL UNIQUE,
        Email nvarchar(255) NOT NULL UNIQUE,
        PasswordHash nvarchar(255) NOT NULL,
        FullName nvarchar(100),
        PhoneNumber nvarchar(15),
        Address nvarchar(255),
        City nvarchar(100),
        PostalCode nvarchar(10),
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        UpdatedAt datetime2,
        IsActive bit NOT NULL DEFAULT 1,
        IsEmailVerified bit NOT NULL DEFAULT 0
    );
END
GO

-- Tạo bảng Categories
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Categories' AND xtype='U')
BEGIN
    CREATE TABLE Categories (
        CategoryId int IDENTITY(1,1) PRIMARY KEY,
        Name nvarchar(100) NOT NULL,
        Description nvarchar(500),
        ImageUrl nvarchar(255),
        Slug nvarchar(100) UNIQUE,
        ParentCategoryId int,
        DisplayOrder int NOT NULL DEFAULT 0,
        IsActive bit NOT NULL DEFAULT 1,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (ParentCategoryId) REFERENCES Categories(CategoryId)
    );
END
GO

-- Tạo bảng Products
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Products' AND xtype='U')
BEGIN
    CREATE TABLE Products (
        ProductId int IDENTITY(1,1) PRIMARY KEY,
        Name nvarchar(200) NOT NULL,
        Description nvarchar(1000),
        LongDescription nvarchar(2000),
        SKU nvarchar(100) NOT NULL UNIQUE,
        Price decimal(18,2) NOT NULL,
        SalePrice decimal(18,2),
        CostPrice decimal(18,2),
        MainImageUrl nvarchar(255),
        Brand nvarchar(100),
        Model nvarchar(50),
        Color nvarchar(20),
        Size nvarchar(20),
        Weight nvarchar(100),
        Dimensions nvarchar(100),
        StockQuantity int NOT NULL DEFAULT 0,
        MinStockLevel int NOT NULL DEFAULT 5,
        TrackStock bit NOT NULL DEFAULT 1,
        IsActive bit NOT NULL DEFAULT 1,
        IsFeatured bit NOT NULL DEFAULT 0,
        IsNew bit NOT NULL DEFAULT 0,
        IsOnSale bit NOT NULL DEFAULT 0,
        Rating decimal(3,2) DEFAULT 0,
        ReviewCount int NOT NULL DEFAULT 0,
        ViewCount int NOT NULL DEFAULT 0,
        SoldCount int NOT NULL DEFAULT 0,
        Slug nvarchar(100) UNIQUE,
        MetaTitle nvarchar(500),
        MetaDescription nvarchar(1000),
        MetaKeywords nvarchar(1000),
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        UpdatedAt datetime2,
        CategoryId int NOT NULL,
        FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
    );
END
GO

-- Tạo bảng ProductImages
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ProductImages' AND xtype='U')
BEGIN
    CREATE TABLE ProductImages (
        ProductImageId int IDENTITY(1,1) PRIMARY KEY,
        ProductId int NOT NULL,
        ImageUrl nvarchar(255) NOT NULL,
        ThumbnailUrl nvarchar(255),
        AltText nvarchar(100),
        Title nvarchar(200),
        DisplayOrder int NOT NULL DEFAULT 0,
        IsMain bit NOT NULL DEFAULT 0,
        IsActive bit NOT NULL DEFAULT 1,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE
    );
END
GO

-- Tạo bảng ProductAttributes
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ProductAttributes' AND xtype='U')
BEGIN
    CREATE TABLE ProductAttributes (
        ProductAttributeId int IDENTITY(1,1) PRIMARY KEY,
        ProductId int NOT NULL,
        AttributeName nvarchar(100) NOT NULL,
        AttributeValue nvarchar(500) NOT NULL,
        AttributeType nvarchar(50),
        DisplayOrder int NOT NULL DEFAULT 0,
        IsActive bit NOT NULL DEFAULT 1,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE
    );
END
GO

-- Tạo bảng CartItems
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CartItems' AND xtype='U')
BEGIN
    CREATE TABLE CartItems (
        CartItemId int IDENTITY(1,1) PRIMARY KEY,
        UserId int NOT NULL,
        ProductId int NOT NULL,
        Quantity int NOT NULL DEFAULT 1,
        UnitPrice decimal(18,2) NOT NULL,
        TotalPrice decimal(18,2) NOT NULL,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        UpdatedAt datetime2,
        FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
        FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE,
        UNIQUE(UserId, ProductId)
    );
END
GO

-- Tạo bảng Orders
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Orders' AND xtype='U')
BEGIN
    CREATE TABLE Orders (
        OrderId int IDENTITY(1,1) PRIMARY KEY,
        OrderNumber nvarchar(50) NOT NULL UNIQUE,
        UserId int,
        CustomerName nvarchar(100) NOT NULL,
        CustomerEmail nvarchar(255) NOT NULL,
        CustomerPhone nvarchar(15) NOT NULL,
        ShippingAddress nvarchar(255) NOT NULL,
        City nvarchar(100),
        PostalCode nvarchar(10),
        Notes nvarchar(100),
        SubTotal decimal(18,2) NOT NULL,
        TaxAmount decimal(18,2) NOT NULL DEFAULT 0,
        ShippingCost decimal(18,2) NOT NULL DEFAULT 0,
        DiscountAmount decimal(18,2) NOT NULL DEFAULT 0,
        TotalAmount decimal(18,2) NOT NULL,
        OrderStatus nvarchar(20) NOT NULL DEFAULT 'Pending',
        PaymentStatus nvarchar(20) NOT NULL DEFAULT 'Pending',
        PaymentMethod nvarchar(50),
        PaymentReference nvarchar(100),
        TrackingNumber nvarchar(100),
        ShippedDate datetime2,
        DeliveredDate datetime2,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        UpdatedAt datetime2,
        FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE SET NULL
    );
END
GO

-- Tạo bảng OrderItems
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OrderItems' AND xtype='U')
BEGIN
    CREATE TABLE OrderItems (
        OrderItemId int IDENTITY(1,1) PRIMARY KEY,
        OrderId int NOT NULL,
        ProductId int NOT NULL,
        Quantity int NOT NULL,
        UnitPrice decimal(18,2) NOT NULL,
        TotalPrice decimal(18,2) NOT NULL,
        ProductName nvarchar(200),
        ProductSKU nvarchar(100),
        ProductImageUrl nvarchar(255),
        FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE,
        FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
    );
END
GO

-- Tạo bảng Reviews
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reviews' AND xtype='U')
BEGIN
    CREATE TABLE Reviews (
        ReviewId int IDENTITY(1,1) PRIMARY KEY,
        UserId int NOT NULL,
        ProductId int NOT NULL,
        OrderId int,
        Rating int NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
        Comment nvarchar(1000),
        Title nvarchar(200),
        IsVerified bit NOT NULL DEFAULT 0,
        IsApproved bit NOT NULL DEFAULT 0,
        IsActive bit NOT NULL DEFAULT 1,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        UpdatedAt datetime2,
        FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
        FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE,
        FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE SET NULL,
        UNIQUE(UserId, ProductId)
    );
END
GO

-- Tạo bảng Banners
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Banners' AND xtype='U')
BEGIN
    CREATE TABLE Banners (
        BannerId int IDENTITY(1,1) PRIMARY KEY,
        Title nvarchar(200) NOT NULL,
        Description nvarchar(500),
        ImageUrl nvarchar(255) NOT NULL,
        ThumbnailUrl nvarchar(255),
        VideoUrl nvarchar(255),
        LinkUrl nvarchar(255),
        ButtonText nvarchar(100),
        BannerType nvarchar(20) NOT NULL DEFAULT 'Image',
        Position nvarchar(50) NOT NULL DEFAULT 'Homepage',
        DisplayOrder int NOT NULL DEFAULT 0,
        IsActive bit NOT NULL DEFAULT 1,
        StartDate datetime2 NOT NULL DEFAULT GETDATE(),
        EndDate datetime2,
        CreatedAt datetime2 NOT NULL DEFAULT GETDATE(),
        UpdatedAt datetime2
    );
END
GO

PRINT 'Database KNTStoreDB created successfully!';
PRINT 'All tables created successfully!';
