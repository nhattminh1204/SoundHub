<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.navbar-dark .navbar-nav .nav-link.active {
    background-color: rgba(255,255,255,0.2) !important;
    border-radius: 5px;
    color: #fff !important;
}
</style>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'admin'}">
                <a class="navbar-brand fw-bold" href="admin-dashboard"
                   style="margin-left: 30px ">
                    <i class="fas fa-shield-alt me-2"></i>SoundHub Admin
                </a>
            </c:when>
            <c:otherwise>
                <a class="navbar-brand fw-bold" href="home">
                    <i class="fas fa-headphones me-2"></i>SoundHub
                </a>
            </c:otherwise>
        </c:choose>
        
        <!-- Menu chính ở giữa -->
        <c:if test="${sessionScope.user.role == 'admin'}">
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- Debug: ${pageContext.request.requestURI} -->
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link ${'admin-dashboard' == param.page || pageContext.request.requestURI.endsWith('admin-dashboard') ? 'active bg-primary' : ''}" href="admin-dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${'admin-products' == param.page || pageContext.request.requestURI.contains('product') ? 'active bg-primary' : ''}" href="admin-products">
                            <i class="fas fa-box me-1"></i>Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${'admin-categories' == param.page || pageContext.request.requestURI.contains('categor') ? 'active bg-primary' : ''}" href="admin-categories">
                            <i class="fas fa-tags me-1"></i>Danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${'admin-users' == param.page || pageContext.request.requestURI.contains('user') ? 'active bg-primary' : ''}" href="admin-users">
                            <i class="fas fa-users me-1"></i>Người dùng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${'admin-orders' == param.page || pageContext.request.requestURI.contains('order') ? 'active bg-primary' : ''}" href="admin-orders">
                            <i class="fas fa-shopping-cart me-1"></i>Đơn hàng
                        </a>
                    </li>
                </ul>
            </div>
        </c:if>
        
        <!-- User dropdown bên phải -->
        <div class="navbar-nav ms-auto">
            <div class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user-circle me-1"></i>
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'admin'}">Admin</c:when>
                        <c:otherwise>${sessionScope.user.name}</c:otherwise>
                    </c:choose>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'admin'}">
                            <li><a class="dropdown-item" href="admin-profile"><i class="fas fa-user me-2"></i>Hồ sơ Admin</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a class="dropdown-item" href="profile"><i class="fas fa-user me-2"></i>Hồ sơ</a></li>
                            <li><a class="dropdown-item" href="cart"><i class="fas fa-shopping-cart me-2"></i>Giỏ hàng</a></li>
                            <li><a class="dropdown-item" href="orders"><i class="fas fa-list me-2"></i>Đơn hàng</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        </div>
        
        <!-- Toggle button cho mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>