class App.Views.DomainsView extends Backbone.View
  el: $('#domains')

  initialize: ->
    App.domains.on('add', @addDomain, this)
    App.domains.on('reset', @addAllDomains, this)
    App.domains.fetch()

  addDomain: (domain) ->
    if App.domains.length
      this.$el.find('.no-results').hide()

    view = new App.Views.DomainView
      model: domain
    this.$('ul').prepend view.render().el

  addAllDomains: ->
    this.$('ul li').not('.no-results').remove()
    App.domains.each @addDomain, this