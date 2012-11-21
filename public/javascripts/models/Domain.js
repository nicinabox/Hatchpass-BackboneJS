// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Domain = (function(_super) {

    __extends(Domain, _super);

    function Domain() {
      return Domain.__super__.constructor.apply(this, arguments);
    }

    Domain.prototype.initialize = function() {
      return this.bind('error', function(model, errors) {});
    };

    Domain.prototype.validate = function(domain) {
      var domains, errors;
      errors = [];
      domains = app.Domains.pluck('url');
      if (!domain.id && _.include(domains, domain.url)) {
        errors.push("URL must be unique");
      }
      if (_.isEmpty(domain.url)) {
        errors.push("URL cannot be blank");
      }
      if (!_.isEmpty(errors)) {
        return errors;
      }
    };

    return Domain;

  })(Backbone.Model);

}).call(this);
