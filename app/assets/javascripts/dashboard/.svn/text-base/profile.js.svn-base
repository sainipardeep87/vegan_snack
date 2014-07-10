ready = function(){

    resize_profile_container(); /* Resize container as per page/device width & height */

    $("#new_card").on("click", function(){
        $("#card_error").removeClass("visible");
        $("#card_error").addClass("invisible");
    });

    $("#edit_account").on("click", function(){
        update_user_account_details("#acc_data span", "#personal_profile_update input:text")
    });

    $("#edit_address").on("click", function(){
        update_user_account_details("#add_data span", "#address_profile_update input:text")
    });

    $("#credit_card_section").on("click", "#new_card", function(){
        $("#card_modal").modal();
    });

    /* On clicking edit link against my account section, it will remove the error messages & update notification from the
    modal window.
     */
    $("div#dash_personal").on("click", "#edit_account", function(){

        $("#personal_profile_update div.form-group label.address-err").empty();
        $(".update-notification").empty();

    });

    /* ON clicking the change password link, it will remove the error messages coming below the text fields. */

    $("#dash_personal").on("click", "#change_password", function(){
        /* clear the update notification that is present at the top of the password update modal window */
        $(".update-notification").empty();

        /* added js code to clear the error labels which gets appended during server side validation*/
        $("#password_update_form div label.error").empty();

        /* clearing input field values in case user has left fields after entering few characters in it */
        $("#password_update_form div input[type='password']").val('');
    });

    $('#left_account').on('click', '.confirm-address-delete', function(e) {

        e.preventDefault();
        var result = confirm("Are you sure to remove address ?");

        if(result == true){
            var address_id = $(this).attr('id');
            remove_address(address_id);
        }

    });

    enable_the_update_account_button();
};

/* Description: marking the button disabled will preven the form getting submitted multiple times on multiple
    click, hence after successful update, marking it as disabled true. again when user clicks on the edit link
    then it's marked as active again by setting its attribute to "disabled" "false"
*/

    function enable_the_update_account_button(){
        $(document).on("click", "#edit_account", function(){
            console.log("marking it enable again");
            $("#account_sub_btn").attr("disabled", false);
        });
    }
/*
    Description: Following function will remove the incomplete addresses(where the payment was declined)
    argument list: address_id
    return: nil
*/
    function remove_address(address_id){

        $.ajax({
            url:'/users/remove_address',
            dataType: "json",
            data: {id: address_id},
            type:'post',
            success: function(msg){

                 if(msg == "true"){
                     location.reload();
                 }
            },
            failure: function(error){
                console.log(error);
            }
        });
    }

$(document).ready(ready);
$(document).on("page:load", ready);

/*
 Function Name: resize_profile_container
 Description: Following method will resize the contaniner as per the device/page width & height.
 Argument List: NIL
 Return: NIL
 */
function resize_profile_container(){
    $('.user-profile').width($(window).width());
    $('.user-profile').height($(window).height());
    $('.profile-body').width($(window).width());
    $('.profile-body').height($(window).height()+100);
}

/*

 Description: Following method will copy user details from View page to the modal window.
 Argument List: view element, modal input elements.
 Return: NIL
*/


function update_user_account_details(source, destination){

    var personal_details = [];
    var counter = 0;

    $('span.error').hide();

    $(source).each(function(){
        personal_details.push($(this).text().trim());
    });

    $(destination).each(function() {
        $(this).val(personal_details[counter]);
        counter++;
    });

}

/* Function Name: validate_personal_info-modal_form
 Description : Following method will perform client side validation on the form present with the modal.
 */

function validate_personal_details(){

    $("#j_profile_account_update form").validate({
        rules:{
            "user[first_name]":{
                required: true,
                maxlength: 50
            },
            "user[last_name]":{
                required: true,
                maxlength: 50
            }
         },
        messages:{
              "user[first_name]":{
                required: 'firstname is required.',
                maxlength: "Maximum {0} characters allowed."
            },
            "user[last_name]":{
                required: 'lastname is required.',
                maxlength: "Maximum {0} characters allowed."
            }
        }
    });
}