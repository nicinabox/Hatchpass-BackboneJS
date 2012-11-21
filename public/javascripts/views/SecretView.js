// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.SecretView = (function(_super) {

    __extends(SecretView, _super);

    function SecretView() {
      return SecretView.__super__.constructor.apply(this, arguments);
    }

    SecretView.prototype.el = $('#new_secret form');

    SecretView.prototype.events = {
      'keyup input.required': 'render',
      'focus #secret': 'saveDomain'
    };

    SecretView.prototype.initialize = function() {
      app.Config.bind('change', this.render, this);
      return $("#domain").autocomplete({
        source: app.Domains.pluck('url'),
        autoFocus: true
      });
    };

    SecretView.prototype.saveDomain = function(e) {
      var domain, existing_domain, used;
      e.target.setSelectionRange(0, e.target.value.length);
      domain = this.$('#domain').val();
      if ((existing_domain = app.Domains.where({
        url: domain
      })[0])) {
        used = existing_domain.get('used');
        existing_domain.save({
          used: (used ? used + 1 : 1)
        });
        app.Domains.sort();
      }
      return app.Domains.create({
        url: domain,
        config: app.Config.toJSON(),
        used: 1
      });
    };

    SecretView.prototype.loadMaster = function() {
      return $('#master').val(app.Config.get('master'));
    };

    SecretView.prototype.focusInput = function() {
      return $('input.required:visible', this.$el).each(function() {
        if (!this.value.length) {
          $(this).focus();
          return false;
        }
      });
    };

    SecretView.prototype.render = function(model) {
      var config, secret;
      if (model instanceof Backbone.Model) {
        config = model.get('config');
      }
      config || (config = app.Config.toJSON());
      secret = new Secret({
        master: $('#master').val(),
        domain: $('#domain').val(),
        config: config
      });
      if (secret) {
        $('#secret').val(secret.get('secret'));
        if (app.mobile) {
          $('#secret').show().attr('readonly', false);
        }
        if (model.keyCode === 13) {
          return $('#secret').focus().select();
        }
      }
    };

    return SecretView;

  })(Backbone.View);

}).call(this);
