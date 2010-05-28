(function ($) {
    var visible = true;
    
    function createImageSource(settings) {
        var src="http://chart.apis.google.com/chart?chs=800x300&chxt=x,y,r";
        var min = 0;
        var max = 0;
        var data = "";
        var labels = "";
        var colors = "";
        $(settings.table_selector + " tr").each(function() {
            var row = $(this);
            if (!row.hasClass('nodata')) {
                if (data.length != 0) {
                    data += ",";
                    labels += "|";
                    colors += "|";
                }
                var value = row.find(settings.value_selector).html();
                value = value.replace(' \u20ac', '');
                value = value.replace('.', '');
                value = value.replace(',', '.');
                var fvalue = parseFloat(value);
                max = Math.max(max, fvalue);
                min = Math.min(min, fvalue);
                data += value;
                if (settings.use_colors) {
                    colors += fvalue < 0 ? 'cc0000' : '00cc00';
                }
                if (settings.use_labels) {
                    var label = row.find(settings.label_selector).html();
                    labels += label;
                }
            }
        });
        src += "&cht=" + settings.chart_type;
        src += "&chd=t:" + data;
        if (settings.use_labels)
            src += "&chxl=0:|" + labels;
        if (settings.use_colors)
            src += "&chco=" + colors;
        src += "&chds=" + min + "," + max;
        src += "&chxr=1," + min + "," + max;
        return src;
    }

    $.fn.graph = function(table_selector, options) {
        var settings = $.extend({
            use_labels      : false,
            use_colors      : false,
            chart_type      : 'lc',
            table_selector  : table_selector,
            value_selector  : '.value',
            label_selector  : '.label'
        }, options);
        var src = createImageSource(settings);
        return this.each(function() {
            var image = $("<img />").attr('src', src).attr('id', 'generated_chart');
            var graph = $("<div />").append(image).append("<a href='#' id='toggleChart'>Ocultar</a>");
            $(this).append(graph);
        });
    }

    $("#toggleChart").live('click',function() {
        if (visible) {
            $("#generated_chart").hide();
            $("#toggleChart").html("Mostrar gráfico");
        } else {
            $("#generated_chart").show();
            $("#toggleChart").html("Ocultar gráfico");
        }
        visible = !visible;
        return false;
    });

    $(function() {
        $("#calc_graph").graph("#calc_data")
    })

})(jQuery);