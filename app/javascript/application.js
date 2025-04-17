// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "trix";
import "@rails/actiontext";

// document.addEventListener("turbo:load", () => {
//   const toggleBtn = document.getElementById("mobile-menu-toggle");
//   const closeBtn = document.getElementById("mobile-menu-close");
//   const popup = document.getElementById("mobile-popup-menu");
//   const popupContent = document.getElementById("mobile-popup-content");

//   if (!popup || !popupContent) return;

//   const openMenu = () => {
//     popup.classList.remove("hidden");
//     setTimeout(() => {
//       popupContent.classList.remove(
//         "opacity-0",
//         "translate-y-[50px]",
//         "scale-95"
//       );
//       popupContent.classList.add("opacity-100", "translate-y-0", "scale-100");
//     }, 10);
//   };

//   const closeMenu = () => {
//     popupContent.classList.add("opacity-0", "translate-y-[50px]", "scale-95");
//     popupContent.classList.remove("opacity-100", "translate-y-0", "scale-100");
//     setTimeout(() => {
//       popup.classList.add("hidden");
//     }, 200);
//   };

//   toggleBtn?.addEventListener("click", openMenu);
//   closeBtn?.addEventListener("click", closeMenu);

//   // ESC ile kapansın
//   document.addEventListener("keydown", (e) => {
//     if (e.key === "Escape" && !popup.classList.contains("hidden")) {
//       closeMenu();
//     }
//   });

//   // Dışa tıklama ile kapansın
//   popup.addEventListener("click", (e) => {
//     if (e.target === popup) closeMenu();
//   });
// });
