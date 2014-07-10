ready = function() {

    $('.ingredients-list').hide();
    IS_IPAD = navigator.userAgent.match(/iPad/i) != null;

    if($(window).width() >= 768 || $(window).width() <= 1024) {

        /* On clicking signin_button expand the sign in form and increase the height to 150px */
        $('#signin_button').on('click', function() {
            $('.navbar.navbar-default.navbar-fixed-top').animate({height: 180},500);
        });
    }

/* Description: on clicking the close button in signin form, resize the height for signin part.*/
    $("#close").on("click", function(){
        $("#new_spree_user input[type=text]").val("");
        $("#new_spree_user input[type=password]").val("");
        $('.navbar.navbar-default.navbar-fixed-top').animate({height: 70}, 500);
        revert_welcome_message();
    });


    $("#signin_button").click(function(){
        toggle_the_signin_header();
    });

    $("#close").click(function(){
       $(".mobile-errors").css("display", 'none !important');
        reset_welcome_section();
        toggle_the_signin_header();
    });


/* Description: hide/show the signin/top navbar depending on button clicked */
    $('#fullPage-nav li a').on("click", function() {
        $('#fullPage-nav li a').removeClass('active');
        $(this).addClass('active');
    });

    $('.btn-navbar').on("click", function() {
        if(!$(this).hasClass('collapsed')) {
            $('.nav-collapse.row.pull-right.in.collapse').height();
        }
    });

/*Description: On changing the selection offer in home page respective offer bullet will be activated (Home Page Offer) */

/*
    $(document).on("click", ".offer-bubble", function(){
        var plan_id =  $(this).attr('id');

        $("#plan_id").val(plan_id);
        console.log($("#plan_id").val());
        activate_selected_plan($(this));
    });
*/

    $(document).on("click", ".offer-bubble", function(){
        var plan_id =  $(this).attr('id');
        $("#plan_id").val(plan_id);
        console.log($("#plan_id").val());
         activate_selected_plan($(this));
    });

// class='detail-vegan' style='display:none !important'

    $('.ind-item-section').on("mouseover", function(){
        $(this).children().filter('.detail-vegan').attr('style','display:block !important')
    });

    $('.ind-item-section').on("mouseout", function(){
        $(this).children().filter('.detail-vegan').attr('style','display:none !important')
    });

    $(".ind-item-section").on("click", function(){
        // $(".hidden-ingredients").css("display", 'block');
        $(".product-list-thumbnail").css("display", 'none');
        $("#ind_snacks_render").css("display", "block");
        item_image_id = "#snack-image-"+this.id;
        item_name = $(".ind-item-name", this).text();
        item_description = $(".hidden-item-desc", this).text();
        item_image = $(".hidden-item-nutrifact-image img", this)[0].src;
        item_ingredients = $(".hidden-ingredients", this).html();
        item_image_path = $("#image-span img", this)[0].src;

        $("#banana-img").attr("src",item_image_path);
        $(".banana-split").text(item_name);
        $('.banana-description').text(item_description);
        $('.nutri-image img').attr("src", item_image);
        $('.ingredients-list').html(item_ingredients);
        //$('.nutri-image').html(item_image)
        // $('.nutri-image').html("<img src="+item_image+" alt='Nutrition Facts' height=10 width=10 class='nutrition_fact'>");
    });


    $(".ingredient-button", this).on("click", function(){
        $('.nutri-image').hide();
       $('.ingredients-list').show();
    });

    $(".nutrition-button", this).on("click", function(){
        $('.nutri-image').show();
       $('.ingredients-list').hide();
    });

    $(".close-individual").on("click", function(){
        $(".product-list-thumbnail").css("display", 'block');
        $("#ind_snacks_render").css("display", "none");
        $('.nutri-image').show();
        $('.ingredients-list').hide();
    });

    $(".login-para input:text, input:password").on("focus", function(){
       $(this).removeClass('error');
        $(this).addClass('valid');
    });

    $("span#1").addClass("sum-selection-active");
};

$(document).ready(ready);
$(document).on('page:load', ready);

/* Description: Following method will reset the welcome section and clear all the error messages when user hits the close button at sign in bar
 Argument List: NIL
 Return :NIL
 */

function reset_welcome_section() {
    $('#signin_error').css('display', 'none');
    $('.welcome-message label').remove();
    $('.welcome-message span').show();
    $('.welcome-message').removeClass('error-message');
    $("#user_login form input").removeClass('error');
}

/* Description: Following method will toggle the top navbar when user hits the signin button
 Argument List : NIL
 Return: NIL
 */

function toggle_the_signin_header(){
    $("div.app-navigation").toggle();
    $("div.signin-form-nav").toggle();
}

function activate_selected_plan(clicked_bullet){
    $('.offer-bubble').removeClass("sum-selection-active");
    $('.offer-bubble').addClass("sum-selection-inactive");
    $(clicked_bullet).removeClass("sum-selection-inactive");
    $(clicked_bullet).addClass("sum-selection-active");
    /*$('.offer-bubble').removeClass("green-bullet");
    $('.offer-bubble').addClass("faded-bullet");
    $(clicked_bullet).addClass("green-bullet"); */
}

/* in admin login fadeout the top flash section after some seconds */


$(window).bind("load", function() {
    /*console.log("flash remover loaded");*/
    setTimeout(function(){
        $("div.flash").fadeOut();
    }, 2000);
});

