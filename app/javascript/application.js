// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@popperjs/core";
import "bootstrap";

// Initialize Rails UJS for handling methods like data-turbo-method and data-turbo-confirm
import Rails from "@rails/ujs";
Rails.start();

// // Debug to verify imports
// console.log("Bootstrap and dependencies loaded");

// document.addEventListener("DOMContentLoaded", function () {
//   console.log("DOM fully loaded and parsed");

//   // Initialize all dropdowns manually to test
//   const dropdownElements = document.querySelectorAll('.dropdown-toggle');
//   dropdownElements.forEach((dropdownToggle) => {
//     new bootstrap.Dropdown(dropdownToggle);
//   });
// });

//  // Ensure Bootstrap dropdowns work with Turbo
// document.addEventListener("turbo:load", () => {
//   const dropdownElements = document.querySelectorAll('.dropdown-toggle');
//   dropdownElements.forEach(dropdownToggle => {
//     new bootstrap.Dropdown(dropdownToggle);
//   });
// });
