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

    // $(".slider-input").prop("readonly", "true")

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
            if ($(this).parent().find('.slider-time-input-from').val() == '' && 
            $(this).parent().find('.slider-time-input-to').val() == '' ){
                $(this).parent().find('.slider-time-input-from').val(time_from);
                $(this).parent().find('.slider-time-input-to').val(time_to);
            }else{
                time_from = $(this).parent().find('.slider-time-input-from').val()
                time_to = $(this).parent().find('.slider-time-input-to').val()

                var sl_time_from, sl_time_to;
                fa = time_from.split(':');
                ta = time_to.split(':');

                sl_time_from = fa[0] * 60 + parseInt(fa[1])
                sl_time_to = ta[0] * 60 + parseInt(ta[1])
                $(this).slider("values", [sl_time_from, sl_time_to])
            }
                $(this).parent().find('.slider-time-value').html(time_from + ' - '+ time_to);
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
            $(this).parent().find('.slider-time-input-from').val(time_from);
            $(this).parent().find('.slider-time-input-to').val(time_to);
            $(this).parent().find('.slider-time-value').html(time_from + ' - ' + time_to);
        }
    });

    $(".slider-price-range").slider({
        range: true,
        min: 0,
        max: 1000,
        step: 50,
        values: [0,1000],
        create: function(e, ui){
            if ($(this).parent().find('.slider-price-input-from').val() == '' && 
            $(this).parent().find('.slider-price-input-to').val() == '' ){
                $(this).parent().find('.slider-price-input-from').val(0);
                $(this).parent().find('.slider-price-input-to').val(1000);
                $(this).parent().find('.slider-price-value').html('Free - 1000');
            }else{
                var price_from = $(this).parent().find('.slider-price-input-from').val();
                var price_from_for_value = price_from == '0' ? 'Free' : price_from;
                var price_to = $(this).parent().find('.slider-price-input-to').val();
                var price_to_for_value = price_to == '0' ? 'Free' : price_to;
                $(this).slider("values", [price_from, price_to])
                $(this).parent().find('.slider-price-value').html(price_from_for_value + ' - ' + price_to_for_value);
            }
        },
        slide: function(e, ui) {
            var price_from = ui.values[0];
            var price_from_for_value = ui.values[0] == '0' ? 'Free' : ui.values[0];
            var price_to = ui.values[1];
            var price_to_for_value = ui.values[1] == '0' ? 'Free' : ui.values[1];

            $(this).parent().find('.slider-price-input-from').val(price_from);
            $(this).parent().find('.slider-price-input-to').val(price_to);
            $(this).parent().find('.slider-price-value').html(price_from_for_value + ' - ' + price_to_for_value);
        }
    });
});