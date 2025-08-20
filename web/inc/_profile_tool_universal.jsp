<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.list-group-item.active {
    color: white !important;
}
.user-active {
    background-color: #0d6efd !important;
    border-color: #0d6efd !important;
}
.admin-active {
    background-color: #dc3545 !important;
    border-color: #dc3545 !important;
}
.list-group-item:hover {
    background-color: #f8f9fa;
}
</style>

<div class="col-lg-3 mb-4">
    <div class="card border-0 shadow-lg rounded-4">
        <div class="card-body text-center p-4">
            <div class="position-relative mb-3">
                <c:choose>
                    <c:when test="${user.role == 'user'}">
                        <img src="${pageContext.request.contextPath}/assets/img/avatar.jpg" 
                             class="rounded-circle border border-3 border-primary" 
                             width="100" height="100" alt="Avatar" style="object-fit: cover;">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/assets/img/admin-avatar.jpg" 
                             class="rounded-circle border border-3 border-danger" 
                             width="100" height="100" alt="Avatar" style="object-fit: cover;">
                    </c:otherwise>
                </c:choose>
            </div>

            <h5 class="mb-1">${user.name}</h5>
            <p class="text-muted small mb-3">${user.email}</p>
            <div class="d-flex justify-content-center gap-2">
                <span class="badge bg-success">Đã xác thực</span>
                <c:choose>
                    <c:when test="${user.role == 'user'}">
                        <span class="badge bg-info">Thành viên</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger">Admin</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="list-group list-group-flush">
            <c:choose>
                <c:when test="${user.role == 'user'}">
                    <a href="profile" class="list-group-item list-group-item-action border-0 d-flex align-items-center ${(pageContext.request.requestURI.contains('profile') && !pageContext.request.requestURI.contains('change-password')) ? 'active user-active' : ''}">
                        <i class="fas fa-user-circle me-3 text-primary"></i>
                        <span>Thông tin cá nhân</span>
                        <i class="fas fa-chevron-right ms-auto text-muted"></i>
                    </a>
                    <a href="change-password" class="list-group-item list-group-item-action border-0 d-flex align-items-center ${pageContext.request.requestURI.contains('change-password') ? 'active user-active' : ''}">
                        <i class="fas fa-lock me-3 text-warning"></i>
                        <span>Đổi mật khẩu</span>
                        <i class="fas fa-chevron-right ms-auto text-muted"></i>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="admin-profile" class="list-group-item list-group-item-action border-0 d-flex align-items-center ${pageContext.request.requestURI.contains('admin-profile') && !pageContext.request.requestURI.contains('change-password') ? 'active admin-active' : ''}">
                        <i class="fas fa-user-circle me-3 text-danger"></i>
                        <span>Thông tin cá nhân</span>
                        <i class="fas fa-chevron-right ms-auto text-muted"></i>
                    </a>
                    <a href="admin-change-password" class="list-group-item list-group-item-action border-0 d-flex align-items-center ${pageContext.request.requestURI.contains('admin-change-password') ? 'active admin-active' : ''}">
                        <i class="fas fa-lock me-3 text-warning"></i>
                        <span>Đổi mật khẩu</span>
                        <i class="fas fa-chevron-right ms-auto text-muted"></i>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>