// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.tagsinput
//= require ckeditor/override
//= require ckeditor/init
//= require jquery_nested_form
//= require jquery-ui.min
//= require_tree .

var ready;
ready = function() {
	$("body").on("change", ".each_image",function() {

	    var val = $(this).val();

	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'gif': case 'jpg': case 'png': case 'x-png': case 'jpeg': case 'pjpeg':
	            break;
	        default:
	            $(this).val('');
	            // error message here
	            alert("Please upload only jpeg, jpg or png images.");
	            break;
	    }
	});

/*	$('#order_selection').selectpicker({ 'selectedText': '',style:'btn-lg' }); */


	$("#coupon_fieldset").on("blur", "input[type='text']", function(){
        $(this).val($(this).val().split(" ").join(""));
    });

	load_calendar();


};
$(document).ready(ready);
$(document).on('page:load', ready);

/*
	function load_calendar(){
		console.log("calendar got loaded");
		$(".order-datepicker").datepicker({
			changeMonth: true,
      		changeYear: true
 		});

	}
*/

	function load_calendar(){

		 $( "#date_start" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: "yy-mm-dd",
      onClose: function( selectedDate ) {
        $("#date_end").datepicker( "option", "minDate", selectedDate );
      }
    });
    $("#date_end").datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: "yy-mm-dd",
      onClose: function( selectedDate ) {
        $("#date_start").datepicker( "option", "maxDate", selectedDate );
      }
    });


	}