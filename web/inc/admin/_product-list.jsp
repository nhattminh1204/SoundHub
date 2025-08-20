<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .stats-card {
        background: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
</style>

<div class="container-fluid py-4">
    <div class="bg-white border-bottom p-3">
        <div class="d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Quản lý sản phẩm</h4>
            <a href="admin-products?action=add" class="btn btn-primary btn-sm">
                <i class="fas fa-plus me-1"></i>Thêm sản phẩm
            </a>
        </div>
    </div>

    <div class="p-4">
        <c:import url="/inc/alert.jsp" />

        <!-- Stats -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <h3 class="text-primary mb-1">${products.size()}</h3>
                    <small class="text-muted">Tổng sản phẩm</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card text-center">
                    <h3 class="text-success mb-1">
                        <c:set var="activeCount" value="0"/>
                        <c:forEach var="p" items="${products}">
                            <c:if test="${p.status}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if>
                        </c:forEach>
                        ${activeCount}
                    </h3>
                    <small class="text-muted">Đang bán</small>
                </div>
            </div>
        </div>

        <!-- Product Table -->
        <div class="bg-white rounded shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="border-0 ps-3">ID</th>
                            <th class="border-0">Sản phẩm</th>
                            <th class="border-0">Giá</th>
                            <th class="border-0">Kho</th>
                            <th class="border-0">Danh mục</th>
                            <th class="border-0">Trạng thái</th>
                            <th class="border-0 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td class="ps-3 align-middle">#${p.id}</td>
                                <td class="align-middle">
                                    <div class="d-flex align-items-center">
                                        <img src="assets/img/${p.image}" class="rounded me-3" 
                                             style="width: 40px; height: 40px; object-fit: cover;">
                                        <span class="fw-medium">${p.name}</span>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <span class="text-primary fw-bold">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###"/>₫
                                    </span>
                                </td>
                                <td class="align-middle">
                                    <span class="badge ${p.quantity > 10 ? 'bg-success' : p.quantity > 0 ? 'bg-warning' : 'bg-danger'}">
                                        ${p.quantity}
                                    </span>
                                </td>
                                <td class="align-middle">
                                    <c:forEach items="${categories}" var="cate">
                                        <c:if test="${p.categoryId == cate.id}">
                                            ${cate.name}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td class="align-middle">
                                    <span class="badge ${p.status ? 'bg-success' : 'bg-secondary'}">
                                        ${p.status ? 'ON' : 'OFF'}
                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <a href="admin-products?action=edit&id=${p.id}" class="btn btn-sm btn-outline-warning me-1">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="admin-products?action=delete&id=${p.id}" class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Xóa sản phẩm này?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty products}">
                <div class="text-center py-5">
                    <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">Chưa có sản phẩm</h5>
                    <a href="admin-products?action=add" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm đầu tiên
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>