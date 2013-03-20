window.App =
  Models: {}
  Collections: {}
  Views: {}
  mobile: (() ->
    (/mobile/i).test(navigator.userAgent) ||
    window.innerWidth < 768
  )()
