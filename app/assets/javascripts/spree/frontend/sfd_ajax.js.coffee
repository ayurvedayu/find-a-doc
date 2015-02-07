$ ->
  $("[data-slot-date-select]").change ->
    $('.slots-group').html("<div class='ajax-loading'>Loading...</div>")
    $.ajax
      url: '/timings'
      data:
        doctor_employee_id: $(this).data("slotDrId")
        month: $('#date_month').val()
        day: $('#date_day').val()
      error: ->
        $('.slots-group').html(
          "<div class='panel panel-danger'>
          <div class='panel-heading'>Error</div>
          <div class='panel-body'>Try again by choosing a day please.</div>
          </div>")