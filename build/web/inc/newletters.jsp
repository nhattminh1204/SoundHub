<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Newsletter Section -->
<section class="py-5 bg-primary text-white">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <h3 class="fw-bold mb-2 text-white">Đăng Ký Nhận Tin Khuyến Mãi</h3>
                <p class="mb-0  text-white">Nhận thông tin về sản phẩm mới và ưu đãi đặc biệt</p>
            </div>
            <div class="col-lg-6">
                <form class="newsletter-form" id="newsletterForm">
                    <div class="input-group">
                        <input type="email" class="form-control form-control-lg" placeholder="Nhập email của bạn..." required>
                        <button class="btn btn-warning btn-lg" type="submit">
                            <i class="fas fa-paper-plane me-2"></i>Đăng Ký
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>