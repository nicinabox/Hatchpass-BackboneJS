class App.Views.DomainView extends Backbone.View
  tagName: 'li'
  template: _.template $('#recent-domain-template').html()
  events:
    'click .remove': 'clear'
    'click .domain': 'load'

  initialize: ->
    @model.on('destroy', @remove, this);

  render: (html) ->
    this.$el.html @template @model.toJSON()
    this

  clear: (e) ->
    e.preventDefault();
    @model.destroy()

    unless App.domains.length
      App.domains_view.$el.find('.no-results').show()

  load: (e) ->
    e.preventDefault()
    console.log @model.toJSON()
    App.secret_view.domain.val @model.get 'url'
    App.secret_view.render @model
    App.secret_view.focusInput()
    App.settings_view.render @model
