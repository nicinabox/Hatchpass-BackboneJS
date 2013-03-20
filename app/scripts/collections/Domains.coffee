class App.Collections.Domains extends Backbone.Collection
  localStorage: new Backbone.LocalStorage('domains')
  model: App.Models.Domain

  comparator: (domain) ->
    domain.get 'used'