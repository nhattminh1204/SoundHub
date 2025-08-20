<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="display-6 fw-bold text-gradient mb-4">
                    <i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard
                </h2>

                <!-- Admin Menu -->
                <div class="row mb-5">
                    <div class="col-md-3 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <i class="fas fa-users fa-3x text-primary mb-3"></i>
                                <h5 class="card-title">Quản lý người dùng</h5>
                                <p class="card-text">Quản lý tài khoản người dùng</p>
                                <a href="admin-users" class="btn btn-primary">Quản lý</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <i class="fas fa-tags fa-3x text-success mb-3"></i>
                                <h5 class="card-title">Quản lý danh mục</h5>
                                <p class="card-text">Thêm, sửa, xóa danh mục</p>
                                <a href="admin-categories" class="btn btn-success">Quản lý</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <i class="fas fa-box fa-3x text-warning mb-3"></i>
                                <h5 class="card-title">Quản lý sản phẩm</h5>
                                <p class="card-text">Thêm, sửa, xóa sản phẩm</p>
                                <a href="admin-products" class="btn btn-warning text-white">Quản lý</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <div class="card text-center h-100">
                            <div class="card-body">
                                <i class="fas fa-shopping-cart fa-3x text-info mb-3"></i>
                                <h5 class="card-title">Quản lý đơn hàng</h5>
                                <p class="card-text">Xem và xử lý đơn hàng</p>
                                <a href="admin-orders" class="btn btn-info text-white">Quản lý</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Thống kê nhanh</h5>
                            </div>
                            <div class="card-body">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h3 class="text-primary">${totalProducts}</h3>
                                        <p class="text-muted">Sản phẩm</p>
                                    </div>
                                    <div class="col-4">
                                        <h3 class="text-success">${totalOrders}</h3>
                                        <p class="text-muted">Đơn hàng</p>
                                    </div>
                                    <div class="col-4">
                                        <h3 class="text-info">${totalUsers}</h3>
                                        <p class="text-muted">Người dùng</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Hành động nhanh</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="admin-products" class="btn btn-outline-primary">
                                        <i class="fas fa-plus me-2"></i>Quản lý sản phẩm
                                    </a>
                                    <a href="admin-orders" class="btn btn-outline-success">
                                        <i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>