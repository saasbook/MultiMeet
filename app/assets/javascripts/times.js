/* global $ */
/* global displayDate */


$(document).on('turbolinks:load', 
    function (){
        $('.datepicker').datepicker({todayHighlight: true, multidate: true, format: 'yyyy-mm-dd'});
    }
);

$(document).on('turbolinks:load',
    function(){
        $('.datepicker').datepicker().on('changeDate', function(e){
            var string = $('.datepicker').val();
            var dateArray = string.split(",");
            var formatted = ""
            
            for (var i = 0; i < dateArray.length && string.length > 0; i++){
                var unformatted = dateArray[i]
                var niceFormat = formatDate(unformatted);
                var element = "#"+unformatted;
                
                if ($(element).length == 0){
                    var dateDiv = document.createElement("div");
                    dateDiv.setAttribute('id', unformatted);
                    var textNode = document.createTextNode(niceFormat);
                    dateDiv.appendChild(textNode);
                    $('#times-table').append(dateDiv);
                }
                
                formatted += niceFormat + '\n'
            }
            
            deleteDiv(dateArray);
            
            if (formatted.includes("undefined")) {
                $(".dates-chosen").text("No dates chosen.");
                $("#times-table").empty();
            }
            else{
                $(".dates-chosen").text(formatted);
            }
        })
    }
);

function deleteDiv(dateArray){
    var copy = $("#times-table").children("div");
    copy.each(function(){
        var id = $(this)[0].id;
        var strid = "#" + id;
        if (!dateArray.includes(id)){
            $(strid).remove();
        }
    });
}

function formatDate(date){
    var monthNames = [
    "January", "February", "March",
    "April", "May", "June", "July",
    "August", "September", "October",
    "November", "December"
   ];
   
   var dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
   var d = new Date(date);
   var dayInt = d.getDay(); 
   var day = date.split("-")[2]
   var month = parseInt(date.split("-")[1], 10)
   var year = date.split("-")[0]
   
   return dayNames[dayInt] + " , " + monthNames[month] + ' ' + day
}

// $(document).on('turbolinks:load', 
// function (){
//     document.getElementById("very-unique").addEventListener('input', displayDate);
//     function displayDate(e){
//         const output = document.getElementById("put-times");
//         output.textContent = e.srcElement.value;
//     }
// });




