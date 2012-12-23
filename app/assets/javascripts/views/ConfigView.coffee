class App.Views.ConfigView extends Backbone.View
  el: $('#config')
  tagName: "input"
  alert_template: _.template $('#alert-box-template').html()
  events:
    'change input': 'saveConfig'

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

  render: (model) ->
    config = model.toJSON()
    config = config.config if config.config

    for own key, value of config
      switch $("[name=#{key}]").last().attr('type')
        when "checkbox"
          $("[name=#{key}]").attr('checked', value)
          break
        else
          $("[name=#{key}]").val(value)
          break

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
    unless @isGlobal()
      html = @alert_template
        type: 'notice'
        content: "Editing #{domain} config"

      this.$el.find('.alert-box').remove()
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
        console.log 'saving config GLOBALY'
        @model.save config

      else
        domain = App.secret_view.domain.val()
        if (domain = App.domains.where(url: domain)[0])
          console.log 'saving config for MODEL'
          domain.save config: config
    else
      @model.destroy()