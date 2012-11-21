class window.DomainsView extends Backbone.View
  el: $('#domains')

  initialize: ->
    app.Domains.on('add', @addDomain, this)
    app.Domains.on('reset', @addAllDomains, this)
    app.Domains.fetch()

  addDomain: (domain) ->
    if app.Domains.length
      this.$el.find('.no-results').hide()

    view = new DomainView
      model: domain
    this.$('ul').prepend view.render().el

  addAllDomains: ->
    app.Domains.each @addDomain, this