// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.turbolinks
//= require bootstrap
//= require turbolinks
//= require_tree .


function toggleModal() {
    var divModal = document.getElementById("divModal");
    divModal.style.display = (divModal.style.display == "table") ? "none" : "table";
}

function toggleTable() {
    var lTable = document.getElementById("addCardTable");
    lTable.style.display = (lTable.style.display == "table") ? "none" : "table";
}

(function() {

 // Below is the name of the textfield that will be autocomplete    
    ('#forecast_company_text').autocomplete({
 // This shows the min length of charcters that must be typed before the autocomplete looks for a match.
            minLength: 3,
 // This is the source of the auocomplete suggestions. In this case a list of companies from the people controller, in JSON format.
            source: '<%= company_path(:json) %>',
  // This updates the textfield when you move the updown the suggestions list, with your keyboard. In our case it will reflect the same value that you see in the suggestions which is the person.given_name.
            focus: function(event, ui) {
                ('#select_origin').val(ui.item.company.name);
                return false;
            },
 // Once a value in the drop down list is selected, do the following:
            select: function(event, ui) {
 // place the company.name value into the textfield called 'select_origin'...
                ('#select_origin').val(ui.item.company.name);
 // and place the company.id into the hidden textfield called 'forecast_company_text'. 
        ('#forecast_company_text').val(ui.item.company.id);
                return false;
            }
        })
 // The below code is straight from the jQuery example. It formats what data is displayed in the dropdown box, and can be customized.
        .data( "autocomplete" )._renderItem = function( ul, item ) {
            return ( "<li></li>" )
                .data( "item.autocomplete", item )
 // For now which just want to show the person.given_name in the list.
                .append( "<a>" + item.company.name + "</a>" )
                .appendTo( ul );
        };
    });


function() {
        
        var countries_starting_with_A = [
    {
        "id": "1",
        "value": "Afghanistan",
        "label": "Afghanistan"
    },
    {
        "id": "17",
        "value": "Albania",
        "label": "Albania"
    },
    {
        "id": "18",
        "value": "Algeria",
        "label": "Algeria"
    },
    {
        "id": "20",
        "value": "American Samoa",
        "label": "American Samoa"
    },
    {
        "id": "22",
        "value": "Andorra",
        "label": "Andorra"
    },
    {
        "id": "10",
        "value": "Angola",
        "label": "Angola"
    },
    {
        "id": "11",
        "value": "Anguilla",
        "label": "Anguilla"
    },
    {
        "id": "23",
        "value": "Antarctica",
        "label": "Antarctica"
    },
    {
        "id": "24",
        "value": "Antigua and Barbuda",
        "label": "Antigua and Barbuda"
    },
    {
        "id": "25",
        "value": "Argentina",
        "label": "Argentina"
    },
    {
        "id": "26",
        "value": "Armenia",
        "label": "Armenia"
    },
    {
        "id": "27",
        "value": "Aruba",
        "label": "Aruba"
    },
    {
        "id": "28",
        "value": "Australia",
        "label": "Australia"
    },
    {
        "id": "29",
        "value": "Austria",
        "label": "Austria"
    },
    {
        "id": "12",
        "value": "Azerbaijan",
        "label": "Azerbaijan"
    }
];
    
    $("#forecast_company_text").autocomplete({
        source: countries_starting_with_A,
        minLength: 1,
        select: function(event, ui) {
            // feed hidden id field
            $("#field_id").val(ui.item.id);
            // update number of returned rows
            $('#results_count').html('');
        },
        open: function(event, ui) {
            // update number of returned rows
            var len = $('.ui-autocomplete > li').length;
            $('#results_count').html('(#' + len + ')');
        },
        close: function(event, ui) {
            // update number of returned rows
            $('#results_count').html('');
        },
        // mustMatch implementation
        change: function (event, ui) {
            if (ui.item === null) {
                $(this).val('');
                $('#field_id').val('');
            }
        }
    });

    // mustMatch (no value) implementation
    $("#forecast_company_text").focusout(function() {
        if ($("#forecast_company_text").val() === '') {
            $('#field_id').val('');
        }
    });
};
