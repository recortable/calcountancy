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
    $.cy = $.cy || {}

    $.extend($.cy, {
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

    var TAG_PREFIX_LEN = "tag_".length;
    var MOVEMENT_PREFIX_LEN = "tagging_movement_".length;

    $(function() {
        $("td a.icon").live('click', function() {
            var token = $(this).href();
            return false;
        });

        $(".tag_manager .tags .tag").draggable({
            containment: 'window',
            opacity: 0.7,
            helper: 'clone',
            icon: 'cursor'
        });
        $(".taggings").droppable( {
            tolerance: 'touch' ,
            activeClass: 'active',
            hoverClass: 'drophover' ,
            accept: '.tag',
            drop: function(event, ui) {
                var tag_id = ui.draggable.attr('id').substring(TAG_PREFIX_LEN);
                var movement_id = $(this).attr('id').substring(MOVEMENT_PREFIX_LEN);
                $.post("/taggings.js", {
                    'tag_id' : tag_id,
                    'movement_id' : movement_id
                }, function(data) {
                    eval(data);
                }, "js");
                $(this).html('<p>Guardando...</p>');
            }
        });



    });

    $("a.delete_tagging").live('click', function() {
        if (confirm($(this).attr('alt'))) {
            $.post($(this).attr('href'), {'_method' : 'delete'}, function(data) {
                eval(data);
            }, 'js');
        }
        return false;
    });

    $('#flash').ajaxError(function() {
        $.cy.flash("Se ha producido un error!! :-(");
    });
    $('#flash').ajaxSend(function() {
        $.cy.flash("Enviando, espera un momento...");
    })

})(jQuery);