# SoundHub - Audio Equipment E-commerce

## Tính năng chính

### User Features
- **Đăng ký/Đăng nhập** với validation BCrypt
- **Trang chủ** hiển thị sản phẩm theo danh mục
- **Tìm kiếm** sản phẩm
- **Giỏ hàng** session-based
- **Thanh toán** COD/Chuyển khoản
- **Hồ sơ** cá nhân

### Admin Features  
- **Dashboard** thống kê
- **Quản lý sản phẩm** CRUD
- **Quản lý người dùng** CRUD + đổi role
- **Xem/đổi mật khẩu** user
- **Dark navbar** riêng biệt

### Security
- **BCrypt** password hashing
- **Regex validation** email/phone/password
- **Session management**
- **Error handling** toàn diện

## Cấu trúc

```
src/java/
├── controller/     # Servlets
├── data/
│   ├── dao/       # Interfaces
│   ├── impl/      # Implementations  
│   ├── driver/    # MySQL connection
│   └── utils/     # BCrypt, Validation
└── model/         # POJOs

web/
├── views/         # JSP pages
├── inc/           # Includes
├── assets/        # CSS/Images
└── js/           # JavaScript
```

## Database Tables
- users (id, name, email, phone, password, role)
- products (id, name, image, price, quantity, status, category_id)
- categories (id, name)

## URLs
- `/` - Home
- `/login` - Đăng nhập
- `/register` - Đăng ký  
- `/cart` - Giỏ hàng
- `/checkout` - Thanh toán
- `/admin-dashboard` - Admin
- `/admin-products` - Quản lý sản phẩm
- `/admin-users` - Quản lý user