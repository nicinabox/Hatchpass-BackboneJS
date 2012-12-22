class App.Views.SecretView extends Backbone.View
  el: $('#new_secret form')
  domain: $('#domain')
  secret: $('#secret')
  events:
    'keyup input.required': 'render'
    'focus #secret': 'saveDomain'

  initialize: ->
    App.settings.on('change', @render, this);
    App.domains.on('add destroy', @updateAutocomplete, this);

    @domain.autocomplete
      source: App.domains.pluck 'url'
      autoFocus: true

  saveDomain: (e) ->
    setTimeout ->
      e.target.setSelectionRange 0, e.target.value.length if e
    , 0

    domain = @domain.val()
    if (existing_domain = App.domains.where(url: domain)[0])
      used = existing_domain.get 'used'

      existing_domain.save
        used: (if used then used + 1 else 1)
      App.domains.sort()

    App.domains.create
      url: domain
      config: App.Settings.toJSON()
      used: 1

  updateAutocomplete: ->
    @domain.autocomplete 'option'
    , source: App.domains.pluck 'url'

  focusInput: ->
    focused = false
    $('input.required:visible', this.$el).each ->
      if !@value.length
        $(this).focus()
        focused = true
        false

    unless focused
      @secret.focus()

  render: (model) ->
    if model instanceof Backbone.Model
      # console.log 'load config from model'

      config = model.get 'config'
      # console.log config

    config ||= App.settings.toJSON()
    # console.log config.length

    secret = new Secret
      domain: @domain.val()
      config: config

    if secret
      @secret.val secret.get 'secret'

      if App.mobile
        @secret.show().attr('readonly', false)

      if model.keyCode == 13
        @focusInput()

      App.SettingsView.setAlert(@domain.val())
