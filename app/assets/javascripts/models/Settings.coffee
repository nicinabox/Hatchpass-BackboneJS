class App.Models.Settings extends Backbone.Model
  localStorage: new Backbone.LocalStorage('settings')
  defaults:
    key: ''
    length: 10
    caps: true
    symbols: true
    save_all: false

  initialize: ->
    @set key: @newKey()

  newKey: ->
    Crypto.SHA256(new Date().getTime().toString()).substr(0, 5)