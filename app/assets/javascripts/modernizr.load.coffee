window.App =
  Models: {}
  Collections: {}
  Views: {}
  mobile: (/mobile/i).test(navigator.userAgent)

Modernizr.load [
  # Vendor
  "//ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js",
  "/javascripts/vendor/jquery-ui-1.9.1.custom.min.js",
  "/javascripts/vendor/fastclick.js",
  "/javascripts/vendor/lodash.min.js",
  "/javascripts/vendor/backbone-min.js",
  "/javascripts/vendor/backbone.localstorage.js",
  "/javascripts/vendor/json2.js",
  "/javascripts/vendor/Crypto.js",
  "/javascripts/vendor/SHA256.js",
  "/javascripts/jquery.addons.js",

  # Models
  "/javascripts/models/Settings.js",
  "/javascripts/models/Domain.js",
  "/javascripts/models/Secret.js",

  # Collections
  "/javascripts/collections/Domains.js",

  # Views
  "/javascripts/views/SettingsView.js",
  "/javascripts/views/DomainsView.js",
  "/javascripts/views/DomainView.js",
  "/javascripts/views/SecretView.js",
  "/javascripts/application.js",
  "/javascripts/screen.js"

]