<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.admin-sidebar { background: #2c3e50; min-height: 100vh; }
.admin-content { background: #ecf0f1; min-height: 100vh; }
.sidebar-link { color: #bdc3c7; padding: 12px 20px; display: block; text-decoration: none; }
.sidebar-link:hover, .sidebar-link.active { background: #34495e; color: white; }
</style>

<div class="d-flex">
    <!-- Main Content -->
    <div class="admin-content flex-grow-1">
        <div class="bg-white border-bottom p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Sửa thông tin người dùng</h4>
                <a href="admin-users" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>
        </div>

        <div class="p-4">
            <c:import url="/inc/alert.jsp" />
            
            <div class="bg-white rounded shadow-sm p-4">
                <form action="admin-users" method="post">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="${user.id}">
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Họ tên *</label>
                                <input type="text" class="form-control" name="name" value="${user.name}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Email *</label>
                                <input type="email" class="form-control" name="email" value="${user.email}" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Số điện thoại *</label>
                                <input type="text" class="form-control" name="phone" value="${user.phone}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Quyền *</label>
                                <select class="form-select" name="role" required>
                                    <option value="user" ${user.role == 'user' ? 'selected' : ''}>User</option>
                                    <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu hiện tại</label>
                                <input type="text" class="form-control" value="${user.password}" readonly>
                                <small class="text-muted">Mật khẩu đã mã hóa</small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Mật khẩu mới</label>
                                <input type="password" class="form-control" name="newPassword" placeholder="Để trống nếu không đổi">
                                <small class="text-muted">Nhập mật khẩu mới nếu muốn thay đổi</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>Cập nhật
                        </button>
                        <a href="admin-users" class="btn btn-outline-secondary">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>