// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Views.ConfigView = (function(_super) {

    __extends(ConfigView, _super);

    function ConfigView() {
      return ConfigView.__super__.constructor.apply(this, arguments);
    }

    ConfigView.prototype.el = $('#config');

    ConfigView.prototype.tagName = "input";

    ConfigView.prototype.alert_template = _.template($('#alert-box-template').html());

    ConfigView.prototype.events = {
      'change input': 'saveConfig',
      'click .alert-box .close': 'clear'
    };

    ConfigView.prototype.initialize = function() {
      var _this = this;
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'reset', this.render);
      return this.model.fetch({
        success: function(model, resp) {
          if (!_.isEmpty(resp)) {
            delete _this.model.attributes[0];
            return _this.model.set(resp[0]);
          }
        },
        error: function(model, resp) {
          if (!resp) {
            return _this.render(_this.model);
          }
        }
      });
    };

    ConfigView.prototype.clear = function(e) {
      e.preventDefault();
      App.secret_view.el.reset();
      this.setAlert();
      return this.render(this.model);
    };

    ConfigView.prototype.render = function(model) {
      var config, key, value, _results;
      config = model.toJSON();
      if (config.config) {
        config = config.config;
      }
      _results = [];
      for (key in config) {
        if (!__hasProp.call(config, key)) continue;
        value = config[key];
        switch ($("[name=" + key + "]").last().attr('type')) {
          case "checkbox":
            $("[name=" + key + "]").attr('checked', value);
            break;
          default:
            $("[name=" + key + "]").val(value);
            break;
        }
      }
      return _results;
    };

    ConfigView.prototype["import"] = function() {
      var import_config, import_key, import_master;
      if (localStorage.hp_config) {
        import_key = localStorage.hp_key;
        import_config = JSON.parse(localStorage.hp_config);
        import_master = localStorage.hp_master;
        import_config.save_config = import_config.remember;
        delete import_config.remember;
        delete import_config.algorithm;
        this.model.set({
          master: import_master,
          key: import_key
        });
        this.model.set(import_config);
        this.model.save();
        localStorage.removeItem('hp_key');
        localStorage.removeItem('hp_config');
        localStorage.removeItem('hp_master');
        console.log("Import successful");
        return this.render();
      }
    };

    ConfigView.prototype.setAlert = function(domain) {
      var html;
      if (domain == null) {
        domain = "domain";
      }
      if (this.isGlobal()) {
        html = '';
      } else {
        html = this.alert_template({
          type: 'notice',
          content: "Editing " + domain + " config <a href='#' class='close'>&times;</a>"
        });
      }
      this.$('.alert-box').remove();
      return this.$el.prepend(html);
    };

    ConfigView.prototype.isGlobal = function() {
      return _.isEmpty(App.secret_view.secret.val());
    };

    ConfigView.prototype.saveConfig = function() {
      var config, domain, master;
      config = this.$('form').serializeObject();
      master = $('#master').val();
      if (master.length) {
        config.master = $('#master').val();
      }
      this.model.set(config);
      if (config.save_all) {
        if (this.isGlobal()) {
          return this.model.save(config);
        } else {
          domain = App.secret_view.domain.val();
          if ((domain = App.domains.where({
            url: domain
          })[0])) {
            return domain.save({
              config: config
            });
          }
        }
      } else {
        this.model.destroy();
        return localStorage.clear();
      }
    };

    return ConfigView;

  })(Backbone.View);

}).call(this);
