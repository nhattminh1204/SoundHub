<%@page import="model.User"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Thanh điều hướng -->
<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background: #fff">
    <div class="container">

        <!-- Logo -->
        <a class="navbar-brand" href="home">
            <i class="fas fa-headphones"></i>
            <span>Sound Hub</span>
        </a>

        <!-- Menu chính -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath.contains('home') ? 'active' : ''}" 
                       href="home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath.contains('products') ? 'active' : ''}" 
                       href="products">
                        <i class="fas fa-box"></i>
                        <span>Sản phẩm</span>
                    </a>
                </li>
            </ul>

            <!-- FORM TÌM KIẾM -->
            <!-- Truyền dữ liệu keyword đến /search -->
            <form class="search-form mx-auto" action="search" method="get">
                <div class="input-group">
                    <input class="form-control" type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..."
                           style="border: 1.5px solid #e2e8f0; border-radius: 18px 0px 0px 18px" value="${keyword}">
                    <button class="btn" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>

            <!-- Menu bên phải -->
            <ul class="navbar-nav">
                <%
                    int cartSize = 0;
                    User user = (User) session.getAttribute("user");
                    if (user != null) {
                        data.impl.CartItemImpl cartDAO = new data.impl.CartItemImpl();
                        cartSize = cartDAO.getCartItems(user.getId()).size();
                    }
                    request.setAttribute("cartSize", cartSize);
                %>
                <c:choose>
                    <c:when test="${user == null}">
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="login">
                                <i class="fas fa-shopping-bag"></i>
                                <span>Giỏ hàng</span>
                                <c:if test="${cartSize > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${cartSize}</span>
                                </c:if>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="cart">
                                <i class="fas fa-shopping-bag"></i>
                                <span>Giỏ hàng</span>
                                <c:if test="${cartSize > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${cartSize}</span>
                                </c:if>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <!-- Nếu chưa đăng nhập -->
                <c:if test="${user == null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user"></i>
                            <span>Tài khoản</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="login">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="register">
                                    <i class="fas fa-user-plus me-2"></i>Đăng ký
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
                
                <!-- Nếu đã đăng nhập -->
                <c:if test="${user != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user"></i>
                            <span>Xin chào, ${user.splitName(user.getName())} </span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="profile">
                                    <i class="fas fa-user-circle me-2"></i>Hồ sơ
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="order-history">
                                    <i class="fas fa-history me-2"></i>Lịch sử đơn hàng
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>

        <!-- Button toggle cho mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

    </div>
</nav>
