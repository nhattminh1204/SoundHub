<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-light py-2">
    <div class="container">
        <nav class="breadcrumb mb-0">
            <a class="breadcrumb-item" href="home"><i class="fas fa-home"></i></a>
            <span class="breadcrumb-item active">Sản Phẩm</span>
        </nav>
    </div>
</div>

<section class="py-4">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-1">Sản Phẩm</h2>
                <small class="text-muted">Thiết bị âm thanh chất lượng</small>
            </div>
        </div>

        <!-- Hiển thị tất cả các danh mục sản phẩm đang có -->
        <div class="row mb-4">
            <div class="col-12">
                <ul class="nav nav-pills justify-content-center" id="productTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <!-- Chuyển tới products (hiển thị tất cả sản phẩm) -->
                        <a href="products" class="nav-link ${empty param.idCategory ? 'active' : ''}">
                            <i class="fas fa-th-large me-2"></i>Tất Cả
                        </a>
                    </li>
                    <!-- Duyệt qua các danh mục sản phẩm -->
                    <c:forEach var="cate" items="${listCate}">
                        <%-- Khi chọn cate thì gửi idCategory với id tương ứng đến /products --%>
                        <li class="nav-item" role="presentation">
                            <a href="products?idCategory=${cate.getId()}" class="nav-link ${param.idCategory == cate.getId() ? 'active' : ''}">
                                ${cate.getName()}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!-- Hiển thị sản phẩm -->
        <div class="row" id="products-grid">

            <%-- Trường hợp danh sách trả về trống --%>
            <c:if test="${empty products}">
                <div class="col-12 text-center py-5">
                    <i class="fas fa-box-open fa-5x text-muted mb-3"></i>
                    <h4 class="text-muted">Không có sản phẩm nào</h4>
                    <p class="text-muted">Danh mục này hiện tại chưa có sản phẩm</p>
                </div>
            </c:if>

            <%-- Ngược lại, nếu danh sách có sản phẩm --%>
            <c:if test="${not empty products}">
                <%-- Duyệt qua tất cả các sản phẩm có trong danh sách --%>
                <c:forEach items="${products}" var="product">
                    <%-- Nếu idCategory == null: không lọc theo danh mục --%>
                    <%-- Hoặc sản phẩm thuộc danh mục đang chọn --%>
                    <%-- Mà còn hoạt động (status) --%>
                    <c:if test="${(idCategory == null || product.categoryId == idCategory) and product.status == true}">
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
                                                   products?id_product=${product.getId()}
                                               </c:if>
                                               " class="btn btn-primary flex-grow-1">
                                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </article>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>
</section>
