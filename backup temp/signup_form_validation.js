$(document).ready(function(){


    /* on clicking the "Get started" link in signup section it'll validate the email fields
     value before moving to shipping address section */

    $("#facebook_email_div").on("click", "#fb_get_started", function(){
        validate_email_field_before_signup();
    });

    // Add US Phone Validation
    jQuery.validator.addMethod('phoneUS', function(phone_number, element) {
        phone_number = phone_number.replace(/\s+/g, '');
        reg_expression = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/

        return this.optional(element) || phone_number.length > 9 &&
            phone_number.match(reg_expression);
    }, 'Invalid phone no entered.');


    /* Same as above feature, enabled the enter key hit to validate the Email Field in Sign up */
    $("#facebook_email_div").on("keypress", "#email", function(e){
        var keyCode = e.keyCode  || e.which;
        if(keyCode == 13){
             e.preventDefault();
            validate_email_field_before_signup();
        }
    });

    $("#order_billing").on("keypress", "#billing_form_div", function(e){
        var keyCode = e.keyCode || e.which;

        if(keyCode == 13){
            e.preventDefault();
            // on_validate_submit_complete_signup_form();
        }
    });

    $("#vegan_signup").on("keypress", "#signup_ship_address", function(e){
        var keyCode = e.keyCode || e.which;
        if(keyCode == 13){
                e.preventDefault();
                //on_validate_show_billing_form();
        }
    });

    $("div.coupon-field").on("blur", "#spree_user_coupon_code", function(){
        $(this).val($(this).val().trim());
    });

    validate_user_signin_form("#user_login form");

    /*On clicking  "Place my Order" it will perform validation on shipping address form */
    $("#signup_ship_address").on("click", "img#user_sign_up", function(e){
        e.preventDefault();
        $("#credit_section div div  label.error").empty();
        $("#copy_add div div  label.error").empty();
        on_validate_show_billing_form();
    });

/* Description: On clicking "complete payment" in billing address form, it will perform required
    validation and on success the form will be submitted to user_registrations create action.
*/

    $("#submit_bill").on("click", "#submit", function(e){
        e.preventDefault();
        on_validate_submit_complete_signup_form();
    });

/* Description:  On focus out from email field(present in signup form) it will hide the error
    message below the Email field
*/
    $("#facebook_email_div").on("focus", "input#email", function(){
        $("#fb_email_error").hide();
        $("#facebook_email_div input").css("border-color", "none");
    });

    $(".sub-login").on("click", function(){
        add_error_section_to_header();
    });
});

function on_validate_submit_complete_signup_form(){
        var result = validate_signup_cum_ship_address_form("#vegan_signup");

        if(result.valid()){
            App.blockUI($('#order_billing'));
            $("div.text-center em").css("display", "none");
            $("#vegan_signup").submit();
        }
}

