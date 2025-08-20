<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card border-danger">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0 text-white">
                        <i class="fas fa-exclamation-triangle me-2 text-white"></i>
                        Xác nhận xóa danh mục "${category.name}"
                    </h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-warning">
                        <i class="fas fa-warning me-2"></i>
                        <strong>Cảnh báo:</strong> Danh mục này có <strong>${products.size()}</strong> sản phẩm. 
                        Xóa danh mục sẽ xóa tất cả sản phẩm bên trong!
                    </div>
                    
                    <h6>Các sản phẩm sẽ bị xóa:</h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>#${product.id}</td>
                                        <td>${product.name}</td>
                                        <td><span data-price="${product.price}"></span></td>
                                        <td>${product.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="admin-categories" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Hủy bỏ
                        </a>
                        <form action="admin-categories" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="confirm_delete">
                            <input type="hidden" name="id" value="${category.id}">
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash me-2"></i>Xác nhận xóa tất cả
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/price-formatter.js"></script>