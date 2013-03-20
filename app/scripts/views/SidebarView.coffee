class App.Views.SidebarView extends Backbone.View
  el: $('#sidebar')
  events:
    "click .panel-nav a": 'setActivePanel'

  initialize: ->
    @setActivePanel()

  setActivePanel: (event) ->
    if event && event.type == 'click'
      target = event.currentTarget.hash
    else
      target  = window.location.hash || '#domains'

    $target   = $(target)
    $nav_item = this.$(".panel-nav a[href^=#{target}]")

    this.$('.panel').hide()
    $nav_item.siblings().removeClass('active')
    $nav_item.addClass('active')

    $target.show()