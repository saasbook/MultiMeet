/* global $ */
$(document).on('turbolinks:load', function (){
    $('.datepicker').datepicker({multidate: true, format: 'yyyy-mm-dd'});
});