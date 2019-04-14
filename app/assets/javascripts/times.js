/* global $ */

/* Datepicker */
$(document).on('turbolinks:load', 
    function (){
        $('.datepicker').datepicker({todayHighlight: true, multidate: true, format: 'yyyy-mm-dd'});
    }
);

/* Show highlighted datepicker dates */
$(document).on('turbolinks:load',
    function(){
        $('.datepicker').datepicker().on('changeDate', function(e){
            var string = $('.datepicker').val();
            var dateArray = string.split(",");
            var formatted = "";
            
            for (var i = 0; i < dateArray.length && string.length > 0; i++){
                var unformatted = dateArray[i];
                var niceFormat = formatDate(unformatted);
                var element = "#"+unformatted;
                if ($(element).length == 0){
                    addDiv(unformatted);
                }
                formatted += niceFormat + '\n';
            }
            
            deleteDiv(dateArray);
            $(".dates-chosen").text(formatted);
        });
    }
);

/* Add Button functionality */
$(document).on('click', '.addbutton', function(){
    var parent_id = $(this).parent().attr('id');
    var element = document.getElementById(parent_id);
    var strid = "#"+parent_id;
    var entry = createTimeEntry(parent_id);
    element.append(entry);
    console.log($(strid).children());
    console.log($(strid).children().last());
    $(strid).children().last().append('<span><button type="button" class="deletebutton btn btn-danger btn-sm">Delete Timeslot</button></span>');
});

/* Delete Button functionality */
$(document).on('click', '.deletebutton', function(){
    var parent = $(this).parent().parent();
    parent.remove();
});


/* Time Entry Row */
function createTimeEntry(divId){
    var startInput = document.createElement("input");
    startInput.type = "time";
    startInput.value = "12:00";
    startInput.step = "900";
    startInput.name = "times["+divId +"][]";
    var endInput = document.createElement("input");
    endInput.type = "time";
    endInput.value = "13:00";
    endInput.step = "900";
    endInput.name = "times["+divId +"][]";
    
    var outerDiv = document.createElement("div");
    var startTime = document.createElement("span");
    var endTime = document.createElement("span");
    var startText = document.createTextNode("Start Time ");
    var endText = document.createTextNode("End Time ");
    startTime.appendChild(startText);
    endTime.appendChild(endText);
    startTime.append(startInput);
    endTime.append(endInput);
    outerDiv.appendChild(startTime);
    outerDiv.appendChild(endTime);
    return outerDiv;
}
    
/* Add a date div */
function addDiv(divId){
    var niceFormat = formatDate(divId);
    var dateDiv = document.createElement("div");
    dateDiv.setAttribute('id', divId);
    dateDiv.setAttribute('class', "times-table-date");
    
    var addButton = document.createElement("button");
    addButton.type = "button";
    var addText = document.createTextNode("Add Timeslot");
    addButton.setAttribute("class", "addbutton btn btn-primary btn-sm");
    addButton.appendChild(addText);
    
    var outerDiv = createTimeEntry(divId);
    
    var textNode = document.createTextNode(niceFormat);
    dateDiv.appendChild(textNode);
    dateDiv.appendChild(addButton);
    dateDiv.appendChild(outerDiv);
    $('#times-table').append(dateDiv);
}

/* Delete a date div */
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
   
   return dayNames[dayInt] + ", " + monthNames[month] + ' ' + day
}