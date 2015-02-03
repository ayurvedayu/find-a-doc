// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'
//= require bootstrap-sprockets
//= require jquery-ui

$(function() {
    $(".slider-time-range").slider({
        range: true,
        min: 0,
        max: 1440,
        step: 30,
        values: [600,1200],
        slide: function(e, ui) {
            var hours_from = Math.floor(ui.values[0] / 60);
            var hours_to = Math.floor(ui.values[1] / 60);
            var minutes_from = ui.values[0] - (hours_from * 60);
            var minutes_to = ui.values[1] - (hours_to * 60);

            if(hours_from.toString().length == 1) hours_from = '0' + hours_from;
            if(hours_to.toString().length == 1) hours_to = '0' + hours_to;
            if(minutes_from.toString().length == 1) minutes_from = '0' + minutes_from;
            if(minutes_to.toString().length == 1) minutes_to = '0' + minutes_to;

            $(this).parent().find('.slider-value-from').html(hours_from+':'+minutes_from);
            $(this).parent().find('.slider-value-to').html(hours_to+':'+minutes_to);
        }
    });
});