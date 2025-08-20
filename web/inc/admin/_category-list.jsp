<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.stats-card { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
</style>

<div class="container-fluid py-4">
    <div class="bg-white border-bottom p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Quản lý danh mục</h4>
            <a href="admin-categories?action=add" class="btn btn-primary btn-sm">
                <i class="fas fa-plus me-1"></i>Thêm danh mục
            </a>
        </div>
    </div>

    <div class="p-4">
        <c:import url="/inc/alert.jsp" />
        
        <!-- Stats -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <h3 class="text-primary mb-1">${categories.size()}</h3>
                    <small class="text-muted">Tổng danh mục</small>
                </div>
            </div>
        </div>

        <!-- Category Table -->
        <div class="bg-white rounded shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="border-0 ps-3">ID</th>
                            <th class="border-0">Tên danh mục</th>
                            <th class="border-0 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td class="ps-3 align-middle">#${category.id}</td>
                                <td class="align-middle">
                                    <span class="fw-medium">${category.name}</span>
                                </td>
                                <td class="align-middle text-center">
                                    <a href="admin-categories?action=edit&id=${category.id}" class="btn btn-sm btn-outline-warning me-1">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="admin-categories?action=delete&id=${category.id}" class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Xóa danh mục này?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty categories}">
                <div class="text-center py-5">
                    <i class="fas fa-tags fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Chưa có danh mục</h5>
                    <a href="admin-categories?action=add" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Thêm danh mục đầu tiên
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>