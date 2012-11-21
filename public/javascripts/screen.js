// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    var hide_help;
    $('#root').css({
      height: $(window).height(),
      visibility: 'visible'
    });
    $('.panel-nav a').on('click', function(e) {
      var $target;
      e.preventDefault();
      $target = $(this.hash);
      $(this).parents('#sidebar').find('.panel').hide();
      return $target.show();
    });
    hide_help = localStorage.help;
    if (!hide_help) {
      $('.help').show();
    }
    $(document).on('click', '.close', function(e) {
      e.preventDefault();
      $(this).parent('.help').hide();
      return localStorage.help = false;
    });
    return $(document).on('click', '#secret', function(e) {
      e.preventDefault();
      return this.setSelectionRange(0, this.value.length);
    });
  });

}).call(this);
