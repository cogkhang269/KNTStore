# 🗄️ Hướng dẫn thiết lập Cơ sở dữ liệu KNT Store

## 📋 **Tổng quan**
Cơ sở dữ liệu được thiết kế cho website thương mại điện tử KNT Store với đầy đủ các tính năng:
- 👥 Quản lý người dùng
- 📦 Quản lý sản phẩm và danh mục
- 🛒 Giỏ hàng và đơn hàng
- ⭐ Đánh giá sản phẩm
- 🎯 Banner quảng cáo
- 📊 Báo cáo và thống kê

## 🏗️ **Cấu trúc Database**

### **Bảng chính:**
1. **Users** - Người dùng
2. **Categories** - Danh mục sản phẩm
3. **Products** - Sản phẩm
4. **ProductImages** - Hình ảnh sản phẩm
5. **ProductAttributes** - Thuộc tính sản phẩm
6. **CartItems** - Giỏ hàng
7. **Orders** - Đơn hàng
8. **OrderItems** - Chi tiết đơn hàng
9. **Reviews** - Đánh giá sản phẩm
10. **Banners** - Banner quảng cáo

## 🚀 **Cách thiết lập**

### **Bước 1: Cài đặt Entity Framework**
```bash
# Mở Package Manager Console trong Visual Studio
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.EntityFrameworkCore.Tools
Install-Package Microsoft.EntityFrameworkCore.Design
```

### **Bước 2: Tạo Database bằng SQL Script**
```sql
-- Chạy file Scripts/CreateDatabase.sql trong SQL Server Management Studio
-- Hoặc sử dụng Azure Data Studio
```

### **Bước 3: Thêm dữ liệu mẫu**
```sql
-- Chạy file Scripts/SeedData.sql để thêm dữ liệu mẫu
```

### **Bước 4: Sử dụng Entity Framework Migrations (Tùy chọn)**
```bash
# Tạo migration đầu tiên
Add-Migration InitialCreate

# Cập nhật database
Update-Database
```

## 📊 **Dữ liệu mẫu được tạo**

### **Categories (6 danh mục):**
- Bàn phím
- Chuột
- Laptop
- Camera
- Microphone
- Mouse Pad

### **Products (6 sản phẩm):**
- Bàn phím cơ Logitech G Pro X
- Chuột gaming Razer DeathAdder V3
- Laptop Gaming ASUS ROG Strix G15
- Webcam Logitech C920 HD Pro
- Microphone Blue Yeti USB
- Bàn di chuột SteelSeries QcK+

### **Users (3 người dùng):**
- admin@kntstore.com (Admin)
- customer1@email.com (Khách hàng)
- customer2@email.com (Khách hàng)

### **Banners (4 banner):**
- Banner chính trang chủ
- Deal hot
- Sản phẩm mới
- Gaming gear

## 🔧 **Cấu hình Connection String**

### **appsettings.json:**
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=KNTStoreDB;Trusted_Connection=true;MultipleActiveResultSets=true"
  }
}
```

### **Các loại Connection String khác:**

#### **SQL Server Local:**
```json
"DefaultConnection": "Server=localhost;Database=KNTStoreDB;Trusted_Connection=true;MultipleActiveResultSets=true"
```

#### **SQL Server với Username/Password:**
```json
"DefaultConnection": "Server=localhost;Database=KNTStoreDB;User Id=sa;Password=YourPassword;MultipleActiveResultSets=true"
```

#### **Azure SQL Database:**
```json
"DefaultConnection": "Server=tcp:yourserver.database.windows.net,1433;Initial Catalog=KNTStoreDB;Persist Security Info=False;User ID=yourusername;Password=yourpassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
```

## 📝 **Sử dụng trong Code**

### **1. Inject DbContext vào Controller:**
```csharp
public class ProductController : Controller
{
    private readonly KNTDbContext _context;

    public ProductController(KNTDbContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var products = await _context.Products
            .Include(p => p.Category)
            .Include(p => p.ProductImages)
            .Where(p => p.IsActive)
            .ToListAsync();
        
        return View(products);
    }
}
```

### **2. CRUD Operations:**
```csharp
// Create
var product = new Product
{
    Name = "Sản phẩm mới",
    Price = 1000000,
    CategoryId = 1
};
_context.Products.Add(product);
await _context.SaveChangesAsync();

// Read
var product = await _context.Products.FindAsync(id);

// Update
product.Name = "Tên mới";
await _context.SaveChangesAsync();

