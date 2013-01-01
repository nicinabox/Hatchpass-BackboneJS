class App.Views.SecretView extends Backbone.View
  el: $('#new_secret form')
  domain: $('#domain')
  secret: $('#secret')
  events:
    'reset': 'render'
    'change': 'render'
    'keyup input.required': 'render'
    'focus #secret': 'saveDomain'
    'click .clear': 'clearInput'
    'autocompletechange #domain': 'load'

  initialize: ->
    @listenTo App.config, 'change', @render
    @listenTo App.domains, 'add destroy', @updateAutocomplete

    @domain.autocomplete
      source: App.domains.map (d) ->
        domain = d.toJSON()
        label: domain.url
        id: domain.id
      autoFocus: true

  saveDomain: (e) ->
    if e
      if App.mobile
        e.target.setSelectionRange 0, e.target.value.length
      else
        setTimeout ->
          e.target.setSelectionRange 0, e.target.value.length
        , 0

    if App.config.get('save_all')
      domain = @domain.val()
      existing_domain = App.domains.where(url: domain)[0]

      if (existing_domain)
        used = existing_domain.get 'used'

        existing_domain.save
          used: (if used then used + 1 else 1)
        App.domains.sort()

      App.domains.create
        url: domain
        config: App.config.toJSON()
        used: 1
      , wait: true

  updateAutocomplete: ->
    @domain.autocomplete 'option',
      source: App.domains.pluck 'url'

  focusInput: ->
    focused = false
    $('input.required:visible', this.$el).each ->
      if !@value.length
        $(this).focus()
        focused = true
        false

    unless focused
      @secret[0].focus()

  toggleInputClears: ->
    this.$('input').each ->
      if $(this).val().length
        $(this).prev('.clear').fadeIn('fast');
      else
        $(this).prev('.clear').fadeOut('fast');

  clearInput: (e) ->
    e.preventDefault()
    $(e.target).next('input')
      .val('')
      .focus()
      .trigger('change')

  load: (e, domain) ->
    model = App.domains.get domain.item.id
    @render model

  render: (event) ->
    if event instanceof Backbone.Model
      model  = event
      config = model.get 'config'
      App.config_view.render model

    config ||= App.config.toJSON()

    @toggleInputClears()

    secret = new App.Models.Secret
      domain: @domain.val()
      config: config

    @secret.val secret.get 'secret'

    if App.mobile
      @secret.show().attr('readonly', false)

    if event.keyCode == 13
      @focusInput()

    App.config_view.setAlert(@domain.val())