// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Secret = (function(_super) {

    __extends(Secret, _super);

    function Secret() {
      return Secret.__super__.constructor.apply(this, arguments);
    }

    Secret.prototype.defaults = {
      master: '',
      domain: ''
    };

    Secret.prototype.initialize = function() {
      var error;
      this.bind('error', function(model, errors) {});
      error = this.validate(this.attributes);
      if (!error) {
        return this.create();
      }
    };

    Secret.prototype.validate = function(attrs) {
      var index, value;
      for (index in attrs) {
        if (!__hasProp.call(attrs, index)) continue;
        value = attrs[index];
        if (!attrs[index].length) {
          return [index, "can't be blank"];
        }
      }
    };

    Secret.prototype.create = function() {
      var config, domain, hash, host, item, key_num, nums, secret, secret_idx, sym_idx, symbols, this_upper, tld, _i, _len, _ref;
      config = this.attributes.config;
      symbols = "!@#]^&*(%[?${+=})_-|/<>".split('');
      domain = this.attributes.domain.toLowerCase();
      _ref = domain.split("."), host = _ref[0], tld = _ref[1];
      if (!tld) {
        tld = 'com';
      }
      hash = Crypto.SHA256("" + this.attributes.master + ":" + host + "." + tld);
      hash = Crypto.SHA256("" + hash + config.key).substr(0, config.length);
      nums = 0;
      key_num = hash.match(/\d/)[0];
      secret = hash.split(/(?:)/);
      this_upper = true;
      for (_i = 0, _len = secret.length; _i < _len; _i++) {
        item = secret[_i];
        if (item.match(/[a-zA-Z]/)) {
          if (config.caps === true && !this_upper) {
            this_upper = true;
            secret[_i] = item.match(/[a-zA-Z]/)[0].toUpperCase();
          } else {
            this_upper = false;
          }
        } else {
          if (config.symbols === true) {
            secret_idx = parseInt(_i + key_num / 3);
            sym_idx = nums + _i + (key_num * nums) + (1 * _i);
            if (!((secret[secret_idx] === null) || (secret_idx < 0) || (sym_idx < 0) || (symbols[sym_idx] === null) || (symbols[sym_idx] === void 0))) {
              secret[secret_idx] += symbols[sym_idx];
            }
          }
          nums += 1;
        }
      }
      secret = secret.join('').substr(0, config.length);
      return this.set({
        secret: secret
      });
    };

    return Secret;

  })(Backbone.Model);

}).call(this);
