// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Views.SecretView = (function(_super) {

    __extends(SecretView, _super);

    function SecretView() {
      return SecretView.__super__.constructor.apply(this, arguments);
    }

    SecretView.prototype.el = $('#new_secret form');

    SecretView.prototype.domain = $('#domain');

    SecretView.prototype.secret = $('#secret');

    SecretView.prototype.events = {
      'reset': 'render',
      'keyup input.required': 'render',
      'focus #secret': 'saveDomain'
    };

    SecretView.prototype.initialize = function() {
      this.listenTo(App.config, 'change', this.render);
      this.listenTo(App.domains, 'add destroy', this.updateAutocomplete);
      return this.domain.autocomplete({
        source: App.domains.pluck('url'),
        autoFocus: true
      });
    };

    SecretView.prototype.saveDomain = function(e) {
      var domain, existing_domain, used;
      setTimeout(function() {
        if (e) {
          return e.target.setSelectionRange(0, e.target.value.length);
        }
      }, 0);
      domain = this.domain.val();
      existing_domain = App.domains.where({
        url: domain
      })[0];
      if (existing_domain) {
        used = existing_domain.get('used');
        existing_domain.save({
          used: (used ? used + 1 : 1)
        });
        App.domains.sort();
      }
      return App.domains.create({
        url: domain,
        config: App.config.toJSON(),
        used: 1
      }, {
        wait: true
      });
    };

    SecretView.prototype.updateAutocomplete = function() {
      return this.domain.autocomplete('option', {
        source: App.domains.pluck('url')
      });
    };

    SecretView.prototype.focusInput = function() {
      var focused;
      focused = false;
      $('input.required:visible', this.$el).each(function() {
        if (!this.value.length) {
          $(this).focus();
          focused = true;
          return false;
        }
      });
      if (!focused) {
        return this.secret.focus();
      }
    };

    SecretView.prototype.render = function(event) {
      var config, model, secret;
      if (event instanceof Backbone.Model) {
        model = event;
        config = model.get('config');
      }
      config || (config = App.config.toJSON());
      secret = new App.Models.Secret({
        domain: this.domain.val(),
        config: config
      });
      this.secret.val(secret.get('secret'));
      if (App.mobile) {
        this.secret.show().attr('readonly', false);
      }
      if (event.keyCode === 13) {
        this.focusInput();
      }
      return App.config_view.setAlert(this.domain.val());
    };

    return SecretView;

  })(Backbone.View);

}).call(this);
