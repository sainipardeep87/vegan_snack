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
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery.tagsinput
//= require jquery.plugin
//= require jquery.countdown
//= require ckeditor/override
//= require ckeditor/init
//= require_tree .

$(document).ready(function(){
  var showModal = function(){
    $('body').on('click', '.modal-link', function(){
      $("#modalContent .modal-body").html('');
      $('#static').modal('show');
      App.blockUI($('#modalContent .modal-body'));
    });
  }

  showModal();
});
var App = function(){
  return {
    blockUI: function(el){
      el.block({
        message: '',
        css: {backgroundColor: 'none'},
        overlayCSS: {
          backgroundColor:'#FFFFFF',
          backgroundImage: "url('/assets/loader.gif')",
          backgroundRepeat: 'no-repeat',
          backgroundPosition: 'center',
          opacity: 0.67
        }
      });
    },
    unBlockUI: function(el){
      el.unblock();
    }
  }
}();


