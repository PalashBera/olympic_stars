// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

$(document).on("click", ".hamburger, .overlay", function (event) {
  $(".sidebar").toggleClass("active");
  $(".overlay").toggleClass("active");
});

$(document).keyup(function(e) {
  if (e.key === "Escape" && $(".overlay").hasClass("active")) {
    $(".sidebar").toggleClass("active");
    $(".overlay").toggleClass("active");
  }
});
