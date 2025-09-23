
(function () {
  var headerTop = document.querySelector('.header-top');
  if (!headerTop) return;

  var lastIsShrunk = false;

  function onScroll() {
    var shouldShrink = window.scrollY > 10;
    if (shouldShrink === lastIsShrunk) return;
    lastIsShrunk = shouldShrink;

    if (shouldShrink) {
      headerTop.classList.add('shrink');
      document.body.classList.add('header-shrink');
    } else {
      headerTop.classList.remove('shrink');
      document.body.classList.remove('header-shrink');
    }
  }

  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();
})();

(function() {
  const fadeInSections = document.querySelectorAll('.fade-in-section');
  
  if (fadeInSections.length === 0) return;

  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in-visible');
        observer.unobserve(entry.target);
      }
    });
  }, observerOptions);

  fadeInSections.forEach(section => {
    observer.observe(section);
  });
})();

