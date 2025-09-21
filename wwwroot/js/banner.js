
// // Banner slider disabled for video implementation

// (function () {
//   var banner = document.querySelector('.main-banner');
//   if (!banner) return;
//   var root = banner.querySelector('.banner-image');
//   if (!root) return;
//   var slides = Array.prototype.slice.call(root.querySelectorAll('img'));
//   if (slides.length === 0) return;

//   root.style.position = 'relative';
//   root.style.overflow = 'hidden';
//   slides.forEach(function (img, i) {
//     img.style.position = 'absolute';
//     img.style.inset = '0';
//     img.style.objectFit = 'contain';
//     img.style.transition = 'opacity 500ms ease';
//     img.style.opacity = i === 0 ? '1' : '0';
//   });

//   var index = 0;
//   var intervalMs = 4000;

//   function setBackgroundFromPixel(img) {
//     function applyColor() {
//       try {
//         var canvas = document.createElement('canvas');
//         var ctx = canvas.getContext('2d');
//         canvas.width = img.naturalWidth || 1;
//         canvas.height = img.naturalHeight || 1;
//         ctx.drawImage(img, 0, 0);
        
//         var x = Math.floor(canvas.width * 0.1);
//         var y = Math.floor(canvas.height * 0.1);
//         var data = ctx.getImageData(x, y, 1, 1).data;
//         var color = 'rgb(' + data[0] + ', ' + data[1] + ', ' + data[2] + ')';
//         banner.style.backgroundColor = color;
//       } catch (e) {
//       }
//     }

//     if (img.complete && img.naturalWidth > 0) {
//       applyColor();
//     } else {
//       img.addEventListener('load', applyColor, { once: true });
//     }
//   }

//   function show(i) {
//     slides.forEach(function (img, idx) {
//       img.style.opacity = idx === i ? '1' : '0';
//     });
//     setBackgroundFromPixel(slides[i]);
//   }

//   function next() {
//     index = (index + 1) % slides.length;
//     show(index);
//   }

//   // Init
//   show(index);
//   if (slides.length > 1) setInterval(next, intervalMs);
// })();


// (function(){
//   var container = document.querySelector('.main-banner .banner-image');
//   if (!container) return;
//   var firstImg = container.querySelector('img');
//   if (!firstImg) return;

//   var ratio = null;
//   function setRatioFromImage(img){
//     if (img.naturalWidth > 0 && img.naturalHeight > 0) {
//       ratio = img.naturalHeight / img.naturalWidth;
//     }
//   }

//   function layout(){
//     if (!ratio) return;
//     var w = container.clientWidth || container.offsetWidth || 0;
//     if (!w) return;
//     var target = Math.round(w * ratio);
//     var minH = 200, maxH = 600;
//     var h = Math.min(maxH, Math.max(minH, target));
//     container.style.height = h + 'px';
//   }

//   function onImgReady(cb){
//     if (firstImg.complete) { cb(); return; }
//     firstImg.addEventListener('load', cb, { once: true });
//     firstImg.addEventListener('error', cb, { once: true });
//   }

//   onImgReady(function(){
//     setRatioFromImage(firstImg);
//     layout();
//   });

//   var resizeTimer = null;
//   window.addEventListener('resize', function(){
//     if (resizeTimer) clearTimeout(resizeTimer);
//     resizeTimer = setTimeout(layout, 100);
//   }, { passive: true });
// })();
