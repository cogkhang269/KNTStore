(function() {
    'use strict';

    console.log('Simple Lazy Load script loaded');

    function initLazyLoading() {
        const lazyImages = document.querySelectorAll('img[data-src]');
        console.log('Found images to lazy load:', lazyImages.length);

        if (lazyImages.length === 0) {
            console.log('No lazy images found');
            return;
        }

        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        const src = img.dataset.src;
                        
                        console.log('Loading image:', src);
                        
                        if (src) {
                            img.src = src;
                            img.classList.remove('lazy-loading');
                            img.classList.add('loaded');
                            observer.unobserve(img);
                        }
                    }
                });
            }, {
                rootMargin: '50px'
            });

            lazyImages.forEach(img => {
                imageObserver.observe(img);
            });
        } else {
            console.log('IntersectionObserver not supported, loading all images');
            lazyImages.forEach(img => {
                const src = img.dataset.src;
                if (src) {
                    img.src = src;
                    img.classList.remove('lazy-loading');
                    img.classList.add('loaded');
                }
            });
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initLazyLoading);
    } else {
        initLazyLoading();
    }

})();
