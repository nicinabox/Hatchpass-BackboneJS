class window.SecretView extends Backbone.View
  el: $('#new_secret form')
  events:
    'keyup input.required': 'render'
    'focus #secret': 'saveDomain'

  initialize: ->
    app.Config.bind('change', @render, this);

    $("#domain").autocomplete
      source: app.Domains.pluck 'url'
      autoFocus: true

  saveDomain: (e) ->
    e.target.setSelectionRange 0, e.target.value.length
    domain = this.$('#domain').val()

    if (existing_domain = app.Domains.where(url: domain)[0])
      used = existing_domain.get 'used'

      existing_domain.save
        used: (if used then used + 1 else 1)
      app.Domains.sort()

    app.Domains.create
      url: domain
      config: app.Config.toJSON()
      used: 1

  loadMaster: ->
    $('#master').val app.Config.get 'master'

  focusInput: ->
    $('input.required:visible', this.$el).each ->
      if !@value.length
        console.log $(this)
        $(this).focus()
        false

  render: (model) ->
    if model instanceof Backbone.Model
      config = model.get 'config'
    config ||= app.Config.toJSON()

    secret = new Secret
      master: $('#master').val()
      domain: $('#domain').val()
      config: config

    if secret
      $('#secret').val secret.get 'secret'

      if app.mobile
        $('#secret').show().attr('readonly', false)

      if model.keyCode == 13
        $('#secret').focus().select()
