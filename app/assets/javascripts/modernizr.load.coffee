window.App =
  Models: {}
  Collections: {}
  Views: {}
  mobile: (() ->
    (/mobile/i).test(navigator.userAgent) ||
    window.innerWidth < 768
  )()

Modernizr.load [
  # Vendor
  "//ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js",
  "/javascripts/vendor/json2.js",
  "/javascripts/vendor/lodash.custom.js",
  "/javascripts/vendor/backbone-min.js",
  "/javascripts/vendor/backbone.localstorage.js",
  "/javascripts/vendor/swipe.min.js",
  "/javascripts/vendor/fastclick.js",
  "/javascripts/vendor/Crypto.js",
  "/javascripts/vendor/SHA256.js",
  "/javascripts/vendor/jquery-ui-1.9.1.custom.min.js",
  "/javascripts/jquery.addons.js",

  # Models
  "/javascripts/models/Config.js",
  "/javascripts/models/Domain.js",
  "/javascripts/models/Secret.js",

  # Collections
  "/javascripts/collections/Domains.js",

  # Views
  "/javascripts/views/SidebarView.js",
  "/javascripts/views/ConfigView.js",
  "/javascripts/views/DomainsView.js",
  "/javascripts/views/DomainView.js",
  "/javascripts/views/SecretView.js",
  "/javascripts/views/SwipeView.js",
  "/javascripts/application.js"

]