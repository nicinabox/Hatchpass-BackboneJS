class App.Views.ConfigView extends Backbone.View
  el: $('#config')
  tagName: "input"
  alert_template: _.template $('#alert-box-template').html()
  events:
    'change input': 'saveConfig'
    'click .alert-box .close': 'clear'

  initialize: ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'reset', @render

    @model.fetch
      success: (model, resp) =>
        unless _.isEmpty resp
          delete @model.attributes[0]
          @model.set resp[0]

      error: (model, resp) =>
        unless resp
          @render(@model)

  clear: (e) ->
    e.preventDefault()
    App.secret_view.el.reset()
    @setAlert()
    @render(@model)

  render: (model) ->
    config = model.toJSON()
    config = config.config if config.config

    $inputs = this.$el.find('form input')

    $inputs.each ->
      value = config[$(this).attr('name')]

      if $(this).is(':checkbox')
        $(this).attr('checked', value)
      else
        $(this).val(value)

  import: ->
    if localStorage.hp_config
      import_key = localStorage.hp_key
      import_config = JSON.parse(localStorage.hp_config)
      import_master = localStorage.hp_master

      import_config.save_config = import_config.remember
      delete import_config.remember
      delete import_config.algorithm

      @model.set(
        master: import_master
        key: import_key
      )
      @model.set(import_config)
      @model.save()

      localStorage.removeItem('hp_key')
      localStorage.removeItem('hp_config')
      localStorage.removeItem('hp_master')
      console.log "Import successful"
      @render()

  setAlert: (domain = "domain") ->
    if @isGlobal()
      html = ''
    else
      html = @alert_template
        type: 'notice'
        content: "Editing #{domain} config <a href='#' class='close'>&times;</a>"

    this.$('.alert-box').remove()
    this.$el.prepend html

  isGlobal: ->
    _.isEmpty App.secret_view.secret.val()

  saveConfig: ->
    config = this.$('form').serializeObject()

    master = $('#master').val()
    if master.length
      config.master = $('#master').val()

    @model.set config

    if config.save_all
      if @isGlobal()
        @model.save config
      else
        domain = App.secret_view.domain.val()
        if (domain = App.domains.where(url: domain)[0])
          domain.save config: config
          App.secret_view.render(domain)
    else
      @model.destroy()
      localStorage.clear()
