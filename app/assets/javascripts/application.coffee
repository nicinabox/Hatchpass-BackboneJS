window.addEventListener 'load', ->
  new FastClick document.body
, false

$ ->
  # Models
  App.settings = new App.Models.Settings

  # Collections
  App.domains = new App.Collections.Domains

  # Views
  App.settings_view = new App.Views.SettingsView

  App.domains_view = new App.Views.DomainsView
  App.secret_view = new App.Views.SecretView