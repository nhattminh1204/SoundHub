<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="form-container shadow-custom">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-plus fa-4x text-success mb-3"></i>
                        <h2 class="text-gradient">Đăng Ký Tài Khoản</h2>
                        <p class="text-muted">Tạo tài khoản để trải nghiệm mua sắm tuyệt vời</p>
                    </div>

                    <form id="registerForm" method="post" action="register" novalidate>
                        <div class="mb-3">
                            <label for="name" class="form-label">
                                <i class="fas fa-user me-2"></i>Họ tên
                            </label>
                            <input type="text" class="form-control ${err_name != null ? 'is-invalid' : ''}" 
                                   id="name" name="name" value="${form_name != null ? form_name : param.name}" required>
                            <c:if test="${err_name != null}">
                                <div class="invalid-feedback d-block">${err_name}</div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-2"></i>Email
                            </label>
                            <input type="email" class="form-control ${err_email != null ? 'is-invalid' : ''}" 
                                   id="email" name="email" value="${form_email != null ? form_email : param.email}" required>
                            <c:if test="${err_email != null}">
                                <div class="invalid-feedback d-block">${err_email}</div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone me-2"></i>Số điện thoại
                            </label>
                            <input type="tel" class="form-control ${err_phone != null ? 'is-invalid' : ''}" 
                                   id="phone" name="phone" value="${form_phone != null ? form_phone : param.phone}" pattern="[0-9]{10,11}" required>
                            <c:if test="${err_phone != null}">
                                <div class="invalid-feedback d-block">${err_phone}</div>
                            </c:if>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-2"></i>Mật khẩu
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control ${err_password != null ? 'is-invalid' : ''}" 
                                           id="password" name="password" minlength="6" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password')">
                                        <i class="fas fa-eye" id="passwordIcon"></i>
                                    </button>
                                </div>
                                <c:if test="${err_password != null}">
                                    <div class="invalid-feedback d-block">${err_password}</div>
                                </c:if>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                        <i class="fas fa-eye" id="confirmPasswordIcon"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback">Mật khẩu xác nhận không khớp.</div>
                            </div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                            <label class="form-check-label" for="agreeTerms">
                                Tôi đồng ý với <a href="#" class="text-decoration-none">Điều khoản dịch vụ</a> và <a href="#" class="text-decoration-none">Chính sách bảo mật</a>
                            </label>
                            <div class="invalid-feedback">Bạn phải đồng ý với điều khoản để tiếp tục.</div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="newsletter">
                            <label class="form-check-label" for="newsletter">
                                Nhận thông tin khuyến mãi qua email
                            </label>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-success btn-lg btn-custom">
                                <i class="fas fa-user-plus me-2"></i>Đăng Ký
                            </button>
                        </div>

                        <hr>

                        <div class="text-center">
                            <p class="mb-2">Đã có tài khoản?</p>
                            <a href="login" class="btn btn-outline-primary btn-custom">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập Ngay
                            </a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</section>

<script>
// Xóa lỗi khỏi session sau khi hiển thị
<c:if test="${err_name != null || err_email != null || err_phone != null || err_password != null}">
    // Gửi AJAX để xóa lỗi khỏi session
    fetch('register?clearErrors=true', {method: 'POST'});
</c:if>

function togglePassword(fieldId) {
    const field = document.getElementById(fieldId);
    const icon = document.getElementById(fieldId + 'Icon');
    
    if (field.type === 'password') {
        field.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        field.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}
</script>

