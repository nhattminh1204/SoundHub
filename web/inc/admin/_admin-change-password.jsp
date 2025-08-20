<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container py-5">
    <div class="row g-4">
        <c:import url="/inc/admin/_admin_profile_tool.jsp" />

        <div class="col-lg-9">
            <div class="card border-0 shadow-lg rounded-4">
                <div class="card-header bg-primary text-white rounded-top-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-lock fa-2x me-3"></i>
                        <h4 class="mb-0 text-white">Đổi Mật Khẩu Admin</h4>
                    </div>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty sessionScope.password_error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${sessionScope.password_error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="password_error" scope="session" />
                    </c:if>
                    
                    <c:if test="${not empty sessionScope.password_success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            ${sessionScope.password_success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="password_success" scope="session" />
                    </c:if>
                    
                    <form action="admin-change-password" method="post" novalidate>
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Mật khẩu hiện tại <span style="color: red">*</span></label>
                            <div class="input-group">
                                <input name="currentPassword" type="password" class="form-control" id="currentPassword" required
                                       placeholder="Nhập mật khẩu hiện tại">
                                <button class="btn btn-outline-secondary" type="button" 
                                        onclick="togglePasswordVisibility('currentPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Mật khẩu mới <span style="color: red">*</span></label>
                            <div class="input-group">
                                <input name="newPassword" type="password" class="form-control" id="newPassword" required 
                                       placeholder="Ít nhất 6 ký tự, có chữ hoa, chữ thường và số">
                                <button class="btn btn-outline-secondary" type="button" 
                                        onclick="togglePasswordVisibility('newPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="form-text">
                                <small id="passwordStrength"></small>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Xác nhận mật khẩu mới <span style="color: red">*</span></label>
                            <div class="input-group">
                                <input name="confirmNewPassword" type="password" class="form-control" id="confirmNewPassword" required
                                       placeholder="Nhập lại mật khẩu mới">
                                <button class="btn btn-outline-secondary" type="button" 
                                        onclick="togglePasswordVisibility('confirmNewPassword', this)">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="admin-profile" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-key me-2"></i>Đổi Mật Khẩu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function togglePasswordVisibility(inputId, button) {
    const input = document.getElementById(inputId);
    const icon = button.querySelector('i');
    
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

document.getElementById('newPassword').addEventListener('input', function() {
    const password = this.value;
    const strengthDiv = document.getElementById('passwordStrength');
    
    if (password.length === 0) {
        strengthDiv.textContent = '';
        return;
    }
    
    let strength = 0;
    if (password.length >= 6) strength++;
    if (/[a-z]/.test(password)) strength++;
    if (/[A-Z]/.test(password)) strength++;
    if (/\d/.test(password)) strength++;
    
    const levels = ['Rất yếu', 'Yếu', 'Trung bình', 'Mạnh'];
    const colors = ['text-danger', 'text-warning', 'text-info', 'text-success'];
    
    strengthDiv.textContent = 'Độ mạnh: ' + levels[strength - 1];
    strengthDiv.className = 'form-text ' + colors[strength - 1];
});
</script>