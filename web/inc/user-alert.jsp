<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!-- Login/Register Messages -->
<c:if test="${param.success == 'register'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i>Đăng ký tài khoản thành công.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.success == 'logout'}">
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'login'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>Thông tin đăng nhập không chính xác!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'register'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>Đăng ký thất bại! Vui lòng thử lại.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'duplicate'}">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>Email hoặc số điện thoại đã được sử dụng!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'session'}">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <i class="fas fa-clock me-2"></i>Phiên đăng nhập đã hết hạn! Vui lòng đăng nhập lại.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Cart Messages -->
<c:if test="${param.success == 'cart'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-shopping-cart me-2"></i>Đã thêm vào giỏ hàng!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'cart'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>Không thể thêm vào giỏ hàng!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Order Messages -->
<c:if test="${param.success == 'order'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i>Đặt hàng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'order'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>Đặt hàng thất bại! Vui lòng thử lại.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Profile Messages -->
<c:if test="${param.success == 'profile'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-user me-2"></i>Cập nhật thông tin thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${param.error == 'profile'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>Cập nhật thông tin thất bại!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>