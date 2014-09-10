// JavaScript Document





$(document).ready(function(){					
					$('.bxslider1').bxSlider({					
					autoControls: false,
					autoHover: false,	
					autoControlsCombine: true,			
					});				
                    });	
					
$(document).ready(function(){					
					$('.bxslider').bxSlider({
					auto: false,
					autoControls: false,
					autoHover: true,	
					autoControlsCombine: true		
					});				
                    });						





/*header starts Here*/

 (function() {

  var docElem = document.documentElement,
   didScroll = false,
   changeHeaderOn = 600;
   document.querySelector( 'header' );
  function init() {
   window.addEventListener( 'scroll', function() {
    if( !didScroll ) {
     didScroll = true;
     setTimeout( scrollPage, 500 );
    }
   }, false );
  }
  
  function scrollPage() {
   var sy = scrollY();
   if ( sy >= changeHeaderOn ) {
    $( 'header' ).addClass('active');
   }
   else {
    $( 'header' ).removeClass('active');
   }
   didScroll = false;
  }
  
  function scrollY() {
   return window.pageYOffset || docElem.scrollTop;
  }
  
  init();
  
 })();
 /*header ends Here*/


 
 



/*Navigation Start Here*/

jQuery(document).ready(function($){

	/* prepend menu icon */
	$('nav').prepend('<div id="menu-icon"></div>');
	
	/* toggle nav */
	$("#menu-icon").on("click", function(){
		$("#nav").slideToggle();
		$(this).toggleClass("active");
	});

});

/*Navigation ends Here*/



/*Parallax starts Here*/
$(function () {
    "use strict";
    var $bgobj = $(".ha-bg-parallax"); // assigning the object
    $(window).on("scroll", function () {
        var yPos = -($(window).scrollTop() / $bgobj.data('speed'));
        // Put together our final background position
        var coords = '100% ' + yPos + 'px';
        // Move the background
        $bgobj.css({ backgroundPosition: coords });
    });
});

/*Parallax ends Here*/




/*Parallax2 starts Here*/
$(function () {
    "use strict";
    var $bgobj = $(".ha-bg-parallax-abt"); // assigning the object
    $(window).on("scroll", function () {
        var yPos = -($(window).scrollTop() / $bgobj.data('speed'));
        // Put together our final background position
        var coords = '100% ' + yPos + 'px';
        // Move the background
        $bgobj.css({ backgroundPosition: coords });
    });
});

/*Parallax2 ends Here*/



/*scroll starts Here*/

$(window).scroll(function( e ) {
var position = $(document).scrollTop();
   if(position==0){	
	$('#green-strip').fadeIn(400);
   }else{   
	$('#green-strip').fadeOut(400);
   }
});


$(document).ready(function(){
 $('.how-it-works-text a').click(function(){
    $('html, body').animate({
        scrollTop: $( $(this).attr('href') ).offset().top-150
    }, 1500);
	$('.green-trans').hide();	
    return false;
});
});

/*scroll ends Here*/



/*tabs starts here */

$(document).ready(function(){	
	$("#tabsholder2").tytabs({
							prefixtabs:"tabz",
							prefixcontent:"contentz",
							classcontent:"tabscontent",
							tabinit:"2",
							catchget:"tab2",
							fadespeed:"normal"
							});
});


/*tabs ends here */


