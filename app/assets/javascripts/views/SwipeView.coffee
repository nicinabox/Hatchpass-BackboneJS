class App.Views.SwipeView extends Backbone.View
  el: $('#root')
  active_panel: 1
  swipe: {}

  initialize: ->
    if App.mobile
      this.$el.wrapInner('<div class="swipe-container">')

      @swipe = new Swipe this.$el[0],
        startSlide: @active_panel
        callback: @animated

      @animated()

  animated: (e, index, el) ->