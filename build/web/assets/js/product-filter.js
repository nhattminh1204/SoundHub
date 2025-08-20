function filterProducts(categoryId) {
    const products = document.querySelectorAll('.product-item');
    let visibleCount = 0;
    
    products.forEach(product => {
        if (categoryId === 'all' || product.dataset.category === categoryId) {
            product.style.display = 'block';
            visibleCount++;
        } else {
            product.style.display = 'none';
        }
    });
    
    // Update active tab
    document.querySelectorAll('#productTabs .nav-link').forEach(link => {
        link.classList.remove('active');
    });
    event.target.classList.add('active');
    
    const emptyMessage = document.querySelector('.empty-category');
    if (emptyMessage) {
        emptyMessage.remove();
    }
    
    if (visibleCount === 0) {
        const grid = document.querySelector('#featured-products-grid');
        const emptyDiv = document.createElement('div');
        emptyDiv.className = 'col-12 text-center py-5 empty-category';
        emptyDiv.innerHTML = `
            <i class="fas fa-box-open fa-5x text-muted mb-3"></i>
            <h4 class="text-muted">Không có sản phẩm nào</h4>
            <p class="text-muted">Danh mục này hiện tại chưa có sản phẩm</p>
        `;
        grid.appendChild(emptyDiv);
    }
}