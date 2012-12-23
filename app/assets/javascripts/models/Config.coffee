class App.Models.Config extends Backbone.Model
  localStorage: new Backbone.LocalStorage('config')
  defaults: ->
    key: @newKey()
    length: 10
    caps: true
    symbols: true
    save_all: false

  newKey: ->
    Crypto.SHA256(new Date().getTime().toString()).substr(0, 5)