// Delete
_context.Products.Remove(product);
await _context.SaveChangesAsync();
```

### **3. Complex Queries:**
```csharp
// Lấy sản phẩm với đánh giá
var productsWithReviews = await _context.Products
    .Include(p => p.Reviews)
    .Include(p => p.Category)
    .Where(p => p.IsActive && p.Reviews.Any())
    .OrderByDescending(p => p.Rating)
    .ToListAsync();

// Lấy đơn hàng của user
var userOrders = await _context.Orders
    .Include(o => o.OrderItems)
    .ThenInclude(oi => oi.Product)
    .Where(o => o.UserId == userId)
    .OrderByDescending(o => o.CreatedAt)
    .ToListAsync();
```

## 🔍 **Queries hữu ích**

### **1. Thống kê sản phẩm:**
```sql
-- Sản phẩm bán chạy nhất
SELECT TOP 10 p.Name, p.SoldCount, p.Price
FROM Products p
WHERE p.IsActive = 1
ORDER BY p.SoldCount DESC;

-- Sản phẩm có đánh giá cao nhất
SELECT TOP 10 p.Name, p.Rating, p.ReviewCount
FROM Products p
WHERE p.IsActive = 1 AND p.Rating > 0
ORDER BY p.Rating DESC, p.ReviewCount DESC;
```

### **2. Thống kê đơn hàng:**
```sql
-- Doanh thu theo tháng
SELECT 
    YEAR(CreatedAt) as Year,
    MONTH(CreatedAt) as Month,
    COUNT(*) as OrderCount,
    SUM(TotalAmount) as TotalRevenue
FROM Orders
WHERE OrderStatus = 'Delivered'
GROUP BY YEAR(CreatedAt), MONTH(CreatedAt)
ORDER BY Year DESC, Month DESC;

-- Top khách hàng
SELECT 
    u.FullName,
    u.Email,
    COUNT(o.OrderId) as OrderCount,
    SUM(o.TotalAmount) as TotalSpent
FROM Users u
JOIN Orders o ON u.UserId = o.UserId
WHERE o.OrderStatus = 'Delivered'
GROUP BY u.UserId, u.FullName, u.Email
ORDER BY TotalSpent DESC;
```

## 🛡️ **Bảo mật**

### **1. Password Hashing:**
```csharp
// Sử dụng BCrypt hoặc ASP.NET Core Identity
using BCrypt.Net;

public string HashPassword(string password)
{
    return BCrypt.HashPassword(password);
}

public bool VerifyPassword(string password, string hash)
{
    return BCrypt.Verify(password, hash);
}
```

### **2. Input Validation:**
```csharp
[Required]
[StringLength(200)]
public string Name { get; set; }

[Range(0, double.MaxValue)]
public decimal Price { get; set; }
```

## 📈 **Performance Optimization**

### **1. Indexing:**
```sql
-- Tạo index cho các trường thường xuyên query
CREATE INDEX IX_Products_CategoryId ON Products(CategoryId);
CREATE INDEX IX_Products_IsActive ON Products(IsActive);
CREATE INDEX IX_Orders_UserId ON Orders(UserId);
CREATE INDEX IX_Orders_CreatedAt ON Orders(CreatedAt);
```

### **2. Lazy Loading:**
```csharp
// Tắt lazy loading để tránh N+1 problem
protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
{
    optionsBuilder.UseLazyLoadingProxies(false);
}
```

## 🔄 **Backup và Restore**

### **Backup:**
```sql
BACKUP DATABASE KNTStoreDB 
TO DISK = 'C:\Backup\KNTStoreDB.bak'
WITH FORMAT, INIT;
```

### **Restore:**
```sql
RESTORE DATABASE KNTStoreDB 
FROM DISK = 'C:\Backup\KNTStoreDB.bak'
WITH REPLACE;
```

## 🚨 **Troubleshooting**

### **Lỗi thường gặp:**

1. **Connection String không đúng:**
   - Kiểm tra tên server
   - Kiểm tra tên database
   - Kiểm tra authentication

2. **Migration conflicts:**
   ```bash
   Remove-Migration
   Add-Migration NewMigration
   Update-Database
   ```

3. **Foreign Key constraints:**
   - Kiểm tra dữ liệu trước khi xóa
   - Sử dụng CASCADE hoặc SET NULL

## 📞 **Hỗ trợ**

Nếu gặp vấn đề, hãy kiểm tra:
1. Connection string trong appsettings.json
2. SQL Server service đang chạy
3. Database đã được tạo
4. User có quyền truy cập database

---
*Hướng dẫn này được tạo cho dự án KNT Store. Hãy tùy chỉnh theo nhu cầu cụ thể của bạn!*
