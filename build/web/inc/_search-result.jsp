<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="display-6 fw-bold text-gradient">
                        <i class="fas fa-search me-2"></i>Kết quả tìm kiếm
                    </h2>
                    <a href="products" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại sản phẩm
                    </a>
                </div>

                <!-- Search Info -->
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>
                    Tìm thấy <strong>${resultCount}</strong> sản phẩm cho từ khóa "<strong>${keyword}</strong>"
                </div>

                <!-- Search Results -->
                <c:if test="${products != null && products.size() > 0}">
                    <div class="row">
                        <c:forEach items="${products}" var="product">
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <article class="card product-card border-0 shadow-sm h-100">
                                    <div class="product-image" style="height: 250px; background: url('./assets/img/${product.image}') center/contain; background-repeat: no-repeat;"></div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title mb-2">${product.name}</h5>
                                        <div class="mt-auto">
                                            <div class="price-section mb-3">
                                                <span class="product-price">
                                                    <script>document.write(new Intl.NumberFormat('vi-VN').format(${product.price}))</script>
                                                </span>
                                            </div>
                                            <div class="d-flex gap-2">
                                                <button class="btn btn-primary flex-fill add-to-cart-btn" onclick="addToCart(${product.id})">
                                                    <i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ
                                                </button>
                                                <button class="btn view-detail-btn" style="border: 2px solid #0d6efd; color: #0d6efd; background: white;">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- No Results -->
                <c:if test="${products == null || products.size() == 0}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Không tìm thấy sản phẩm nào</h4>
                        <p class="text-muted">Hãy thử với từ khóa khác hoặc xem tất cả sản phẩm</p>
                        <a href="products" class="btn btn-primary">
                            <i class="fas fa-box me-2"></i>Xem tất cả sản phẩm
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</section>