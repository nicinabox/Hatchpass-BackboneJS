class App.Views.SettingsView extends Backbone.View
  el: $('#settings')
  tagName: "input"
  alert_template: _.template $('#alert-box-template').html()
  events:
    'change input': 'saveSettings'

  initialize: ->
    @model.on('change', @render, this)
    @model.on('reset', @render, this)
    @model.fetch()

  import: ->
    if localStorage.hp_settings
      import_key = localStorage.hp_key
      import_settings = JSON.parse(localStorage.hp_settings)
      import_master = localStorage.hp_master

      import_settings.save_settings = import_settings.remember
      delete import_settings.remember
      delete import_settings.algorithm

      @model.set(
        master: import_master
        key: import_key
      )
      @model.set(import_settings)
      @model.save()

      localStorage.removeItem('hp_key')
      localStorage.removeItem('hp_settings')
      localStorage.removeItem('hp_master')
      console.log "Import successful"
      @render()

  render: (model) ->
    settings = model.toJSON()[0]
    for own key, value of settings
      switch $("[name=#{key}]").last().attr('type')
        when "checkbox"
          $("[name=#{key}]").attr('checked', value)
          break
        else
          $("[name=#{key}]").val(value)
          break

  setAlert: (domain = "domain") ->
    unless @isGlobal()
      html = @alert_template
        type: 'notice'
        content: "Editing #{domain} settings"

      this.$el.find('.alert-box').remove()
      this.$el.prepend html

  isGlobal: ->
    _.isEmpty app.SecretView.secret.val()

  saveSettings: ->
    config = $('form', @el).serializeObject()

    master = $('#master').val()
    if master.length > 0
      config.master = $('#master').val()

    @model.set config

    if config.save_all
      @model.save config
    else
      @model.destroy()