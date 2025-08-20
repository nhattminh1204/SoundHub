<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-lg">
                <div class="card-body text-center p-5">
                    <div class="mb-4">
                        <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
                    </div>

                    <h2 class="text-success mb-3">Đặt hàng thành công!</h2>
                    <p class="text-muted mb-4">Cảm ơn bạn đã mua hàng tại SoundHub. Đơn hàng của bạn đã được tiếp nhận và đang được xử lý.</p>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="border rounded p-3">
                                <h6 class="text-primary mb-2">Thông tin đơn hàng</h6>
                                <p class="mb-1"><strong>Mã đơn hàng:</strong> #${order.id}</p>
                                <p class="mb-1"><strong>Ngày đặt:</strong> 
                                    <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                                <p class="mb-0"><strong>Trạng thái:</strong> 
                                    <span class="badge bg-warning">Chờ xử lý</span>
                                </p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="border rounded p-3">
                                <h6 class="text-primary mb-2">Thông tin giao hàng</h6>
                                <p class="mb-1"><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                                <p class="mb-1"><strong>Số điện thoại:</strong> ${order.phone}</p>
                                <p class="mb-0"><strong>Thanh toán:</strong> ${order.paymentMethod}</p>
                            </div>
                        </div>
                    </div>

                    <div class="border rounded p-3 mb-4">
                        <h6 class="text-primary mb-3">Chi tiết đơn hàng</h6>
                        <c:forEach var="item" items="${order.orderItems}">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div class="text-start">
                                    <span>${item.product.name}</span>
                                    <small class="text-muted d-block">Số lượng: ${item.quantity}</small>
                                </div>
                                <span><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                            </div>
                        </c:forEach>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <span>Phí vận chuyển:</span>
                            <span><fmt:formatNumber value="${order.shippingFee}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                        </div>
                        <div class="d-flex justify-content-between fw-bold fs-5 text-primary">
                            <span>Tổng cộng:</span>
                            <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/></span>
                        </div>
                    </div>

                    <div class="d-flex gap-3 justify-content-center">
                        <a href="home" class="btn btn-primary">
                            <i class="fas fa-home me-2"></i>Về trang chủ
                        </a>
                        <a href="order-history" class="btn btn-outline-primary">
                            <i class="fas fa-history me-2"></i>Xem đơn hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>