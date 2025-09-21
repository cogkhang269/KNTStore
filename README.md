# <span style="color: #ff6b6b; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">KNT Store</span> - <span style="color: #4ecdc4; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">E-commerce Website</span>

[![.NET](https://img.shields.io/badge/.NET-8.0-blue.svg)](https://dotnet.microsoft.com/download)
[![ASP.NET Core](https://img.shields.io/badge/ASP.NET%20Core-8.0-green.svg)](https://docs.microsoft.com/en-us/aspnet/core/)
[![Entity Framework](https://img.shields.io/badge/Entity%20Framework-8.0-orange.svg)](https://docs.microsoft.com/en-us/ef/)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-red.svg)](https://www.microsoft.com/en-us/sql-server)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Tổng quan</span>

KNT Store là một website thương mại điện tử được phát triển bằng ASP.NET Core MVC, mang đến trải nghiệm mua sắm trực tuyến hoàn chỉnh với đầy đủ các chức năng cần thiết.

## <span style="color: #f093fb; background: linear-gradient(45deg, #f093fb, #f5576c); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Tính năng chính</span>

### <span style="color: #4facfe; background: linear-gradient(45deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Quản lý sản phẩm</span>
- Hiển thị danh sách sản phẩm với phân trang
- Tìm kiếm và lọc sản phẩm theo danh mục
- Chi tiết sản phẩm với hình ảnh đa dạng
- Quản lý thuộc tính sản phẩm (màu sắc, kích thước, v.v.)
- Đánh giá và bình luận sản phẩm

### <span style="color: #43e97b; background: linear-gradient(45deg, #43e97b, #38f9d7); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Quản lý người dùng</span>
- Đăng ký và đăng nhập
- Phân quyền người dùng (Admin, Customer)
- Quản lý thông tin cá nhân
- Lịch sử đơn hàng

### <span style="color: #fa709a; background: linear-gradient(45deg, #fa709a, #fee140); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Giỏ hàng và thanh toán</span>
- Thêm/sửa/xóa sản phẩm trong giỏ hàng
- Tính toán tổng tiền tự động
- Quản lý đơn hàng
- Trạng thái đơn hàng (Pending, Processing, Shipped, Delivered)

### <span style="color: #a8edea; background: linear-gradient(45deg, #a8edea, #fed6e3); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Giao diện người dùng</span>
- Responsive design cho mọi thiết bị
- Banner quảng cáo động
- Giao diện hiện đại và thân thiện
- Tối ưu hóa hình ảnh

### <span style="color: #ffecd2; background: linear-gradient(45deg, #ffecd2, #fcb69f); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Báo cáo và thống kê</span>
- Thống kê doanh thu
- Báo cáo sản phẩm bán chạy
- Phân tích người dùng

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Công nghệ sử dụng</span>

### <span style="color: #4facfe; background: linear-gradient(45deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Backend</span>
- **ASP.NET Core 6.0** - Web framework
- **Entity Framework Core 6.0** - ORM
- **SQL Server** - Database
- **C# 10** - Programming language

### <span style="color: #43e97b; background: linear-gradient(45deg, #43e97b, #38f9d7); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Frontend</span>
- **HTML5, CSS3, JavaScript** - Core web technologies
- **Bootstrap 5** - CSS framework
- **jQuery** - JavaScript library
- **Responsive Design** - Mobile-first approach

### <span style="color: #fa709a; background: linear-gradient(45deg, #fa709a, #fee140); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Tools & Libraries</span>
- **Git** - Version control
- **GitHub** - Code repository
- **Visual Studio 2022** - IDE
- **SQL Server Management Studio** - Database management

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Cài đặt và chạy dự án</span>

### <span style="color: #4facfe; background: linear-gradient(45deg, #4facfe, #00f2fe); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Yêu cầu hệ thống</span>
- Windows 10/11 hoặc macOS hoặc Linux
- .NET 6.0 SDK
- SQL Server 2019 hoặc mới hơn
- Visual Studio 2022 hoặc VS Code

### <span style="color: #43e97b; background: linear-gradient(45deg, #43e97b, #38f9d7); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Bước 1: Clone repository</span>
```bash
git clone https://github.com/cogkhang269/KNTStore.git
cd KNTStore
```

### <span style="color: #fa709a; background: linear-gradient(45deg, #fa709a, #fee140); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Bước 2: Cài đặt dependencies</span>
```bash
# Restore NuGet packages
dotnet restore

# Hoặc sử dụng Package Manager Console trong Visual Studio
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.EntityFrameworkCore.Tools
Install-Package Microsoft.EntityFrameworkCore.Design
```

### <span style="color: #a8edea; background: linear-gradient(45deg, #a8edea, #fed6e3); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Bước 3: Cấu hình database</span>
```bash
# Cập nhật connection string trong appsettings.json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=KNTStoreDB;Trusted_Connection=true;MultipleActiveResultSets=true"
  }
}
```

### <span style="color: #ffecd2; background: linear-gradient(45deg, #ffecd2, #fcb69f); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Bước 4: Tạo database</span>
```bash
# Tạo migration
dotnet ef migrations add InitialCreate

# Cập nhật database
dotnet ef database update
```

### <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Bước 5: Chạy ứng dụng</span>
```bash
# Chạy development server
dotnet run

# Hoặc sử dụng Visual Studio
# Nhấn F5 hoặc Ctrl+F5
```

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Cấu trúc dự án</span>

```
KNTStore/
├── Controllers/          # MVC Controllers
│   ├── HomeController.cs
│   ├── ProductController.cs
│   ├── AccountController.cs
│   └── AdminController.cs
├── Models/              # Data Models
│   ├── Product.cs
│   ├── User.cs
│   ├── Order.cs
│   └── Category.cs
├── Views/               # Razor Views
│   ├── Home/
│   ├── Product/
│   ├── Account/
│   └── Shared/
├── wwwroot/             # Static files
│   ├── css/
│   ├── js/
│   ├── images/
│   └── lib/
├── Data/                # Database context
│   └── KNTDbContext.cs
├── Migrations/          # EF Migrations
├── Scripts/             # SQL Scripts
├── appsettings.json     # Configuration
└── Program.cs           # Application entry point
```

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Cấu trúc Database</span>

### **Bảng chính:**
- **Users** - Thông tin người dùng
- **Categories** - Danh mục sản phẩm
- **Products** - Sản phẩm
- **ProductImages** - Hình ảnh sản phẩm
- **ProductAttributes** - Thuộc tính sản phẩm
- **CartItems** - Giỏ hàng
- **Orders** - Đơn hàng
- **OrderItems** - Chi tiết đơn hàng
- **Reviews** - Đánh giá sản phẩm
- **Banners** - Banner quảng cáo

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Cấu hình</span>

### **Connection String**
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=KNTStoreDB;Trusted_Connection=true;MultipleActiveResultSets=true"
  }
}
```

### **Environment Variables**
```bash
# Development
ASPNETCORE_ENVIRONMENT=Development

# Production
ASPNETCORE_ENVIRONMENT=Production
```

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Dữ liệu mẫu</span>

Dự án bao gồm dữ liệu mẫu để test:
- **6 danh mục sản phẩm** (Bàn phím, Chuột, Laptop, Camera, Microphone, Mouse Pad)
- **6 sản phẩm mẫu** với đầy đủ thông tin
- **3 người dùng** (1 Admin, 2 Customer)
- **4 banner quảng cáo**

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Testing</span>

```bash
# Chạy unit tests
dotnet test

# Chạy với coverage
dotnet test --collect:"XPlat Code Coverage"
```

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Performance</span>

- ✅ **Lazy Loading** - Tối ưu hóa truy vấn database
- ✅ **Caching** - Cache dữ liệu thường xuyên truy cập
- ✅ **Image Optimization** - Tối ưu hóa hình ảnh
- ✅ **Database Indexing** - Index cho các truy vấn thường xuyên

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Bảo mật</span>

- ✅ **Password Hashing** - Mã hóa mật khẩu với BCrypt
- ✅ **Input Validation** - Xác thực dữ liệu đầu vào
- ✅ **SQL Injection Prevention** - Sử dụng Entity Framework
- ✅ **XSS Protection** - Bảo vệ khỏi Cross-Site Scripting

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Deployment</span>

### **GitHub Actions CI/CD**
```yaml
name: Build and Deploy
on:
  push:
    branches: [ main ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
    - name: Build
      run: dotnet build
    - name: Test
      run: dotnet test
```

### **Azure Deployment**
```bash
# Deploy to Azure App Service
az webapp deployment source config-zip --resource-group myResourceGroup --name myAppName --src myapp.zip
```

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Documentation</span>

- [Database Setup Guide](DATABASE_SETUP_GUIDE.md)
- [Image Optimization Guide](IMAGE_OPTIMIZATION_GUIDE.md)
- [GitHub Deployment Guide](GITHUB_DEPLOYMENT_GUIDE.md)

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Đóng góp</span>

1. Fork repository
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Changelog</span>

### **v1.0.0** (2024-01-XX)
- ✅ Initial release
- ✅ Basic e-commerce functionality
- ✅ User authentication
- ✅ Product management
- ✅ Shopping cart
- ✅ Order management

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Báo lỗi</span>

Nếu bạn gặp lỗi, vui lòng:
1. Kiểm tra [Issues](https://github.com/cogkhang269/KNTStore/issues)
2. Tạo issue mới với thông tin chi tiết
3. Bao gồm steps để reproduce lỗi

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Liên hệ</span>

- **Email:** nasty.hnagk@gmail.com
- **GitHub:** [@cogkhang269](https://github.com/cogkhang269)
- **Project Link:** [https://github.com/cogkhang269/KNTStore](https://github.com/cogkhang269/KNTStore)

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">License</span>

Distributed under the MIT License. See `LICENSE` for more information.

## <span style="color: #667eea; background: linear-gradient(45deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Acknowledgments</span>

- [ASP.NET Core Documentation](https://docs.microsoft.com/en-us/aspnet/core/)
- [Entity Framework Documentation](https://docs.microsoft.com/en-us/ef/)
- [Bootstrap](https://getbootstrap.com/)
- [jQuery](https://jquery.com/)

---

<div align="center">

**Nếu dự án hữu ích, hãy cho một star!**

Made with <span style="color: #ff6b6b;">❤️</span> by [cogkhang269](https://github.com/cogkhang269)

</div>
