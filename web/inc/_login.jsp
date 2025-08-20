<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7">
                <div class="form-container shadow-custom">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-circle fa-4x text-primary mb-3"></i>
                        <h2 class="text-gradient">Đăng Nhập</h2>
                        <p class="text-muted">Chào mừng bạn quay trở lại!</p>
                    </div>
                    
                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${login_error != null}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${login_error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <!-- FORM ĐĂNG NHẬP -->
                    <!-- Gửi dữ liệu input emailphone và password đến /login -->
                    <form action="login" method="post" id="loginForm">
                        <div class="mb-3">
                            <label for="emailphone" class="form-label">
                                <i class="fas fa-envelope me-2"></i>Email hoặc Số điện thoại
                            </label>
                            <input type="text" class="form-control ${err_emailphone != null ? 'is-invalid' : ''}" 
                                   id="emailphone" name="emailphone" value="${form_emailphone}" required>
                            <c:if test="${err_emailphone != null}">
                                <div class="invalid-feedback d-block">${err_emailphone}</div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="fas fa-lock me-2"></i>Mật khẩu
                            </label>
                            <div class="input-group">
                                <input type="password" class="form-control ${err_password != null ? 'is-invalid' : ''}"
                                       style="border-radius: 0.5rem 0 0 0.5rem;
                                       border-top: 2px solid #e2e8f0;
                                       border-right: none;
                                       border-bottom: 2px solid #e2e8f0;
                                       border-left: 2px solid #e2e8f0;"
                                       id="password" name="password" required>
                                <button class="btn btn-outline-secondary"
                                        style="border: 2px solid #e2e8f0; background: #3b82f6"
                                        type="button" onclick="togglePasswordVisibility('password', this)">
                                    <i class="fas fa-eye text-white" id="toggleIcon"></i>
                                </button>
                            </div>
                            <c:if test="${err_password != null}">
                                <div class="invalid-feedback d-block">${err_password}</div>
                            </c:if>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Ghi nhớ đăng nhập
                            </label>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg btn-custom">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                            </button>
                        </div>

                        <div class="text-center mb-3">
                            <a href="#" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                                <i class="fas fa-question-circle me-1"></i>Quên mật khẩu?
                            </a>
                        </div>

                        <hr>

                        <div class="text-center">
                            <p class="mb-2">Chưa có tài khoản?</p>
                            <a href="register" class="btn btn-outline-primary btn-custom">
                                <i class="fas fa-user-plus me-2"></i>Đăng Ký Ngay
                            </a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</section>

<!-- Forgot Password Modal -->
<div class="modal fade" id="forgotPasswordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-key me-2"></i>Quên Mật Khẩu
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="text-muted">Nhập email của bạn để nhận link đặt lại mật khẩu.</p>
                <form id="forgotPasswordForm">
                    <div class="mb-3">
                        <label for="resetEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="resetEmail" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-2"></i>Gửi Link Đặt Lại
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>