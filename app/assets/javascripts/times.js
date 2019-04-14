/* global $ */
$(document).on('turbolinks:load', function (){
    $('.datepicker').datepicker({todayHighlight: true, multidate: true, format: 'yyyy-mm-dd'});
});