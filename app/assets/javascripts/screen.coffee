$ ->
  setActivePanel = (target) ->
    target  ||= location.hash || '#domains'
    $target   = $(target)
    $nav_item = $(".panel-nav a[href^=#{target}]")

    $nav_item.parents('#sidebar').find('.panel').hide()
    $nav_item.siblings().removeClass('active')
    $nav_item.addClass('active')

    $target.show()

  $('#root').css
    visibility: 'visible'
    height: $(window).height()

  $(window).on 'resize', (e) ->
    setTimeout =>
      $('#root').height($(this).height())
    , 200

  $('.panel-nav a').on 'click', (e) ->
    setActivePanel(this.hash)

  setActivePanel()

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