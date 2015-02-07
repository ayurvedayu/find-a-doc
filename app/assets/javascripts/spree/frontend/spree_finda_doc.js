// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'
//= require bootstrap-sprockets
//= require jquery-ui/slider
//= require_tree .

$(function() {

    $("#clinic_map_tab_link").on('shown.bs.tab',function(e){   
        google.maps.event.trigger(window.map, "resize");
        window.map.setCenter(window.clinic_position)
    });

    $(".slider-input").prop("readonly", "true")

    $(".slider-time-range").slider({
        range: true,
        min: 0,
        max: 1440,
        step: 30,
        values: [600,1200],
        create: function(e, ui){
            var hours_from = Math.floor(600 / 60);
            var hours_to = Math.floor(1200 / 60);
            var minutes_from = 600 - (hours_from * 60);
            var minutes_to = 1200 - (hours_to * 60);

            if(hours_from.toString().length == 1) hours_from = '0' + hours_from;
            if(hours_to.toString().length == 1) hours_to = '0' + hours_to;
            if(minutes_from.toString().length == 1) minutes_from = '0' + minutes_from;
            if(minutes_to.toString().length == 1) minutes_to = '0' + minutes_to;

            var time_from = hours_from+':'+minutes_from;
            var time_to =  hours_to+':'+minutes_to;
            // $(this).parent().find('.slider-value-from').html(time_from);
            $(this).parent().find('.slider-input-from').val(time_from);
            // $(this).parent().find('.slider-value-to').html(time_to);
            $(this).parent().find('.slider-input-to').val(time_to);
        },
        slide: function(e, ui) {
            var hours_from = Math.floor(ui.values[0] / 60);
            var hours_to = Math.floor(ui.values[1] / 60);
            var minutes_from = ui.values[0] - (hours_from * 60);
            var minutes_to = ui.values[1] - (hours_to * 60);

            if(hours_from.toString().length == 1) hours_from = '0' + hours_from;
            if(hours_to.toString().length == 1) hours_to = '0' + hours_to;
            if(minutes_from.toString().length == 1) minutes_from = '0' + minutes_from;
            if(minutes_to.toString().length == 1) minutes_to = '0' + minutes_to;

            var time_from = hours_from+':'+minutes_from;
            var time_to =  hours_to+':'+minutes_to;
            // $(this).parent().find('.slider-value-from').html(time_from);
            $(this).parent().find('.slider-input-from').val(time_from);
            // $(this).parent().find('.slider-value-to').html(time_to);
            $(this).parent().find('.slider-input-to').val(time_to);
        }
    });

});