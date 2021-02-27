/* * * * * * * * * * * * * * * * * *
* Show/hide fields conditionally
* * * * * * * * * * * * * * * * * */

$(document).ready(function(){

  (function($) {
    $.fn.conditionize = function(options){

       var settings = $.extend({
          hideJS: true
      }, options );

      $.fn.showOrHide = function(listenTo, listenFor, $section) {
        if ($(listenTo).is('select, input[type=text]') && $(listenTo).val() == listenFor ) {
          $section.show();
        }
        else if ($(listenTo + ":checked").val() == listenFor) {
          $section.show();
          $section.removeClass("subject-matter");
          if ($section.hasClass('sub')) {
            $('.subject-matter').toggle();
          }
        }
        else {
          $section.hide();
        }
      }

      return this.each( function() {
        var listenTo = "[name=" + $(this).data('cond-option') + "]";
        var listenFor = $(this).data('cond-value');
        var $section = $(this);

        //Set up event listener
        $(listenTo).on('change', function() {
          $.fn.showOrHide(listenTo, listenFor, $section);
        });
        //If setting was chosen, hide everything first...
        if (settings.hideJS) {
          $(this).hide();
        }
        //Show based on current value on page load
        $.fn.showOrHide(listenTo, listenFor, $section);
      });
    }
  }(jQuery));

  $('.conditional').conditionize();
});
