// Generated by CoffeeScript 1.4.0
(function() {

  $(function() {
    var hide_help;
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
