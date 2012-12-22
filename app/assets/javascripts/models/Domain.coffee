class App.Models.Domain extends Backbone.Model
  initialize: ->
    @bind 'error', (model, errors) ->
      # console.log errors

  validate: (domain) ->
    errors = []
    domains = App.domains.pluck('url')

    if !domain.id and _.include domains, domain.url
      errors.push "URL must be unique"

    if _.isEmpty domain.url
      errors.push "URL cannot be blank"

    unless _.isEmpty(errors)
      errors
