$ ->
  $('#root').css
    height: $(window).height()
    visibility: 'visible'

  $('.panel-nav a').on 'click', (e) ->
    e.preventDefault()
    $target = $(this.hash)
    $(this).parents('#sidebar').find('.panel').hide()
    $target.show()

  hide_help = localStorage.help
  unless hide_help
    $('.help').show()

  $(document).on 'click', '.close', (e) ->
    e.preventDefault()
    $(this).parent('.help').hide()
    localStorage.help = false

  $(document).on 'click', '#secret', (e) ->
    e.preventDefault()
    this.setSelectionRange 0, this.value.length