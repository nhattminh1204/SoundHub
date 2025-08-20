// Price formatting utility
function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN').format(price);
}

// Format all prices on page load
document.addEventListener('DOMContentLoaded', function() {
    // Format prices using data attributes
    document.querySelectorAll('[data-price]').forEach(function(element) {
        const price = parseFloat(element.getAttribute('data-price'));
        element.textContent = formatPrice(price) + '₫';
    });
});