$(window).on 'resize', (e) ->
  setTimeout =>
    $('#root').height($(this).height())
  , 200

$ ->
  new FastClick document.body

  $('#root').css
    visibility: 'visible'
    height: $(window).height()

  # Models
  App.config = new App.Models.Config

  # Collections
  App.domains = new App.Collections.Domains

  # Views
  App.swipe_view = new App.Views.SwipeView
  App.sidebar_view = new App.Views.SidebarView
  App.config_view = new App.Views.ConfigView
    model: App.config
  App.domains_view = new App.Views.DomainsView
  App.secret_view = new App.Views.SecretView
