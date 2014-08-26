// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.tagsinput

//= require ckeditor/init
//= require jquery_nested_form
//= require jquery-ui.min
//= require jquery.blockUI
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

/*  $('#order_selection').selectpicker({ 'selectedText': '',style:'btn-lg' }); */

  $("#coupon_fieldset").on("blur", "input[type='text']", function(){
      $(this).val($(this).val().split(" ").join(""));
    });

  load_calendar();
  reset_form_for_export();
  reset_form_for_filteration();
  add_ajax_to_links();
  drop_ajax_link_from_users_list();
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

/* Description: Following function will load the datepicker when admin clicks on the date picker fields in admin panel */

  function load_calendar(){

     $( "#date_start" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: "mm-dd-yy",
      onClose: function( selectedDate ) {
        $("#date_end").datepicker( "option", "minDate", selectedDate );
      }
    });

    $("#date_end").datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: "mm-dd-yy",
      onClose: function( selectedDate ) {
        $("#date_start").datepicker( "option", "maxDate", selectedDate );
      }
    });

  }

/* Description: Function will alter the default action, method attributes of the form to generate the excel sheet. */
    function reset_form_for_export(){

      $("#form_filter").on("click", "#export_submit", function(){
          $("#form_filter").attr("action", "/spree/admin/orders/export.xls");
          $("#form_filter").attr("method", "post");
          $("#form_filter").removeAttr("data-remote");
      });

    }

/* Description: Function will alter the default action, method attributes of the form to execute the range action. */
    function reset_form_for_filteration(){

      $("#filter_export").on("click", "#filter_submit", function(){
        $("#filter_result").removeClass().addClass("range-notify");
        $("#filter_result").text("Please Wait...");
        $("#form_filter").attr("action", "/spree/admin/orders/range");
        $("#form_filter").attr("method", "get");
        $("#form_filter").attr("data-remote", "true");
      });

    }

/* Description: Following function will reset the start & end date in the date picker field once the partial is refreshed
    by the range.js.erb file
*/
     function set_date_ranges(start_date, end_date) {
      $("#date_start").val(start_date);
      $("#date_end").val(end_date);
    }

/* Description: Added this method to add remote true links against the links in page, so that we can go for
  remote-true submit
*/
    function add_ajax_to_links(){
      $("nav.pagination span a").attr("data-remote", "true");
      $("#order_column th a.sort_link").attr("data-remote", "true");
    }

/* Description: Function will remove the remote true links from the pagination section */
function drop_ajax_link_from_users_list(){
  $("#user_list_pagination nav span a").removeAttr("data-remote");
}