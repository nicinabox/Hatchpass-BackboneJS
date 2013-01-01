class App.Views.DomainView extends Backbone.View
  tagName: 'li'
  template: _.template $('#recent-domain-template').html()
  events:
    'click .remove': 'clear'
    'click .domain': 'load'

  initialize: ->
    @listenTo @model, 'destroy', @remove

  render: (html) ->
    this.$el.html @template(@model.toJSON())
    this

  clear: (e) ->
    e.preventDefault()
    if confirm "Are you sure you want to remove #{@model.get('url')}?"
      @model.destroy()

    unless App.domains.length
      App.domains_view.$el.find('.no-results').show()

  updateSecret: (e, i, el) ->
    App.secret_view.focusInput()

  load: (e) ->
    e.preventDefault()

    App.swipe_view.once 'animated', @updateSecret, this

    App.secret_view.domain.val @model.get('url')
    App.config_view.render @model
    App.secret_view.render(@model)

    if App.mobile
      App.swipe_view.swipe.next()
    else
      @updateSecret()