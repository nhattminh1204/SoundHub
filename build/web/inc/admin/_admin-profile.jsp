<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container py-5">
    <div class="row g-4">
        <c:import url="/inc/admin/_admin_profile_tool.jsp" />

        <div class="col-lg-9">
            <div class="card border-0 shadow-lg rounded-4">
                <div class="card-header bg-primary text-white rounded-top-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-user-circle fa-2x me-3"></i>
                        <h4 class="mb-0 text-white">Thông Tin Admin</h4>
                    </div>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty sessionScope.profile_error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${sessionScope.profile_error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="profile_error" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.profile_success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            ${sessionScope.profile_success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="profile_success" scope="session" />
                    </c:if>

                    <form action="admin-profile" method="post" class="needs-validation" novalidate>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="name" class="form-label fw-semibold">Họ và tên <span style="color: red">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" id="name" name="name" style="border: 2px solid #e2e8f0"
                                           value="${user.name}" required placeholder="Nhập họ và tên">
                                </div>
                                <div class="invalid-feedback">Vui lòng nhập họ tên.</div>
                            </div>

                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại <span style="color: red">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    <input type="tel" class="form-control" id="phone" name="phone" style="border: 2px solid #e2e8f0" 
                                           value="${user.phone}" required pattern="[0-9]{10,11}" 
                                           placeholder="Nhập số điện thoại">
                                </div>
                                <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ.</div>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label fw-semibold">Email</label>
                                <div class="p-3 bg-light rounded">
                                    <i class="fas fa-envelope text-primary me-2"></i>
                                    <span class="text-muted">${user.email}</span>
                                    <input type="hidden" name="email" value="${user.email}">
                                </div>
                            </div>
                        </div>

                        <input type="hidden" name="action" value="update_profile">

                        <div class="d-flex gap-2 mt-4 justify-content-end">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fas fa-save me-2"></i>Cập Nhật
                            </button>
                            <button type="button" class="btn btn-outline-secondary" 
                                    onclick="document.getElementById('name').value='${user.name}'; document.getElementById('phone').value='${user.phone}';" 
                                    style="border-radius: 0.375rem">
                                <i class="fas fa-undo me-2"></i>Khôi Phục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>