$ ->
  hide_help = localStorage.help
  unless hide_help
    $('.help').show()

  $(document).on 'click', '.close', (e) ->
    e.preventDefault()
    $(this).parent('.help').hide()
    localStorage.help = false