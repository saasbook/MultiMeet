/* global $ */

/* Datepicker*/
$(document).on('turbolinks:load', 
    function() {
        $('.datepicker').datepicker({startDate: new Date(), clearBtn: true, todayHighlight: true, multidate: true, format: 'yyyy-mm-dd', constrainInput: false});
    }
);

/* Show highlighted datepicker dates */
$(document).on('turbolinks:load',
    function(){
        $('.datepicker').datepicker().on('changeDate', function(e){
            var string = $('.datepicker').val();
            var dateArray = string.split(",");
            var formatted = "";
            dateArray.sort();
            
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
    $(strid).children().last().append('<span><button type="button" class="deletebutton btn btn-danger btn-sm">Delete Timeslot</button></span>');
});

/* Delete Button functionality */
$(document).on('click', '.deletebutton', function(){
    var parent = $(this).parent().parent();
    parent.remove();
});

/* Change Endinput to fit timeslot length */
$(document).on('input', '.startInput', function(){
    var newValue = $(this).val();
    var hourInput = $('#timeslot_hour').find(":selected").text();
    var minuteInput = $('#timeslot_minute').find(":selected").text();
    var newEndInput = changeTime(true, newValue, hourInput, minuteInput);
    var endInput = $(this).parent().next().children('.endInput');
    $(endInput).val(newEndInput);
});

/* Change startInput to fit timeslot length */
$(document).on('input', '.endInput', function(){
    var newValue = $(this).val();
    var hourInput = $('#timeslot_hour').find(":selected").text();
    var minuteInput = $('#timeslot_minute').find(":selected").text();
    var newStartInput = changeTime(false, newValue, hourInput, minuteInput);
    var startInput = $(this).parent().prev().children('.startInput');
    $(startInput).val(newStartInput);
});

/* Change endInput value to match new duration if timeslot divs exist */
$(document).on('input', '#timeslot_hour', function(){
    var hourInput = $(this).val();
    var minuteInput = $('#timeslot_minute').find(":selected").text();
    $(".endInput").each(function(){
        var startInput = $(this).parent().prev().children('.startInput').val();
        var newEndInput = changeTime(true, startInput, hourInput, minuteInput);
        $(this).val(newEndInput);
    });
});

/* Change endInput value to match new duration if timeslot divs exist */
$(document).on('input', '#timeslot_minute', function(){
    var minuteInput = $(this).val();
    var hourInput = $('#timeslot_hour').find(":selected").text();
    $(".endInput").each(function(){
        var startInput = $(this).parent().prev().children('.startInput').val();
        var newEndInput = changeTime(true, startInput, hourInput, minuteInput);
        $(this).val(newEndInput);
    });
});

/* Helper method to calculate either starttime or endtime */
function changeTime(addBoolean, startInput, hourInput, minuteInput){
    var hour = parseInt(hourInput, 10);
    var minute = parseInt(minuteInput, 10);
    var startHour = parseInt(startInput.split(":")[0], 10);
    var startMinute = parseInt(startInput.split(":")[1], 10);
    
    if (!addBoolean){
        var outMinute = startMinute - minute;
        if (outMinute < 0){
            var outHour = startHour - hour - 1;
            outMinute += 60;
        }else {
            var outHour = startHour - hour;
        }
        if (outHour < 0){
            outHour += 24;
        }
    }else {
        var outMinute = minute + startMinute;
        if (outMinute >= 60){
            var outHour = startHour + hour + 1;
            outMinute -= 60;
        }else {
            var outHour = startHour + hour;
        }
        if (outHour >= 24){
            outHour -= 24;
        }
    }
    var strHour = outHour.toString();
    var strMinute = outMinute.toString();
 
    if (strHour.length == 1){
        strHour = "0" + strHour;
    }
    if (strMinute.length == 1){
        strMinute = "0" + strMinute;
    }
    
    return strHour + ":" + strMinute;
}

/* Time Entry Row */
function createTimeEntry(divId){
    var startInput = document.createElement("input");
    startInput.setAttribute('class', 'startInput');
    var endInput = document.createElement("input");
    endInput.setAttribute('class', 'endInput');
    var strid = "#"+divId + " > div";
    var hourInput = $('#timeslot_hour').find(":selected").text();
    var minuteInput = $('#timeslot_minute').find(":selected").text();
    
    if ($(strid).length == 0){
        startInput.value = "08:00";
    }
    else {
        var inputs = 'input[name="times['+divId+'][]"]';
        var lastTime = $(inputs).last().val();
        var hour = parseInt(lastTime.split(":")[0], 10);
        if (hour >= 23){
            startInput.value = "0" + (hour + 1 - 24).toString() + ":00";
        }
        else if (hour < 9){
            startInput.value = "0" + (hour + 1).toString() + ":00";
        }
        else {
            startInput.value = (hour + 1).toString() + ":00";
        }
    }
    endInput.value = changeTime(true, startInput.value, hourInput, minuteInput);
    
    startInput.type = "time";
    startInput.step = "300";
    startInput.name = "times["+divId +"][]";
    endInput.type = "time";
    endInput.step = "300";
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
    sortDivs();
}

/* Sort Dates divs in times table */
function sortDivs(){
    const items = document.querySelector("#times-table");
    const divs = [...items.children];
    divs.sort((a,b) => a.id.localeCompare(b.id));
    divs.forEach(div => items.appendChild(div));
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
   var day = date.split("-")[2];
   var month = parseInt(date.split("-")[1], 10);
   var year = date.split("-")[0];
   
   return dayNames[dayInt] + ", " + monthNames[month] + ' ' + day + ' ' + year;
}