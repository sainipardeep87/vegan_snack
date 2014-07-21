$(document).ready(function(){

    validate_password_form();
    validate_forgot_password_form();
    validate_account();

    $("span.edit-acc").on("click", "#edit_account", function(){

        $("#personal_profile_update input").focusout();
    });
 });

/* Description: below function will perform client side validation on myaccount section */
function validate_account(){

    $("#personal_profile_update").validate({
        rules:{
            "user[first_name]":{
                required: true,
                maxlength: 50
            },
            "user[last_name]":{
                required: true,
                maxlength: 50
            },
            "user[email]":{
                required: true,
                 email: true,
                 maxlength: 50
             }
        },
        messages:{
            "user[first_name]":{
                required: "First Name is required",
                maxlength: "Maximum {0} characters allowed."
            },
            "user[last_name]":{
                required: "Last Name is required",
                maxlength: "Maximum {0} characters allowed."
            },
            "user[email]":{
                required: "Email is required.",
                email: 'Invalid Email ID entered.',
                maxlength: 'Maximum {0} characters allowed.'
            }
        }

    });

}

function validate_forgot_password_form(){
    $("#forgot_password_form").validate({
       rules:{
             "spree_user[password]":{
                 required: true,
                 minlength: 6
             },
           "spree_user[password_confirmation]":{
               required: true,
               minlength: 6,
               equalTo: "#spree_user_password"
           }
       },
       messages:{
           "spree_user[password]":{
               required: "Password is required",
               minlength: "Please enter at least {0} characters."
           },
           "spree_user[password_confirmation]":{
               required: "Password Confirm is required",
               minlength: "Please enter at least {0} characters.",
               equalTo: "Must match with password."
           }
       }
    });

}

function validate_password_form(){

    $("#password_update_form").validate({
        rules: {
            "user[current_password]": {
                required: true,
                minlength: 6
            },
            "user[password]":{
                required: true,
                minlength:6
            },
            "user[password_confirmation]":{
                required: true,
                minlength:6,
                equalTo: "#user_password"
            }
        },
        messages:{
            "user[current_password]": {
                required: "Please enter current password.",
                minlength: "Please enter at least {0} characters."
            },
            "user[password]":{
                required: "Password is required.",
                minlength: "Please enter at least {0} characters."
            },
            "user[password_confirmation]":{
                required: "Password Confirmation is required.",
                minlength: "Please enter at least {0} characters.",
                equalTo: "Must match with password."
            }
        }
    });
}

/* Description: Added below method to show password update notification in the password modal(in my account) */
function show_password_updated_notification(){

    $('.update-notification').html("Password updated successfully.");
    $('.update-notification').show();

    setTimeout(function() {
        $('.update-notification').fadeOut('slow');
        $("#password_modal").modal("hide");
    },2000);
}

/*
function validate_account_edit_address_form(){

    console.log("edit address validation loaded");

    $("#address_content form").on("submit", function(e){

        console.log("validation loaded");
        e.preventDefault();
        var result = validate_account_address("#address_content form");

        if(result.valid()){
            //App.blockUI($('#move_add_up'));
            console.log("its coming as a valid form ");
        }
        else{
            console.log("not yet valid form !");
        }
    });

}
*/
 function validate_account_address(address_form){


    var result = $(address_form).validate({
        rules:{
            "address[firstname]":{
                required: true,
                maxlength: 50
            },
            "address[lastname]":{
                required: true,
                maxlength: 50
            },
            "address[phone]":{
                required: true,
                maxlength: 50,
                remote: {
                    url: '/check_phone_no_format',
                    data: {'phone_no':function(){return $('#add_phone').val()}},
                    async: false
                }
            },
            "address[address1]":{
                required: true,
                maxlength:50
            },
            "address[address2]":{
                maxlength:50
            },
            "address[city]":{
                required: true,
                maxlength:50
            },
            "address[state_name]":{
                required: true,
                maxlength:50
            },
            "address[zipcode]":{
                required: true,
                maxlength:50
            }
        },
        messages:{
            "address[firstname]":{
                required: "First Name is required",
                maxlength: "Maximum {0} characters allowed."
            },
            "address[lastname]":{
                required: "Last Name is required",
                maxlength: "Maximum {0} characters allowed."
            },
            "address[phone]":{
                required: 'Phone no. is required',
                maxlength: 'Maximum {0} characters allowed.',
                remote: 'Invalid phone no entered.'
            },
            "address[address1]":{
                required: 'Address is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "address[address2]":{
                maxlength: 'Maximum {0} characters allowed.'
            },
            "address[city]":{
                required: 'City name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "address[state_name]":{
                required: 'State name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "address[zipcode]":{
                required: 'Zipcode is required.',
                maxlength: 'Maximum {0} characters allowed.'
            }
        }
    });
 //    return result;

 if(result.valid()){
            //App.blockUI($('#move_add_up'));
            console.log("its coming as a valid form ");
        }
        else{
            console.log("not yet valid form !");
        }
}