ready = function(){
    /*document.addEventListener('touchmove', function(e) {
     e.preventDefault();
     var touch = e.touches[0];
     alert(touch.pageX + " - " + touch.pageY);
     }, false);
     */

    /* By default keep the billing address Section hidden in Signup Form section */
    $("#signup_bill_address").hide();

    /* Set the billing section divs height equal to window height */
//    $("#order_billing").height($(window).height()+1100);
    reset_window_width_for_signup_billing_form();


    /* ON clicking the back button in billing address section it'll hide the bill form and populate the previous shipping address form */

    $("#submit_bill").on("click", "#bill_back", function(){
		
        $("#signup_bill_address").hide();
        $("#signup_ship_address").show();

    });

    $(".left-btm-btn").on("click","#back_to_footer", function(){
        $("#signup_ship_address").addClass('hide');
        $("#footer_singup").removeClass('hide');

    });

    $("#confirm_bill").on("click", "#cofirm_back", function(){
    	// alert ("ehllo");
    	$("#signup_bill_address").show();
    	$("#signup_ship_address").hide();
    	$("#confirm_signup").addClass('hide');
    	
    });
    
	// $("#submit_bill").on("click", "#submit2", function(){
		// $("#signup_bill_address").hide();
        // $("#signup_ship_address").hide();
        // $("#confirm_signup").removeClass('hide');
        // $('div#ship_first_name').text($("#spree_user_addresses_attributes_0_firstname").val());
        // $('div#ship_address_1').text($("#spree_user_addresses_attributes_0_address1").val());
        // $('div#ship_address_2').text($("#spree_user_addresses_attributes_0_address2").val());
        // $('div#ship_city').text($("#spree_user_addresses_attributes_0_city").val());
//         
        // $('div#bill_first_name').text($("#spree_user_addresses_attributes_1_firstname").val());
        // $('div#bill_address_1').text($("#spree_user_addresses_attributes_2_address1").val());
        // $('div#bill_address_2').text($("#spree_user_addresses_attributes_2_address2").val());
        // // $('div#bill_city').text($("#spree_user_addresses_attributes_2_city").val());
	// });
	
    $("#billing_form_div").on("blur", "#spree_user_creditcards_attributes_0_card_no", function(){
        $(this).val($(this).val().split(" ").join(""));
    });


    $("div#address_check").on("click", "input#address_check", function(){
    	
        var checked = $(this).is(":checked");

        if(checked) {
        	
            $("#spree_user_addresses_attributes_1_firstname").val($("#spree_user_addresses_attributes_0_firstname").val());
            $("#spree_user_addresses_attributes_1_lastname").val($("#spree_user_addresses_attributes_0_lastname").val());
            $("#spree_user_addresses_attributes_1_address1").val($("#spree_user_addresses_attributes_0_address1").val());
            $("#spree_user_addresses_attributes_1_address2").val($("#spree_user_addresses_attributes_0_address2").val());
            $("#spree_user_addresses_attributes_1_city").val($("#spree_user_addresses_attributes_0_city").val());
            $("#add_phone_billing").val($("#spree_user_addresses_attributes_0_phone").val());
            $("#spree_user_addresses_attributes_1_state_name").val($("#spree_user_addresses_attributes_0_state_name").val());
            $("#spree_user_addresses_attributes_1_zipcode").val($("#spree_user_addresses_attributes_0_zipcode").val());
            

            $("#copy_add input[type='text']").attr("readonly", true)

            $("#copy_add input").focusout();
            /*With above focus out, the error labels or error focus on the billing address form Vanishes */

        }
        else{
            $("#copy_add input[type='text']").val("");
            $("#copy_add input[type='text']").attr("readonly", false)
        }
    });


    $(".error-message").hide();
    $('.js-enabled-header').toggle();

    $("body").on("click", "#forgot_password_submit", function(){
        App.blockUI($('#password_form'));
    });


    /* ON clicking the "here" link, which appears if user is trying to login to application(via fb) but not yet registered in VeganSnackPacks */
    $(".welcome-message").on("click", "#go_signup", function(){

        scroll_to_signup_section();
        setTimeout(function(){
            $("#close").click();
            revert_welcome_message();
        },2000);

    });

    $(".join").on("click", "#signup_link", function(){
        var current_link = window.location.pathname =="/"  || window.location.pathname == "/spree/signup/"  || window.location.pathname == "/spree/signup" ;

        if(!current_link){
            window.location = '/spree/signup/#vegan_user_signup'
        }

        scroll_to_signup_section();
        setTimeout(function(){
            $("#close").click();
        },2000);
    });


    /*  Description: on click on the Get Started button in the home page scroll Down to the respective Section. */
    $("#fullpage").on("click", ".get-started-icon", function(){
        scroll_to_signup_section();
    });

    /* Description: on click on the "How works get started" button in the home page scroll Down to the respective Section. */
    $(document).on("click", '.how-works-get-started img', function(){
        scroll_to_signup_section();
    });


    /* Teaser image swap function */
    $('img.swap').hover(function () {
        this.src = '/images/signup_big_hover.png';
    }, function () {
        this.src = '/images/signup_big.png';
    });

    $( "#h-image-1" ).on("mouseover", function() {
        this.src = '/assets/home/1-yellow.png';
        $('#i-image-1').css('background-image', "url('/assets/home/move.png')");
    });

    $( "#h-image-1" ).on("mouseout", function() {
        this.src = '/assets/home/1-white.png';
        $('#i-image-1').css('background-image', "url('/assets/home/left.png')");
    });

    $( "#h-image-2" ).on("mouseover",function() {
        this.src = '/assets/home/2-yellow.png';
        $('#i-image-2').css('background-image', "url('/assets/home/move.png')");
    });

    $( "#h-image-2" ).on("mouseout", function() {
        this.src = '/assets/home/2-white.png';
        $('#i-image-2').css('background-image', "url('/assets/home/left.png')");
    });

    $( "#h-image-3" ).on("mouseover", function() {
        this.src ='/assets/home/3-yellow.png';
        $('#i-image-3').css('background-image', "url('/assets/home/move.png')");
    });

    $( "#h-image-3" ).on("mouseout", function() {
        this.src = '/assets/home/3-white.png';
        $('#i-image-3').css('background-image', "url('/assets/home/left.png')");
    });

    $("#h-image-4").on("mouseover", function(){
        this.src = '/assets/home/screen-4-hover.png';
    });

    $("#h-image-4").on("mouseout", function(){
        this.src = '/assets/home/screen-4.png';
    });

    reset_my_container();
    activate_bullet_on_click();
    activate_bullet_on_scroll();

    $(window).scroll(function() {
        activate_bullet_on_scroll();
    });

    top_val = $(window).height() * 58 / 100 ;
    left_val = $(window).width() * 40 / 100 ;

    $('.get-started-button').css('top', top_val);
    $('.get-started-button').css('left', left_val);




}; /* End of Document ready */


