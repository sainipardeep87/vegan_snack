$(document).ready(function(){

/* ON clicking the "complete payment " button while creating new subscription, this will show the loader */
    show_loader_during_payment();

    //$("#new_card").on("submit", "#subscription_payment", function(event){
    /*
        $(document).on("click", "#add_cc_card", function(event){

            App.blockUI($('.change-body'));

            event.preventDefault();

        var result = $("#subscription_payment").validate({
            rules:{
                "creditcard[cardholder_name]": {
                    required: true,
                    maxlength: 50
                },
                "creditcard[card_no]": {
                    required: true,
                    maxlength: 25
                },

                "creditcard[cvv]":{
                    required: true,
                    maxlength: 5
                },
                "creditcard[month]":{
                    selectcheck: true
                },
                "creditcard[year]": {
                    selectcheck: true
                }
            },
            messages:{
                "creditcard[cardholder_name]": {
                    required: 'Name is mandatory.',
                    maxlength: ' Maximum {0} characters allowed.'
                },
                "creditcard[card_no]": {
                    required: 'Card no is mandatory.',
                    maxlength: ' Maximum {0} characters allowed.'
                },

                "creditcard[cvv]":{
                    required: 'CVV is mandatory.',
                    maxlength: ' Maximum {0} characters allowed.'
                },
                "creditcard[month]":{
                    selectcheck: 'This field is required.'
                },
                "creditcard[year]": {
                    selectcheck: 'This field is required.'
                }
            }
        });


    });
     */
/* Description: On submitting the address form(shipping address for during new subscription),
    this will be validated first using below save_shipping_address_details method call.
 */
     $(document).on('submit','form#new_address_id', function(event){
         event.preventDefault();
         result = validate_address_form("#new_address_id");

         if(result.valid()){
             save_shipping_address_details();
         }
    });

/* Description: Below method will validate the billing address form and on successful validation
    it will save the particular billing address form.
 */
    $(document).on('click','#new_billing_btn', function(event){
        event.preventDefault();
        result = validate_address_form("#billing_address_id");

        if(result.valid()){
            save_billing_address_details();
        }

    });

/* Description: In new subscription(shipping address form) if user selects to chose from existing
   addresses then this method will fetch the required address_id and then billing address form will
   be called.
    */
    $(document).on("submit", "form#existing_address_id", function(event){
        event.preventDefault();
        var selected_shipping_address_id = $("input[type='radio'][name='address[id]']:checked").val();
        show_billing_address_form(selected_shipping_address_id);
    });


}); // End of document.ready

/* Description: During payment (while creating new subscription) when user clicks on "complete payment" the loader will appear */
    function show_loader_during_payment(){

        $(document).on("click", "#add_cc_card", function(event){
            App.blockUI($('.change-body'));
            console.log("cc card clicked");
        });
    }

    function withdraw_loader(){
        App.unBlockUI($('.change-body'));
        $("#payment_card_error").text("Some error occured. Please try refreshing page.");
        $("#payment_card_error").show();
    }

// on blur over the creditcards nos field,(new subscription) this will trim the input field values.
    $(document).on("blur", "#creditcard_card_no", function(){
        var trimmed =  $(this).val().replace(/\s+/g, '');
        $(this).val(trimmed);
    });

/* Description: Below function will save the billing address form details and on
    successful saving of this address, the payment form will be populated in the pag.e
 */
    function save_billing_address_details(){

        data = $("form#billing_address_id").serialize();

        $.ajax({
            url:'/users/billing_address',
            data: data,
            dataType:'json',
            method:'POST',
            success: function(message){
                console.log("adv_119");

                if (message['message'] == 'success'){
                    show_payment_form(message['shipping_id'], message['billing_address_id']);
                }

                else{
                    render_error_in_address_form(message);
                }
            },
            failure: function(error){
                console.log(error);
            }
        });
    }
// Description: Following method will  Add client side validation on address Details form

    function validate_address_form(form){
        var result = $(form).validate({
        rules: {
            "firstname": {
                required: true,
                maxlength: 50
            },
            "lastname": {
                required: true,
                maxlength: 50
            },

            "address1":{
                required: true,
                maxlength: 50
            },
            "address2":{
                maxlength: 50
            },
            "city":{
                required: true,
                maxlength: 50
            },
            "state_name":{
                required: true,
                maxlength: 50
            },
            "zipcode":{
                required: true,
                maxlength: 50
            }
        },
        messages: {
            "firstname": {
                required: 'First name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "lastname": {
                required: 'Last name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "address1":{
                required: 'Address is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "address2":{
                maxlength: 'Maximum {0} characters allowed.'
            },
            "city":{
                required: 'City name is required',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "state_name":{
                required: 'State name is required.',
                maxlength: 'Maximum {0} characters allowed.'
            },
            "zipcode":{
                required: 'Zipcode is required.',
                maxlength: 'Maximum {0} characters allowed.'
            }
        }
        });
        result.form();
        return result;
    }

/* Description: Below function will save the shipping address details and populate a new billing
   address form to be filled up.
 */
    function save_shipping_address_details()
    {
        var shipping_address_data = $('#new_address_id').serialize();

        $.ajax({
            url:'/users/new_address',
            data: shipping_address_data,
            dataType:'json',
            method:'POST',
            success: function(result){
                console.log(result);
                if (result['message'] == 'success'){
                    var shipping_address_id = result["shipping_address_id"]
                    show_billing_address_form(shipping_address_id);
                }
                else{
                    render_error_in_address_form(result);
                }
            }
        });
    }

//Description: Below function will show the billing address form to user .(new subscription section)
    function show_billing_address_form(shipping_address_id){

        $.ajax({
            url: '/users/new_billing_address',
            method: "get",
            success: function(resulted_form){
                $('#complete_add_body').html(resulted_form);
                $('#shipping_address_id').val(shipping_address_id);
                $(".address-section").height($(document).height());
            },
            failure: function(error){
                console.log(error);
            }
        });
    }

// Below function will show the payment form to user after completion of the billing address.
    function show_payment_form(shipping_address_id, billing_address){

        var content = $(".payment-check").html();
        $(".payment-check").html("");
        $('.change-body').html(content);
        $("#new_card").css("display","block");
        $(".snack-added").html("");
        $('.heading-info').html("COMPLETE PAYMENT");
        $('#shipping_id').val(shipping_address_id);
        $('#billing_address_id').val(billing_address);
        $(".address-section").height($(window).height());

    }

//Description: Below function will render the address related error messages below the necessary fields.

   function render_error_in_address_form(message){

       $.each(message,function(key,val){

           switch (key)
           {
               case 'firstname':
                   $("label[for='firstname']").html(val[0]);
                   break;
               case 'lastname':
                   $("label[for='lastname']").html(val[0]);
                   break;
               case 'address1':
                   $("label[for='address1']").html(val[0]);
                   break;
               case 'address2':
                   $("label[for='address2']").html(val[0]);
                   break;
               case 'city':
                   $("label[for='city']").html(val[0]);
                   break;
               case 'zipcode':
                   $("label[for='zipcode']").html(val[0]);
                   break;
               case 'state_name':
                   $("label[for='state_name']").html(val[0]);
                   break;
           }
       });
   }