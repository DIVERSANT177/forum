// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "jquery3"
import "jquery_ujs"
import "@hotwired/turbo-rails"
import "controllers"

Turbo.start()

// Обработка ошибок AJAX
$(document).on('ajaxError', function(event, xhr) {
  if (xhr.status === 401) {
    window.location.href = '/users/sign_in';
  }
});