$(document).ready(ready);
$(document).on('page:load', ready);


$(window).resize(function(){

    top_val = $(window).height() * 58 / 100 ;
    left_val = $(window).width() * 40 / 100 ;

    $('.get-started-button').css('top', top_val);
    $('.get-started-button').css('left', left_val);

    reset_window_width_for_signup_billing_form();

});

$(window).bind("load", function() {
    /* reset_admin_login_text(); */
});

/* Description: Below function will reset the admin login text after page is fully loaded */

function reset_admin_login_text(){
    var admin_login_text = $("div#wrapper div.notice").html();

    if(admin_login_text == "Signed out successfully."){
        $("div#wrapper div.notice").html("Signed in Successfully");
    }
}

/* Description: below function will set the height of billing address section for a smaller width
 mobile device.
 */
function reset_window_width_for_signup_billing_form(){

    var mobile_width = $(window).width();

    if (mobile_width > 600 && mobile_width < 750) {
        $("#order_billing").height(700);
    }

    if(mobile_width > 320 && mobile_width < 470){
        $("#order_billing").height($(window).height());
    }

}
/*
 Description: Following method will resize the container when browser width is changed or site is opened in separate device.
 */
function reset_my_container() {
    var window_height = $(window).height();
    var window_width = $(window).width();

    $('.container').width($(window).width()-30);
    //$('.container').css('height', 'auto');
    //added for footer social icons
    $('.container').css('height', window_height +30);

    $('.get-started').height($(window).height());
    $('.about-us-container').height(window_height);
    $('.about-us-container').width(window_width);

    $('.planet-container').height(window_height);
    $('.snack-bg-image').height(window_height);

    $('.contact-page').height(window_height);
    $('.contact-page').width(window_width);

    $(".product-listing").height($(document).height()) ;

}

/*
 Description: on click of bullet scroll to respective section as mentioned in data-target attribute.
 */
function activate_bullet_on_click(){
    $('.slider-nav ul li').on("click", function() {
        $('.slider-nav ul li').removeClass('active-bullet');
        $(this).addClass('active-bullet');

        $($(this).attr('data-target')).ScrollTo({
            duration: 1000
        });
    });
}

/*
 Description: on Scrolling the page, the bullet will automatically get activated depending on the active page section on the Current Window
 */
function activate_bullet_on_scroll(){
    var scrollTop = $(window).scrollTop();
    var result = new Object();
    var distance1, distance2, distance3, distance4, distance5;
    distance1 = distance2 = distance3 = distance4 = distance5 = Number.MAX_VALUE;


    if($(".first-win")[0]){
        var first_offset = $(".first-win").offset().top;
        distance1 = Math.abs(first_offset - scrollTop);
        result[distance1] = ".first-bullet";
    }

    if($(".second-win")[0]){
        var second_off = $(".second-win").offset().top;
        distance2 = Math.abs(second_off - scrollTop);
        result[distance2] = ".second-bullet";
    }
    if($(".third-win")[0]){
        var third_off = $(".third-win").offset().top;
        distance3 = Math.abs(third_off - scrollTop);
        result[distance3] = ".third-bullet";
    }

    if($(".forth-win")[0]){
        var forth_off = $(".forth-win").offset().top;
        distance4 = Math.abs(forth_off - scrollTop);
        result[distance4] = ".forth-bullet";
    }

    if($(".fifth-win")[0]){
        var fifth_off = $(".fifth-win").offset().top;
        distance5 = Math.abs(fifth_off - scrollTop);
        result[distance5] = ".fifth-bullet";
    }

    close_node  = Math.min(distance1, distance2, distance3, distance4, distance5);

    $('.slider-nav ul li').removeClass('active-bullet');
    $(result[close_node]).addClass('active-bullet');
}


$(function() {
    $(window).resize(reset_my_container).trigger('resize');
});


function scroll_to_signup_section(){
    $('.wrapper-membership').ScrollTo({
        duration: 2000
    });
}

function revert_welcome_message(){
    $(".welcome-message").empty();
    $(".welcome-message").html("<span class='show-well'>Welcome back</span>");
    $(".welcome-message").removeClass("no-account")
    $('.welcome-message').show();
}
