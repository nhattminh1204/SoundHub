<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container my-5">
    <div class="row">
        <div class="col-12">
            <h1 class="text-center mb-4" style="color: #2563eb">Danh sách sản phẩm tại Soundhub</h1>
        </div>
    </div>
    
    <div class="row">
        <c:forEach var="product" items="${allProducts}">
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
                                <a href="
                                   <c:if test="${user==null}">
                                       login
                                   </c:if>
                                   <c:if test="${user!=null}">
                                       products?id_product=${product.id}&id_category=${product.categoryId}
                                   </c:if>
                                   " class="btn btn-primary flex-grow-1">
                                    <i class="fas fa-cart-plus"></i> Add to cart
                                </a>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
        </c:forEach>
    </div>
</div>