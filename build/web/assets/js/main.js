// Main JavaScript for SoundHub
class SoundHub {
    constructor() {
        this.cart = this.loadCart();
        this.init();
    }

    init() {
        this.updateCartBadge();
        this.setupSearch();
    }

    parsePrice(priceString) {
        return parseInt(priceString.replace(/[^\d]/g, ''));
    }


    showAddToCartAnimation(button) {
        const originalText = button.innerHTML;
        button.innerHTML = '<i class="fas fa-check me-1"></i>Đã thêm';
        button.classList.add('btn-success');
        button.classList.remove('btn-primary');

        setTimeout(() => {
            button.innerHTML = originalText;
            button.classList.remove('btn-success');
            button.classList.add('btn-primary');
        }, 1500);
    }

    showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type} notification-toast`;
        notification.innerHTML = `
            <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'} me-2"></i>
            ${message}
        `;

        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            animation: slideInRight 0.3s ease-out;
        `;

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease-in';
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    }

    handleScroll() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
            navbar.style.backdropFilter = 'blur(20px)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
        }
    }

    handleCardHover(e) {
        const card = e.currentTarget;
        const image = card.querySelector('.product-image');
        if (image) {
            image.style.transform = 'scale(1.05)';
        }
    }

    handleCardLeave(e) {
        const card = e.currentTarget;
        const image = card.querySelector('.product-image');
        if (image) {
            image.style.transform = 'scale(1)';
        }
    }


    setupSearch() {
        const searchForm = document.querySelector('.search-form');
        const searchInput = searchForm?.querySelector('input[name="keyword"]');

        if (searchInput) {
            let searchTimeout;
            searchInput.addEventListener('input', (e) => {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(() => {
                    this.performSearch(e.target.value);
                }, 300);
            });
        }
    }

    performSearch(keyword) {
        // Remove minimum character requirement - search with any input
        const products = document.querySelectorAll('.product-card, .product-item');
        
        // If no keyword, show all products
        if (!keyword.trim()) {
            products.forEach(product => {
                product.style.display = 'block';
                product.style.animation = 'fadeIn 0.3s ease-out';
            });
            return;
        }

        // Filter products based on search keyword
        products.forEach(product => {
            const titleElement = product.querySelector('.card-title, .product-title');
            if (!titleElement) return;
            
            const title = titleElement.textContent.toLowerCase();
            const isMatch = title.includes(keyword.toLowerCase());

            // Show matching products, hide non-matching ones
            if (isMatch) {
                product.style.display = 'block';
                product.style.animation = 'fadeIn 0.3s ease-out';
            } else {
                product.style.display = 'none';
            }
        });
    }
}

// Utility functions
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// CSS Animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    .notification-toast {
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        border-radius: 12px;
        border: none;
    }
`;
document.head.appendChild(style);

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.soundHub = new SoundHub();

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Lazy loading for images
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.style.opacity = '1';
                    imageObserver.unobserve(img);
                }
            });
        });

        document.querySelectorAll('.product-image').forEach(img => {
            img.style.opacity = '0';
            img.style.transition = 'opacity 0.3s ease';
            imageObserver.observe(img);
        });
    }
});

// Insert navigation and footer
document.getElementById('navigation').innerHTML = createNavigation('profile');
document.getElementById('footer').innerHTML = createFooter();

function showSection(section) {
    // Hide all sections
    document.getElementById('user-info').classList.add('d-none');
    document.getElementById('change-password').classList.add('d-none');
    document.getElementById('notifications').classList.add('d-none');
    document.getElementById('security').classList.add('d-none');

    // Remove active class from all menu items
    document.querySelectorAll('.list-group-item').forEach(item => {
        item.classList.remove('active');
    });

    // Show selected section
    if (section === 'info') {
        document.getElementById('user-info').classList.remove('d-none');
    } else if (section === 'password') {
        document.getElementById('change-password').classList.remove('d-none');
    } else if (section === 'notifications') {
        document.getElementById('notifications').classList.remove('d-none');
    } else if (section === 'security') {
        document.getElementById('security').classList.remove('d-none');
    }

    // Add active class to clicked menu item
    event.target.classList.add('active');
}

// Profile form submission
document.getElementById('profileForm').addEventListener('submit', function (e) {
    e.preventDefault();

    if (!this.checkValidity()) {
        e.stopPropagation();
        this.classList.add('was-validated');
        return;
    }

    showToast('Đã cập nhật thông tin thành công!', 'success');
});

// Password form submission
document.getElementById('passwordForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmNewPassword').value;

    if (newPassword !== confirmPassword) {
        document.getElementById('confirmNewPassword').setCustomValidity('Mật khẩu xác nhận không khớp');
    } else {
        document.getElementById('confirmNewPassword').setCustomValidity('');
    }

    if (!this.checkValidity()) {
        e.stopPropagation();
        this.classList.add('was-validated');
        return;
    }

    showToast('Đã đổi mật khẩu thành công!', 'success');
    this.reset();
    this.classList.remove('was-validated');
});

// Password strength checker
document.getElementById('newPassword').addEventListener('input', function () {
    const password = this.value;
    const strengthElement = document.getElementById('passwordStrength');

    if (password.length === 0) {
        strengthElement.textContent = '';
        return;
    }

    let strength = 0;
    if (password.length >= 6)
        strength++;
    if (password.match(/[a-z]/))
        strength++;
    if (password.match(/[A-Z]/))
        strength++;
    if (password.match(/[0-9]/))
        strength++;
    if (password.match(/[^a-zA-Z0-9]/))
        strength++;

    const strengthTexts = ['Rất yếu', 'Yếu', 'Trung bình', 'Mạnh', 'Rất mạnh'];
    const strengthClasses = ['text-danger', 'text-warning', 'text-info', 'text-success', 'text-success fw-bold'];

    strengthElement.textContent = `Độ mạnh: ${strengthTexts[strength - 1] || 'Rất yếu'}`;
    strengthElement.className = strengthClasses[strength - 1] || 'text-danger';
});

// Toggle password visibility
function togglePassword(fieldId) {
    const passwordInput = document.getElementById(fieldId);
    const toggleIcon = document.getElementById(fieldId + 'Icon');

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleIcon.classList.remove('fa-eye');
        toggleIcon.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        toggleIcon.classList.remove('fa-eye-slash');
        toggleIcon.classList.add('fa-eye');
    }
}

function resetForm() {
    document.getElementById('profileForm').reset();
    document.getElementById('name').value = '${user.name}';
    document.getElementById('email').value = '${user.email}';
    document.getElementById('phone').value = '${user.phone}';
}

function saveNotificationSettings() {
    showToast('Đã lưu cài đặt thông báo!', 'success');
}

function showLoginHistory() {
    showToast('Tính năng lịch sử đăng nhập sẽ sớm có!', 'info');
}

function increaseQty(btn) {
    const input = btn.previousElementSibling;
    const currentVal = parseInt(input.value);
    if (currentVal < 99) {
        input.value = currentVal + 1;
        input.form.submit();
    }
}

function decreaseQty(btn) {
    const input = btn.nextElementSibling;
    const currentVal = parseInt(input.value);
    if (currentVal > 1) {
        input.value = currentVal - 1;
        input.form.submit();
    }
}