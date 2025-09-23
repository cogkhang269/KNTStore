document.addEventListener('DOMContentLoaded', function() {
    const closeButton = document.querySelector('.trangDangNhap-close-btn');
    
    if (closeButton) {
        closeButton.addEventListener('click', function(e) {
            e.preventDefault();
            
            this.style.transform = 'scale(0.95)';
            this.style.transition = 'transform 0.1s ease';
            
            setTimeout(() => {
                window.location.href = '/';
            }, 150);
        });
        
        closeButton.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.1)';
            this.style.transition = 'transform 0.2s ease';
        });
        
        closeButton.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
            this.style.transition = 'transform 0.2s ease';
        });
    }
    
    const container = document.querySelector('.trangDangNhap-container');
    if (container) {
        container.style.opacity = '0';
        container.style.transform = 'translateY(30px)';
        
        setTimeout(() => {
            container.style.transition = 'all 0.6s ease';
            container.style.opacity = '1';
            container.style.transform = 'translateY(0)';
        }, 100);
    }

    const body = document.querySelector('.trangDangNhap-body');
    if (body) {
        body.style.scrollBehavior = 'smooth';
        
        window.addEventListener('scroll', function() {
            const container = document.querySelector('.trangDangNhap-container');
            if (container) {
                const rect = container.getBoundingClientRect();
                const isVisible = rect.top >= 0 && rect.bottom <= window.innerHeight;
                
                if (!isVisible) {
                    container.scrollIntoView({ 
                        behavior: 'smooth', 
                        block: 'center' 
                    });
                }
            }
        });
    }

    document.querySelectorAll('.trangDangNhap-input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.style.transition = 'transform 0.2s ease';
        });
        
        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
            this.parentElement.style.transition = 'transform 0.2s ease';
        });
    });

    const form = document.getElementById('trangDangNhap-form');
    if (form) {
        form.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('.trangDangNhap-btn');
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;
            
            setTimeout(() => {
                submitBtn.classList.remove('loading');
                submitBtn.disabled = false;
            }, 2000);
        });
    }

    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validatePhone(phone) {
        const re = /^[0-9]{10,11}$/;
        return re.test(phone.replace(/\s/g, ''));
    }

    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('blur', function() {
            const value = this.value.trim();
            if (value && !validateEmail(value) && !validatePhone(value)) {
                this.classList.add('error');
                showError(this, 'Vui lòng nhập email hoặc số điện thoại hợp lệ');
            } else {
                this.classList.remove('error');
                hideError(this);
            }
        });
    }

    function showError(input, message) {
        hideError(input);
        const errorDiv = document.createElement('div');
        errorDiv.className = 'trangDangNhap-error-message';
        errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
        input.parentElement.appendChild(errorDiv);
    }

    function hideError(input) {
        const errorDiv = input.parentElement.querySelector('.trangDangNhap-error-message');
        if (errorDiv) {
            errorDiv.remove();
        }
    }
});