function on_validate_show_billing_form(){

    var result = validate_signup_cum_ship_address_form("#vegan_signup");

        $("#copy_add input").focusout();
        $("#credit_section input").focusout();

        if (result.valid()){
            /* On clicking place my order icon in signup_shipping section it will hide the ship address
             and show the billing address section */
            $("#billing_form_div label.error").show();
            $("#signup_ship_address").hide();
            $("#signup_bill_address").removeClass("hide");
            $("#signup_bill_address").show();
            $("#order_billing").height($(window).height()+ 300);
        }

}
/* Description: following method will validae users signup form(shipping form ) & billing form. */
function validate_signup_cum_ship_address_form(form_id){

    var result = $(form_id).validate({
        rules: {
            "spree_user[addresses_attributes][0][phone]":{
                required: true,
                maxlength: 15,
                phoneUS: true
               /* remote: {
                    url: '/check_phone_no_format',
                    data: {'phone_no':function(){return $('#add_phone_shipping').val()}},
                    async: false
                }*/
            },
            "spree_user[addresses_attributes][0][firstname]": {
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][lastname]": {
                required: true,
                maxlength: 50
            },

            "spree_user[email]":{
                required: true,
                maxlength: 50,
                email: true
                /*remote: {
                 url: '/check_email',
                 async:false
                 }*/
            },
            "spree_user[addresses_attributes][0][address1]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][address2]":{
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][city]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][state_name]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][zipcode]":{
                required: true,
                maxlength: 50
            },
            "spree_user[password]":{
                required: true,
                minlength: 6
            },
            "spree_user[password_confirmation]":{
                required: true,
                minlength: 6,
                equalTo: "#spree_user_password"
            },
            "spree_user[addresses_attributes][1][firstname]": {
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][1][lastname]": {
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][1][phone]":{
                required: true,
                maxlength: 15,
                phoneUS: true
            },
            "spree_user[addresses_attributes][1][address1]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][1][address2]":{
                maxlength: 50
            },
            "spree_user[addresses_attributes][1][city]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][1][state_name]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][1][zipcode]":{
                required: true,
                maxlength: 50
            },
            "spree_user[creditcards_attributes][0][cardholder_name]":{
                required: true,
                maxlength: 50
            },
            "spree_user[creditcards_attributes][0][card_no]":{
                required: true,
                //number: true,
                maxlength: 25
            },
            "spree_user[creditcards_attributes][0][cvv]":{
                required: true,
                maxlength: 4
            },

            "spree_user[creditcards_attributes][0][month]":{
                selectcheck: true
            },
            "spree_user[creditcards_attributes][0][year]":{
                selectcheck: true
            },
            "spree_user[coupon_code]":{
                remote: {
                    type: "get",
                    url: '/spree/admin/coupons/check_valid_coupon/'
                }
            }
        }, // End of the rules
        messages: {
            "spree_user[addresses_attributes][0][phone]":{
                required: 'Phone no. is required',
                maxlength: 'Maximum {0} characters allowed.',
                phoneUS: 'Invalid phone no entered.'
            },
            "spree_user[addresses_attributes][0][firstname]": {
                required: 'First name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][lastname]": {
                required: 'Last name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[email]":{
                required: "Email is required.",
                maxlength: 'Maximum {0} characters allowed.',
                email: 'Invalid Email ID entered'
                // remote: 'Email ID already used.'
            },
            "spree_user[addresses_attributes][0][address1]":{
                required: 'Address is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][address2]":{
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][city]":{
                required: 'City name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][state_name]":{
                required: 'State name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][zipcode]":{
                required: 'Zipcode is required.',
                maxlength: ' Maximum {0} characters allowed.'
            },
            "spree_user[password]":{
                required: 'Password is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[password_confirmation]":{
                required: 'Password confirmation required',
                maxlength: 'Maximum {0} characters allowed.',
                equalTo: 'Must match with password'
            },
            "spree_user[addresses_attributes][1][firstname]": {
                required: 'First name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][1][lastname]": {
                required: 'Last name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][1][phone]":{
                required: 'Phone no. is required',
                maxlength: 'Maximum {0} characters allowed.',
                phoneUS: 'Invalid phone no entered.'

            },
            "spree_user[addresses_attributes][1][address1]":{
                required: 'Address is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][1][address2]":{
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][1][city]":{
                required: 'City name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][1][state_name]":{
                required: 'State name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][1][zipcode]":{
                required: 'Zipcode is required.',
                maxlength: ' Maximum {0} characters allowed.'
            },
            "spree_user[creditcards_attributes][0][cardholder_name]":{
                required: 'Name is mandatory.',
                maxlength: ' Maximum {0} characters allowed.'
            },
            "spree_user[creditcards_attributes][0][card_no]":{
                required: 'Card no is mandatory.',
                // number: 'Invalid Card no. Entered.',
                maxlength: ' Maximum {0} characters allowed.'
            },

            "spree_user[creditcards_attributes][0][cvv]":{
                required: 'CVV is mandatory.',
                //number: 'Invalid CVV Entered.',
                maxlength: ' Maximum {0} characters allowed.'
            },
            "spree_user[creditcards_attributes][0][month]":{
                selectcheck: 'This field is required.'
            },
            "spree_user[creditcards_attributes][0][year]":{
                selectcheck: 'This field is required.'
            },
            "spree_user[coupon_code]":{
                remote: "Invalid Coupon code entered."
            }
        }
    });

    jQuery.validator.addMethod('selectcheck', function(value) {
        return (value != '');
    }, "year required");

    result.form();
    return result;
}

