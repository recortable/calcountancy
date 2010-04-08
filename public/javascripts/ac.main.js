(function($) {

    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function() {
            }
        };
    }

    $.cy = $.cy || {}
    
    $.extend($.cy, {
    });

    $(function() {
        $("td a.icon").live('click', function() {
            var token = $(this).href();
            alert(token);
            return false;
        });
    });

})(jQuery);