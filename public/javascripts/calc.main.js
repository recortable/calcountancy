(function($) {

    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function() {
            }
        };
    }

    $(document).ajaxSend(function(event, request, settings) {
        if (typeof(AUTH_TOKEN) == "undefined") return;
        // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
        settings.data = settings.data || "";
        settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
    });


    var flash_timeout = null;
    $.calc = $.calc || {}

    $.extend($.calc, {
        flash : function(message) {
            $("#flash").html("<p>" + message + "<p>");
            if (flash_timeout != null) {
                window.clearTimeout(flash_timeout);
            }
            flash_timeout = window.setTimeout(function() {
                flash_timeout = null;
                $('#flash p').fadeOut('slow');
            }, 3000);
        }
    });

    $(function() {
        var am = $("form.action_manager");
        am.attr('action', am.attr('action') + ".js")
        $("input.selector").click(function() {
            $(this).parent().parent().toggleClass('selected');
            $(".selected_counter").html($("tr.selected").size());
        });
        $("form.action_manager").submit(function() {
            var ids = []
            $("input.selector:checked").each(function() {
                ids.push($(this).attr('value'));
            });
            $("#bulk_action_movement_ids").attr('value', ids.join(','));
            $(this).ajaxSubmit();
            return false;
        });


    $("a.delete_tagging").live('click', function() {
        if (confirm($(this).attr('alt'))) {
            $.post($(this).attr('href'), {
                '_method' : 'delete'
            }, function(data) {
                eval(data);
            }, 'js');
        }
        return false;
    });
    });

$('#flash').ajaxError(function() {
    $.calc.flash("Se ha producido un error!! :-(");
});
$('#flash').ajaxSend(function() {
    $.calc.flash("Enviando, espera un momento...");
})

})(jQuery);