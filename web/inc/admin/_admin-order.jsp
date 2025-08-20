<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container py-5">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4"><i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng</h2>
            
            <c:if test="${not empty sessionScope.admin_success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.admin_success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="admin_success" scope="session" />
            </c:if>
            
            <c:if test="${not empty sessionScope.admin_error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.admin_error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="admin_error" scope="session" />
            </c:if>
            
            <c:if test="${empty orders}">
                <div class="text-center py-5">
                    <i class="fas fa-shopping-bag text-muted" style="font-size: 4rem;"></i>
                    <h4 class="text-muted mt-3">Chưa có đơn hàng nào</h4>
                </div>
            </c:if>
            
            <c:forEach var="order" items="${orders}">
                <div class="card mb-4 shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="mb-0">Đơn hàng #${order.id}</h6>
                            <small class="text-muted">
                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                - User ID: ${order.userId}
                            </small>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <form action="admin-orders" method="post" class="d-flex align-items-center gap-2">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="confirmed" ${order.status == 'confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                                    <option value="shipping" ${order.status == 'shipping' ? 'selected' : ''}>Đang giao</option>
                                    <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                            </form>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-8">
                                <h6 class="text-primary mb-2">Sản phẩm:</h6>
                                <c:forEach var="item" items="${order.orderItems}">
                                    <div class="d-flex align-items-center mb-2">
                                        <img src="${pageContext.request.contextPath}/assets/img/${item.product.image}" 
                                             class="rounded me-3" width="50" height="50" style="object-fit: cover;">
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">${item.product.name}</h6>
                                            <small class="text-muted">
                                                SL: ${item.quantity} × 
                                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </small>
                                        </div>
                                        <div class="text-end">
                                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="border rounded p-3">
                                    <h6 class="text-primary mb-2">Thông tin giao hàng</h6>
                                    <p class="mb-1"><small><strong>Địa chỉ:</strong> ${order.shippingAddress}</small></p>
                                    <p class="mb-1"><small><strong>SĐT:</strong> ${order.phone}</small></p>
                                    <p class="mb-2"><small><strong>Thanh toán:</strong> ${order.paymentMethod}</small></p>
                                    
                                    <hr class="my-2">
                                    <div class="d-flex justify-content-between">
                                        <small>Phí ship:</small>
                                        <small><fmt:formatNumber value="${order.shippingFee}" type="currency" currencySymbol="₫" groupingUsed="true"/></small>
                                    </div>
                                    <div class="d-flex justify-content-between fw-bold text-primary">
                                        <span>Tổng cộng:</span>
                                        <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>