/* Description:  it's a generic method for validating the Signup form cum facebook redirected signup form.
 Argument LIst: form
 Return: NIL
 */
 /*
function validate_user_signup_form(form){
    console.log(form);
    $(form).validate({

        rules: {
            "spree_user[addresses_attributes][0][firstname]": {
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][lastname]": {
                required: true,
                maxlength: 50
            },
            "spree_user[email]":{
                required: true,
                maxlength: 50,
                email: true,
                remote: '/check_email'
            },
            "spree_user[addresses_attributes][0][phone]":{
                required: true,
                maxlength: 50,
                remote: {
                    url: '/check_phone_no_format',
                   data: { phone_no: billing_phone_no}
                }
            },
            "spree_user[addresses_attributes][0][company]":{
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][address1]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][address2]":{
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][city]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][state_name]":{
                required: true,
                maxlength: 50
            },
            "spree_user[addresses_attributes][0][zipcode]":{
                required: true,
                maxlength: 50
            },
            "spree_user[password]":{
                required: true,
                minlength: 6
            },
            "spree_user[password_confirmation]":{
                required: true,
                minlength: 6,
                equalTo: "#spree_user_password"
            }
        }, // End of the rules

        messages: {
            "spree_user[addresses_attributes][0][firstname]": {
                required: 'First name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][lastname]": {
                required: 'Last name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[email]":{
                required: "Email is required.",
                maxlength: 'Maximum {0} characters allowed.',
                email: 'Invalid Email ID entered',
                remote: 'Email ID already used.'
            },
            "spree_user[addresses_attributes][0][phone]":{
                required: 'Phone no. is required',
                maxlength: 'Maximum {0} characters allowed.',
                remote: 'Invalid phone no entered.'
            },
            "spree_user[addresses_attributes][0][company]":{
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][address1]":{
                required: 'Address is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][address2]":{
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][city]":{
                required: 'City name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][state_name]":{
                required: 'State name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[addresses_attributes][0][zipcode]":{
                required: 'Zipcode is required.',
                maxlength: ' Maximum {0} characters allowed.'
            },
            "spree_user[password]":{
                required: 'Password is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "spree_user[password_confirmation]":{
                required: 'Password confirmation required',
                maxlength: 'Maximum {0} characters allowed.',
                equalTo: 'Must match with Password'
            }
        }, // End of the messges section

        submitHandler: function(form) {
            form.submit();
        }
    });
}
*/

// Below function will perform validation on the signup form.
function validate_user_signin_form(form){
    $(form).validate({
        onfocusout: function (element) {
            $(element).valid();
            if  ($(".welcome-message").find('label.error').length){
                add_error_section_to_header();
            }
        },
        rules: {
            "spree_user[email]": {
                required: true
            },
            "spree_user[password]": {
                required: true
            }
        },
        messages: {
            "spree_user[email]": {
                required: 'Please enter email address.'
            },
            "spree_user[password]": {
                required: 'Please enter password.'

            }
        },
        errorLabelContainer: '.welcome-message'
    });
}

//Description: following method will hide the default welcome div and populate the error messages below this.

function add_error_section_to_header(){
    //$(".mobile-errors").html( $( ".welcome-message label").text());
    /* for mobile view, the error messages will be copied from welcome-message sction and pasted below the forgot password link line ! */
    //$('.welcome-message').removeClass('show-well');
    //$('.welcome-message').addClass('hide-well');
}


/*
 Description: Below function will perform validation on the Email Field(blank field validation + Email already used validation). if validation turns success
 it will show the shipping address form section and if invalidated then it'll populate respective error message below the Email Field.
 */

function validate_email_field_before_signup(){

    var email_id = $("#facebook_email_div input").val().trim();

    $.ajax({
        url: '/check_email',
        data: {spree_user: {email: email_id}},
        dataType: "json",
        type: "get",

        success: function(result){

            if(Object.keys(result)[0] == "success"){
                $("#spree_user_email").val(email_id);
                $("#fb_email_error").hide();
                $('span.hide-until-email').addClass('show-got-email');
                $('span.show-got-email').removeClass('hide-until-email');
                $("#facebook_signup").addClass('hide-until-email');
            }

            if(Object.keys(result)[0] == "error"){
                $("#fb_email_error").html(result["error"]);
                $("#fb_email_error").show();
                $("#facebook_email_div input").css("border-color", "red");
            }
        },
        failure: function(){
            console.log("Some Error Occured");
        }
    });
}

/* Description: if already signed up user is trying to signup again the it will prevent user from signup/signin
 and slide down to registration section and show respective notification message.
 This function is being called in _order_today_shipping.html.erb partial.
 */

function show_user_already_registered_notification(registered_email){

    $("#facebook_email_div #email").val(registered_email);
    $("#fb_email_error").html("Email ID already used.");
    $("#facebook_email_div input").css("border-color", "red");
    $("#fb_email_error").show();
    $("#vegan_user_signup").ScrollTo({
        duration: 2000
    });
}