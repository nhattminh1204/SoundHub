// Profile Page JavaScript Enhancements

// 1. Tính năng ẩn hiện mật khẩu
function togglePasswordVisibility(id, button) {
  const input = document.getElementById(id);
  const icon = button.querySelector("i");

  if (input.type === "password") {
    input.type = "text";
    icon.classList.remove("fa-eye");
    icon.classList.add("fa-eye-slash");
  } else {
    input.type = "password";
    icon.classList.remove("fa-eye-slash");
    icon.classList.add("fa-eye");
  }
}

// 2. Khởi tạo các sự kiện cho form
document.addEventListener('DOMContentLoaded', function() {
    // Thêm class profile-form cho các form
    const forms = document.querySelectorAll('#profileForm, #passwordForm');
    forms.forEach(form => {
        form.classList.add('profile-form');
    });
    
    // Thêm class profile-card cho các card
    const cards = document.querySelectorAll('#user-info, #change-password, #notifications, #security');
    cards.forEach(card => {
        card.classList.add('profile-card');
    });
    
    // Thêm class btn-reset cho nút khôi phục
    const resetButtons = document.querySelectorAll('button[onclick*="reset"]');
    resetButtons.forEach(btn => {
        btn.classList.add('btn-reset');
    });
    
    // Thêm sự kiện cho các nút toggle password
    setupPasswordToggle();
});


// 4. Password strength indicator
function checkPasswordStrength(password) {
    const strength = {
        0: "Rất yếu",
        1: "Yếu",
        2: "Trung bình",
        3: "Mạnh",
        4: "Rất mạnh"
    };
    
    let score = 0;
    
    if (password.length > 6) score++;
    if (password.length > 8) score++;
    if (/[A-Z]/.test(password)) score++;
    if (/[0-9]/.test(password)) score++;
    if (/[^A-Za-z0-9]/.test(password)) score++;
    
    return strength[score];
}

// 5. Show/hide sections
function showSection(sectionId) {
        // áº¨n táº¥t cáº£ cÃ¡c section
        const sections = ['info', 'password', 'notifications', 'security'];
        sections.forEach(id => {
            const section = document.getElementById(id);
            if (section) {
                section.classList.add('d-none');
            }
        });
        
        // Hiá»n section ÄÆ°á»£c chá»n
        const selectedSection = document.getElementById(sectionId);
        if (selectedSection) {
            selectedSection.classList.remove('d-none');
        }
        
        // Cáº­p nháº­t active tab
        const tabs = ['tab-info', 'tab-password', 'tab-notifications', 'tab-security'];
        tabs.forEach(id => {
            const tab = document.getElementById(id);
            if (tab) {
                tab.classList.remove('active');
            }
        });
        
        const activeTab = document.getElementById(`tab-${sectionId}`);
        if (activeTab) {
            activeTab.classList.add('active');
        }
    }

// 6. Reset form function
function resetForm() {
    const form = document.getElementById('profileForm');
    if (form) {
        form.reset();
        form.querySelectorAll('.is-invalid').forEach(el => {
            el.classList.remove('is-invalid');
        });
    }
}

// 7. Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;
    
    const inputs = form.querySelectorAll('input[required]');
    let isValid = true;
    
    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.classList.add('is-invalid');
            isValid = false;
        } else {
            input.classList.remove('is-invalid');
        }
    });
    
    return isValid;
}
