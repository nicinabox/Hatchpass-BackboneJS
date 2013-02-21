// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.SwipeView = (function(_super) {

    __extends(SwipeView, _super);

    function SwipeView() {
      return SwipeView.__super__.constructor.apply(this, arguments);
    }

    SwipeView.prototype.el = $('.panel-nav');

    SwipeView.prototype.active_panel = 1;

    SwipeView.prototype.events = {
      'click a': 'animate'
    };

    SwipeView.prototype.initialize = function() {
      var _this = this;
      this.swipe = new Swipe($('#swipe')[0], {
        startSlide: this.active_panel,
        callback: function(e, index, el) {
          return _this.animated(e, index, el);
        }
      });
      this.animated();
      return app.SecretView.focusInput();
    };

    SwipeView.prototype.animated = function(e, index, el) {
      var $active, $nav, $next, $panel, $prev, next, position, prev;
      $nav = $('.panel-nav');
      $panel = $('#swipe .panel');
      position = this.swipe.getPos();
      $active = $panel.eq(position);
      $next = $('.next', $nav);
      $prev = $('.prev', $nav);
      next = (position <= this.swipe.length ? position + 1 : position);
      prev = (position > 0 ? position - 1 : 0);
      if (navigator.userAgent.match(/ipad/i) || !app.mobile) {
        $nav.fadeIn('fast');
      }
      if (position === (this.swipe.length - 1)) {
        $next.hide();
        $prev.show();
        return $('span', $prev).text($panel.eq(prev).data('title'));
      } else if (position === 0) {
        $next.show();
        $prev.hide();
        return $('span', $next).text($panel.eq(next).data('title'));
      } else {
        $next.show();
        $prev.show();
        $('span', $prev).text($panel.eq(prev).data('title'));
        return $('span', $next).text($panel.eq(next).data('title'));
      }
    };

    SwipeView.prototype.animate = function(e) {
      var direction;
      e.preventDefault();
      direction = $(e.target).data('direction');
      if (direction === 'next') {
        return this.swipe.next();
      } else {
        return this.swipe.prev();
      }
    };

    return SwipeView;

  })(Backbone.View);

}).call(this);