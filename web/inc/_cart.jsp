<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container py-5">
    <h2 class="mb-4">Giỏ hàng của bạn</h2>
    
    <c:if test="${empty cartItems}">
        <div class="text-center py-5">
            <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
            <h4>Giỏ hàng trống</h4>
            <p class="text-muted">Hãy thêm sản phẩm vào giỏ hàng</p>
            <a href="products" class="btn btn-primary">Mua sắm ngay</a>
        </div>
    </c:if>
    
    <c:if test="${not empty cartItems}">
        <div class="row">
            <div class="col-lg-8">
                <c:forEach var="item" items="${cartItems}">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-2">
                                    <img src="${pageContext.request.contextPath}/assets/img/${item.product.image}" 
                                         class="img-fluid rounded" alt="${item.product.name}">
                                </div>
                                <div class="col-md-4">
                                    <h6>${item.product.name}</h6>
                                    <p class="text-muted small"><span data-price="${item.product.price}"></span></p>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(${item.product.id}, ${item.quantity - 1})"
                                                style="border-bottom-left-radius: 0.5rem; border-top-left-radius: 0.5rem">-</button>
                                        <input type="text" class="form-control text-center" value="${item.quantity}" onchange="updateQuantity(${item.product.id}, this.value)">
                                        <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(${item.product.id}, ${item.quantity + 1})">+</button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <strong><span data-price="${item.subTotal}"></span></strong>
                                </div>
                                <div class="col-md-1">
                                    <button class="btn btn-outline-danger btn-sm" onclick="removeFromCart(${item.product.id})">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h5>Tổng cộng</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <span><span data-price="${total}"></span></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Phí vận chuyển:</span>
                            <span>Miễn phí</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <strong>Tổng cộng:</strong>
                            <strong><span data-price="${total}"></span></strong>
                        </div>
                        <a href="checkout" class="btn btn-primary w-100">Thanh toán</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/price-formatter.js"></script>