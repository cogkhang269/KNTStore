// Image Optimization for E-commerce Website
(function() {
    'use strict';

    // Simple Lazy Loading Implementation
    class LazyLoader {
        constructor() {
            this.imageObserver = null;
            this.init();
        }

        init() {
            // Wait for DOM to be ready
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', () => this.startLazyLoading());
            } else {
                this.startLazyLoading();
            }
        }

        startLazyLoading() {
            if ('IntersectionObserver' in window) {
                this.setupIntersectionObserver();
            } else {
                // Fallback: load all images immediately
                this.loadAllImages();
            }
        }

        setupIntersectionObserver() {
            const imageOptions = {
                root: null,
                rootMargin: '100px', // Load images 100px before they come into view
                threshold: 0.1
            };

            this.imageObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        this.loadImage(entry.target);
                        this.imageObserver.unobserve(entry.target);
                    }
                });
            }, imageOptions);

            // Observe all lazy images
            const lazyImages = document.querySelectorAll('img[data-src]');
            console.log('Found lazy images:', lazyImages.length);
            
            lazyImages.forEach(img => {
                this.imageObserver.observe(img);
            });
        }

        loadImage(img) {
            const src = img.dataset.src;
            if (!src) {
                console.warn('No data-src found for image:', img);
                return;
            }

            console.log('Loading image:', src);

            // Show loading state
            img.classList.add('lazy-loading');

            // Create new image to preload
            const imageLoader = new Image();
            
            imageLoader.onload = () => {
                img.src = src;
                img.classList.remove('lazy-loading');
                img.classList.add('loaded');
                
                // Remove data-src to prevent reloading
                delete img.dataset.src;
                console.log('Image loaded successfully:', src);
            };

            imageLoader.onerror = () => {
                img.classList.remove('lazy-loading');
                img.classList.add('error');
                console.error('Failed to load image:', src);
                
                // Fallback: try to load with src directly
                img.src = src;
            };

            imageLoader.src = src;
        }

        loadAllImages() {
            // Fallback: load all images immediately
            document.querySelectorAll('img[data-src]').forEach(img => {
                this.loadImage(img);
            });
        }
    }

    // Progressive Image Loading
    class ProgressiveLoader {
        constructor() {
            this.init();
        }

        init() {
            document.querySelectorAll('.progressive-img').forEach(img => {
                this.loadProgressiveImage(img);
            });
        }

        loadProgressiveImage(img) {
            const lowQualitySrc = img.dataset.lowQuality;
            const highQualitySrc = img.dataset.highQuality;

            if (lowQualitySrc) {
                img.src = lowQualitySrc;
                img.classList.add('blur-to-clear');
            }

            if (highQualitySrc) {
                const highQualityImg = new Image();
                highQualityImg.onload = () => {
                    img.src = highQualitySrc;
                    img.classList.add('loaded');
                };
                highQualityImg.src = highQualitySrc;
            }
        }
    }

    // WebP Support Detection
    class WebPSupport {
        constructor() {
            this.supportsWebP = false;
            this.checkSupport();
        }

        checkSupport() {
            const webP = new Image();
            webP.onload = webP.onerror = () => {
                this.supportsWebP = (webP.height === 2);
                this.updateImageSources();
            };
            webP.src = 'data:image/webp;base64,UklGRjoAAABXRUJQVlA4IC4AAACyAgCdASoCAAIALmk0mk0iIiIiIgBoSygABc6WWgAA/veff/0PP8bA//LwYAAA';
        }

        updateImageSources() {
            if (this.supportsWebP) {
                document.querySelectorAll('img[data-webp]').forEach(img => {
                    const webpSrc = img.dataset.webp;
                    if (webpSrc) {
                        img.src = webpSrc;
                    }
                });
            }
        }
    }

    // Image Compression Helper
    class ImageCompressor {
        static compressImage(file, maxWidth = 800, quality = 0.8) {
            return new Promise((resolve) => {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                const img = new Image();

                img.onload = () => {
                    // Calculate new dimensions
                    let { width, height } = img;
                    if (width > maxWidth) {
                        height = (height * maxWidth) / width;
                        width = maxWidth;
                    }

                    canvas.width = width;
                    canvas.height = height;

                    // Draw and compress
                    ctx.drawImage(img, 0, 0, width, height);
                    const compressedDataUrl = canvas.toDataURL('image/jpeg', quality);
                    resolve(compressedDataUrl);
                };

                img.src = URL.createObjectURL(file);
            });
        }
    }

    // Responsive Images Helper
    class ResponsiveImages {
        constructor() {
            this.init();
        }

        init() {
            this.setupResponsiveImages();
            this.handleResize();
        }

        setupResponsiveImages() {
            document.querySelectorAll('img[data-srcset]').forEach(img => {
                this.loadResponsiveImage(img);
            });
        }

        loadResponsiveImage(img) {
            const srcset = img.dataset.srcset;
            const sizes = img.dataset.sizes || '100vw';

            if (srcset) {
                img.srcset = srcset;
                img.sizes = sizes;
            }
        }

        handleResize() {
            let resizeTimer;
            window.addEventListener('resize', () => {
                clearTimeout(resizeTimer);
                resizeTimer = setTimeout(() => {
                    this.setupResponsiveImages();
                }, 250);
            });
        }
    }

    // Performance Monitoring
    class ImagePerformanceMonitor {
        constructor() {
            this.loadTimes = [];
            this.init();
        }

        init() {
            this.monitorImageLoadTimes();
        }

        monitorImageLoadTimes() {
            const observer = new PerformanceObserver((list) => {
                list.getEntries().forEach(entry => {
                    if (entry.initiatorType === 'img') {
                        this.loadTimes.push(entry.duration);
                        this.logPerformance(entry);
                    }
                });
            });

            observer.observe({ entryTypes: ['resource'] });
        }

        logPerformance(entry) {
            if (entry.duration > 1000) {
                console.warn(`Slow image load: ${entry.name} took ${entry.duration}ms`);
            }
        }

        getAverageLoadTime() {
            return this.loadTimes.reduce((a, b) => a + b, 0) / this.loadTimes.length;
        }
    }

    // Initialize all optimizations when DOM is ready
    document.addEventListener('DOMContentLoaded', () => {
        new LazyLoader();
        new ProgressiveLoader();
        new WebPSupport();
        new ResponsiveImages();
        new ImagePerformanceMonitor();
    });

    // Export for external use
    window.ImageOptimization = {
        LazyLoader,
        ProgressiveLoader,
        WebPSupport,
        ImageCompressor,
        ResponsiveImages,
        ImagePerformanceMonitor
    };

})();
