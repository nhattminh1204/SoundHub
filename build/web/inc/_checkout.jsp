<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container py-4">
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-gradient bg-primary text-white border-0">
                    <h5 class="mb-0 text-white"><i class="fas fa-credit-card me-2 text-white"></i>Thông tin thanh toán</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty sessionScope.checkout_error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${sessionScope.checkout_error}
                        </div>
                        <c:remove var="checkout_error" scope="session" />
                    </c:if>

                    <form action="checkout" method="post">
                        <div class="row g-3">
                            <div class="col-12">
                                <label for="address" class="form-label fw-semibold">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="address" name="address" rows="2" 
                                          placeholder="Nhập địa chỉ đầy đủ..." required></textarea>
                            </div>
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${user.phone}" placeholder="Nhập số điện thoại" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Phương thức thanh toán <span class="text-danger">*</span></label>
                                <div class="d-flex gap-3 mt-2">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="payment" id="cod" value="COD" checked>
                                        <label class="form-check-label" for="cod">
                                            <i class="fas fa-money-bill-wave me-1"></i>COD
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="payment" id="transfer" value="Chuyển khoản">
                                        <label class="form-check-label" for="transfer">
                                            <i class="fas fa-university me-1"></i>Chuyển khoản
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4">

                        <button type="submit" class="btn btn-order btn-lg w-100 py-3 text-white">
                            <i class="fas fa-shopping-bag me-2 text-white"></i>Đặt hàng ngay
                        </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm checkout-sidebar">
                <div class="card-header bg-light border-0">
                    <h6 class="mb-0 text-primary"><i class="fas fa-shopping-cart me-2"></i>Đơn hàng của bạn</h6>
                </div>
                <div class="card-body p-3">
                    <div class="order-items" style="max-height: 300px; overflow-y: auto;">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex align-items-center mb-3 pb-2 border-bottom">
                                <img src="./assets/img/${item.product.image}" 
                                     class="rounded me-2" width="40" height="40" style="object-fit: cover;">
                                <div class="flex-grow-1">
                                    <h6 class="mb-0 small">${item.product.name}</h6>
                                    <small class="text-muted">SL: ${item.quantity}</small>
                                </div>
                                <div class="text-end">
                                    <small class="fw-bold">
                                        <fmt:formatNumber value="${item.product.price * item.quantity}" 
                                                        type="currency" currencySymbol="₫" groupingUsed="true"/>
                                    </small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="border-top pt-3 mt-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Phí vận chuyển:</span>
                            <span><fmt:formatNumber value="${shippingFee}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                        </div>
                        <div class="d-flex justify-content-between fw-bold fs-5 text-primary border-top pt-2">
                            <span>Tổng cộng:</span>
                            <span>
                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>