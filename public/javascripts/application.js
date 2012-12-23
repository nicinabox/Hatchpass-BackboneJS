// Generated by CoffeeScript 1.4.0
(function() {

  window.addEventListener('load', function() {
    return new FastClick(document.body);
  }, false);

  $(function() {
    App.config = new App.Models.Config;
    App.domains = new App.Collections.Domains;
    App.config_view = new App.Views.ConfigView({
      model: App.config
    });
    App.domains_view = new App.Views.DomainsView;
    return App.secret_view = new App.Views.SecretView;
  });

}).call(this);
