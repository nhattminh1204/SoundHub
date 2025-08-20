<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.list-group-item.active {
    background-color: #0d6efd !important;
    border-color: #0d6efd !important;
    color: white !important;
}

.list-group-item:hover {
    background-color: #f8f9fa;
}
</style>

<div class="col-lg-3 mb-4">
    <div class="card border-0 shadow-lg rounded-4">
        <div class="card-body text-center p-4">
            <div class="position-relative mb-3">
                <img src="${pageContext.request.contextPath}/assets/img/avatar.jpg" 
                     class="rounded-circle border border-3 border-primary" 
                     width="100" height="100" alt="Avatar" id="avatarImage">

                <div class="position-absolute top-0 end-0">
                    <input type="file" id="avatarInput" class="d-none" accept="image/*">
                    <button type="button"
                            class="btn btn-primary d-flex align-items-center justify-content-center p-0 rounded-circle"
                            style="width: 35px; height: 35px;"
                            onclick="document.getElementById('avatarInput').click()">
                        <i class="fas fa-camera"></i>
                    </button>
                </div>
            </div>

            <h5 class="mb-1">${user.name}</h5>
            <p class="text-muted small mb-3">${user.email}</p>
            <div class="d-flex justify-content-center gap-2">
                <span class="badge bg-success">Đã xác thực</span>
                <span class="badge bg-info">
                    ${user.role == 'user' ? 'Thành viên' : 'Administrator'}
                </span>
            </div>
        </div>

        <div class="list-group list-group-flush">
            <a href="profile" class="list-group-item list-group-item-action border-0 d-flex align-items-center ${pageContext.request.requestURI.contains('profile') && !pageContext.request.requestURI.contains('change-password') ? 'active' : ''}">
                <i class="fas fa-user-circle me-3 text-primary"></i>
                <span>Thông tin cá nhân</span>
                <i class="fas fa-chevron-right ms-auto text-muted"></i>
            </a>
            <a href="change-password" class="list-group-item list-group-item-action border-0 d-flex align-items-center ${pageContext.request.requestURI.contains('change-password') ? 'active' : ''}">
                <i class="fas fa-lock me-3 text-warning"></i>
                <span>Đổi mật khẩu</span>
                <i class="fas fa-chevron-right ms-auto text-muted"></i>
            </a>
        </div>
    </div>
</div>