// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "jquery3"
import "jquery_ujs"
import "@hotwired/turbo-rails"
import "controllers"
import 'select2';
import "popper";
import "bootstrap";
import "fontawesome"
import "fontawesome-solid"
import "rate_answer"

const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))

//= require jquery.remotipart

Turbo.start()

// Обработка ошибок AJAX
$(document).on('ajaxError', function(event, xhr) {
  if (xhr.status === 401) {
    window.location.href = '/users/sign_in';
  }
});import "channels"


document.addEventListener('turbo:load', function() {
  const selectElement = $('.select2-ajax');
  selectElement.select2({
    ajax: {
      url: selectElement.data('url'), // Используем сохраненный элемент
      dataType: 'json',
      delay: 250,
      data: function(params) {
        console.log('Searching for:', params.term); // Отладочное сообщение
        return {
          query: params.term,
          page: params.page || 1,
          all_results: true
        };
      },
      processResults: function(data, params) {
        console.log('Received data:', data); // Отладочное сообщение
        // params.page = params.page || 1;
        
        // Преобразуем данные в формат, ожидаемый Select2
        const results = data.items ? data.items.map(function(item) {
          return {
            id: item.id,
            title: item.title,
            body: item.body
          };
        }) : [];
        
        return {
          results: results,
          pagination: {
            more: false // Отключаем подгрузку дополнительных страниц
          }
        };
      },
      error: function(xhr, status, error) {
        console.error('AJAX error:', error); // Логирование ошибок
      },
      cache: true
    },
    minimumInputLength: selectElement.data('minimum-input-length') || 3,
    placeholder: selectElement.data('placeholder'),
    allowClear: true,
    width: '15%',
    templateResult: formatQuestion,
    templateSelection: formatQuestionSelection
  }).on('select2:select', function(e) {
    // При выборе элемента перенаправляем на страницу вопроса
    if (e.params.data.id) {
      window.location.href = `/questions/${e.params.data.id}`;
    }
  });
  
  function formatQuestion(question) {
    if (question.loading) return question.text;
    
    const $container = $(
      '<div class="question-result">' +
        '<strong>' + (question.title || question.text) + '</strong>'
    );
    
    if (question.body) {
      $container.append('<br><small>' + question.body.substring(0, 100) + '...</small>');
    }
    
    return $container;
  }
  
  function formatQuestionSelection(question) {
    return question.title || question.text || question.id;
  }
});

document.addEventListener("turbo:before-cache", function () {
  $('.select2-ajax').each(function () {
    const $el = $(this);
    if ($el.data('select2')) {
      $el.select2('destroy');
    }
  });
});