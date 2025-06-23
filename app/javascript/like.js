$(document).on('turbo:load', function () {
    $('.like-button').on('click', function (e) {
        e.preventDefault()
        let url = $(this).attr('data-url');
        $.ajax({
            url: url,
            method: url.includes('/like') ? 'POST' : 'DELETE',
            dataType: 'script'
        })  
    })
})