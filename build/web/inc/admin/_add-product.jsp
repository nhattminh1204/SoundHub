<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.admin-sidebar { background: #2c3e50; min-height: 100vh; }
.admin-content { background: #ecf0f1; min-height: 100vh; }
.sidebar-link { color: #bdc3c7; padding: 12px 20px; display: block; text-decoration: none; }
.sidebar-link:hover, .sidebar-link.active { background: #34495e; color: white; }
</style>

<div class="d-flex">
    <!-- Sidebar -->
    <div class="admin-sidebar" style="width: 250px;">
        <div class="p-3 border-bottom">
            <h5 class="text-white mb-0">Admin Panel</h5>
        </div>
        <nav class="mt-3">
            <a href="admin-dashboard" class="sidebar-link">
                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
            </a>
            <a href="admin-products" class="sidebar-link active">
                <i class="fas fa-box me-2"></i>Sản phẩm
            </a>
            <a href="#" class="sidebar-link">
                <i class="fas fa-users me-2"></i>Người dùng
            </a>
            <a href="#" class="sidebar-link">
                <i class="fas fa-shopping-cart me-2"></i>Đơn hàng
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="admin-content flex-grow-1">
        <div class="bg-white border-bottom p-3">
            <div class="d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Thêm sản phẩm mới</h4>
                <a href="admin-products" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>
        </div>

        <div class="p-4">
            <c:import url="/inc/alert.jsp" />
            
            <div class="bg-white rounded shadow-sm p-4">
                <form action="admin-products" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="row">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label">Tên sản phẩm *</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Giá bán *</label>
                                        <input type="number" class="form-control" name="price" min="0" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Số lượng *</label>
                                        <input type="number" class="form-control" name="quantity" min="0" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Danh mục *</label>
                                <select class="form-select" name="categoryId" required>
                                    <option value="">Chọn danh mục</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="status" value="true" checked>
                                    <label class="form-check-label">Kích hoạt sản phẩm</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label">Hình ảnh</label>
                                <input type="file" class="form-control" name="image" accept="image/*">
                                <div class="mt-2">
                                    <img id="preview" src="#" alt="Preview" style="max-width: 100%; height: 200px; object-fit: cover; display: none;" class="rounded">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>Lưu sản phẩm
                        </button>
                        <a href="admin-products" class="btn btn-outline-secondary">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.querySelector('input[name="image"]').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('preview');
            preview.src = e.target.result;
            preview.style.display = 'block';
        }
        reader.readAsDataURL(file);
    }
});
</script>