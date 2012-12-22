class App.Models.Secret extends Backbone.Model
  defaults:
    domain: ''

  initialize: ->
    @on 'error', (model, errors) ->
      console.log errors

    error = @validate @attributes
    unless error
      @create()

  validate: (attrs) ->
    for own index, value of attrs
      unless attrs[index].length
        return [index, "can't be blank"]

  create: ->
    model       = @toJSON()
    config      = model.config
    symbols     = "!@#]^&*(%[?${+=})_-|/<>".split('')
    domain      = model.domain.toLowerCase()
    [host, tld] = domain.split(".")
    tld         = 'com' unless tld

    hash = Crypto.SHA256("#{config.master}:#{host}.#{tld}")
    hash = Crypto.SHA256("#{hash}#{config.key}").substr(0, config.length)

    nums = 0
    key_num = hash.match(/\d/)[0]
    secret = hash.split(//)
    this_upper = true

    for character in secret
      if character.match(/[a-zA-Z]/) # Letters
        if config.caps == true && !this_upper
          this_upper = true
          secret[_i] = character.match(/[a-zA-Z]/)[0].toUpperCase()
        else
          this_upper = false
      else # Numbers
        if config.symbols == true
          secret_idx = parseInt(_i + key_num / 3)
          sym_idx = nums + _i + (key_num * nums) + (1 * _i)
          unless  (secret[secret_idx] == null) or
                  (secret_idx < 0) or
                  (sym_idx < 0) or
                  (symbols[sym_idx] == null) or
                  (symbols[sym_idx] == undefined)
            secret[secret_idx] += symbols[sym_idx]
        nums += 1

    secret = secret.join('').substr(0, config.length)
    @set secret: secret