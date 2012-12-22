class App.Models.Config extends Backbone.Model
  localStorage: new Backbone.LocalStorage('config')
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