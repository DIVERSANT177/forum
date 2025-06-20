$(document).on('turbo:load', function () {
    $('.rate-up-button').on('click', function (e) {
        e.preventDefault()
        const btn = $(this)
        const url = btn.data('url')
        $.ajax({
            url: url,
            method: 'POST',
            dataType: 'script'
        })  
    })
})