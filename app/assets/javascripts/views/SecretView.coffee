class window.SecretView extends Backbone.View
  el: $('#new_secret form')
  events:
    'keyup input.required': 'render'
    'focus #secret': 'saveDomain'

  initialize: ->
    app.Settings.bind('change', @render, this);

    $("#domain").autocomplete
      source: app.Domains.pluck 'url'
      autoFocus: true

  saveDomain: (e) ->
    setTimeout ->
      e.target.setSelectionRange 0, e.target.value.length
    , 0

    domain = this.$('#domain').val()
    if (existing_domain = app.Domains.where(url: domain)[0])
      used = existing_domain.get 'used'

      existing_domain.save
        used: (if used then used + 1 else 1)
      app.Domains.sort()

    app.Domains.create
      url: domain
      config: app.Settings.toJSON()
      used: 1

    $("#domain").autocomplete 'option'
    , source: app.Domains.pluck 'url'


  loadMaster: ->
    $('#master').val app.Settings.get 'master'

  focusInput: ->
    focused = false
    $('input.required:visible', this.$el).each ->
      if !@value.length
        $(this).focus()
        focused = true
        false

    unless focused
      $('#secret').focus()


  render: (model) ->
    if model instanceof Backbone.Model
      config = model.get 'config'
    config ||= app.Settings.toJSON()

    secret = new Secret
      master: $('#master').val()
      domain: $('#domain').val()
      config: config

    if secret
      $('#secret').val secret.get 'secret'

      if app.mobile
        $('#secret').show().attr('readonly', false)

      if model.keyCode == 13
        @focusInput()
