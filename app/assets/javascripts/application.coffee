window.addEventListener 'load', ->
  new FastClick document.body
, false

$ ->
  # Models
  App.config = new App.Models.Config

  # Collections
  App.domains = new App.Collections.Domains

  # Views
  App.config_view = new App.Views.ConfigView

  App.domains_view = new App.Views.DomainsView
  App.secret_view = new App.Views.SecretView