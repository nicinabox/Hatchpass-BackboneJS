window.addEventListener 'load', ->
  new FastClick document.body
, false

window.app ||= {
  mobile: (/mobile/i).test(navigator.userAgent)
}

$ ->

  # Models
  app.Settings = new Settings

  # Collections
  app.Domains = new Domains

  # Views
  app.SettingsView = new SettingsView
    model: app.Settings

  app.DomainsView = new DomainsView
  app.SecretView = new SecretView
  # app.SwipeView = new SwipeView