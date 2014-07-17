$(document).ready(function(){
    //will open the payment info modal, when customer clicks for subscription resume.
    prompt_for_payment();
    //on any cancel/pause option selection in subscription update page, loader will be shown.
    show_loader_on_subscription_update();
    show_modal_on_payment_submit();
    hide_subscription_notification();
    update_creditcard();
});

    function hide_subscription_notification(){

        setTimeout(function(){
            $("#sub_can_notify").fadeOut();
        }, 5000);

    }

    function show_modal_on_payment_submit(){

    //resume_form_footer
    //profile_render
        $("#resume_form_footer").on("click", "#resume_form_submit", function(){
            $("#pay_charge").removeClass();
            $("#pay_charge").text("Processing your card. Please wait...");
            App.blockUI($("#cc_show_modal_content"));
        });

    }
/*
    Description: Below method will ask for payment info when customer wishes to resume his subscription.
*/
    function prompt_for_payment(){

        $("#profile_sub_list").on("click", ".sub-action", function(){

            var subscription_id = $(this).attr('data-sub-id');
            var action = $(this).attr('data-target');
            console.log("Going for action"+ action);

            $.ajax({
                url: '/my_subscriptions/fetch_subscriptions_payment',
                data: {subscription_id: subscription_id},
                async: false,
                type: "post",
                success: function(result){
                    preserve_subscription(subscription_id);
                    var used_card = result["card_id"]
                    //var used_card = preserve_creditcard(subscription_id);
                    if (action == "resume")
                        prepare_modal_for_resume();
                    if (action == 'unblock')
                        prepare_modal_for_unblock(used_card);
                    show_credit_card_modal(result["message"]);
                },

                failure: function(error){
                    console.log("some error occured" + error);
                }
            });
        });
    }

    function prepare_modal_for_resume(){
        $("#subscription_payment").attr("action", "/creditcards/pay");
        $("#subscription_payment").attr("method", "post");
        $("#resume_form_submit").val("complete payment and resume subscription");
    }

    function prepare_modal_for_unblock(card_id){
        var target_url  = "/creditcards/".concat(card_id);
        console.log("The target url is " + target_url);
        $("#subscription_payment").attr("action", target_url);
        $("#subscription_payment").attr("method", "post");
        $("#resume_form_submit").val("Update Card and unblock subscription");
    }

    function show_credit_card_modal(payment_message){
        $("#pay_charge").removeClass();
        $("#pay_charge").text(payment_message);
        $("#card_modal").modal("show");
    }

    function preserve_subscription(subscription_id){
        //value will be stored in the hidden field.
        $("#resume_subscription").val(subscription_id);
    }

/*
    Description: Managed this functionality with prompt_for_payment defined ajax call, marking it commented for now.
    function preserve_creditcard(subscription_id){
        $.ajax({
            url: '/spree/orders/get_card',
            method: "get",
            async: false,
            data: {subscription_id: subscription_id},
            success: function(result){
                if(result["message"] == "success")
                    $("#target_card").val(result["card_id"]);
                else
                    window.location.reload();
            },
            failure: function(error){
                console.log("Error occured "+ error);
            }
        });
        $("#target_card").val();
    }
*/
    function show_loader_on_subscription_update(){

        $("#sub_update_section").on("click", ".vegan-sub-btns", function(){
            App.blockUI($('.snack-queue-page'));
        });
    }

    function resume_subscription(card_id, subscription_id){

        $.ajax({
            url: '/my_subscriptions/resume/',
            type: 'post',
            datatype: 'json',
            data: {
                card_id: card_id,
                id: subscription_id
            },
            success: function(result){
                console.log(result);

                $("#pay_charge").text(result['message']);
                $("#pay_charge").removeClass();

                if(result["key"] == 'success'){
                    $("#pay_charge").removeClass().addClass("succ-msg");
                }

                if(result["key"] == 'error'){
                    $("#pay_charge").removeClass().addClass("unathorized-error");
                }

                setTimeout(function(){
                        App.unBlockUI($("#cc_show_modal_content"));
                        window.location.reload();
                }, 2500);
            },
            failure: function(error){
                console.log("error occured" + error);
            }
        });

    }
/*
    function unblock_subscription(card_id, subscription_id){


        $("#profile_sub_list").on("click", ".sub-action", function(){
            console.log("target chosen");
            var subscription_id = $(this).attr('data-sub-id');
            var action = $(this).attr('data-target');
            console.log("Going for action"+ action);

            $.ajax({
                url: '/my_subscriptions/fetch_subscriptions_payment',
                data: {subscription_id: subscription_id},
                async: false,
                type: "post",
                success: function(result){
                    preserve_subscription(subscription_id);
                    var used_card = result["card_id"]
                    //var used_card = preserve_creditcard(subscription_id);
                    if (action == "resume")
                        prepare_modal_for_resume();
                    if (action == 'unblock')
                        prepare_modal_for_unblock(used_card);
                    show_credit_card_modal(result["message"]);
                },

                failure: function(error){
                    console.log("some error occured" + error);
                }
            });
        });

    }
*/
    function unblock_subscription(card_id, subscription_id){
        $.ajax({
            url: '/my_subscriptions/unblock',
            method: "post",
            dataType: "json",
            data: {id: subscription_id, card_id: card_id},
            success: function(result){
                if(result["key"]== "success"){
                    $("#pay_charge").removeClass().addClass("succ-msg");
                    card_unblocked_confirmation(result["message"]);
                }
                if(result["key"]=="false"){
                    $("#pay_charge").removeClass().addClass("unathorized-error");
                    card_unblocked_confirmation(result["message"]);
                }
            },
            failure: function(error){
                console.log("some error occured" + error);
            }
        });
    }

    function update_creditcard(){

        $("#sub_update_section").on("click", "#sub_pay_update", function(){
            var subscription_id = $(this).attr('data-sub-id');

            $.ajax({
                url: "/my_subscriptions/fetch_used_card",
                type: 'get',
                datatype: "json",
                data: {id: subscription_id},
                success: function(result){
                    if(result["key"] == "success"){
                        console.log("sub.js #217 Going to update creditcard "+ result["card_id"]);
                        prepare_modal_for_card_update(result["card_id"]);
                        show_credit_card_modal("");
                        App.unBlockUI($('.snack-queue-page'));
                    }
                    if(result["key"] == "error"){
                        //handle this to dismiss the modal window and show error at the top of the page.
                        console.log(result["message"])
                    }
                },
                failure: function(error){
                    console.log("Error Occured" + error);
                }
            });//end of ajax call.
        });

    }

    function prepare_modal_for_card_update(card_id){
        var target_url = "/creditcards/"+ card_id + "?update=true"
        console.log("The target url is " + target_url);
        $("#subscription_payment").attr("action", target_url);
        $("#subscription_payment").attr("method", "post");
        $("#resume_form_submit").val("Update Card");
    }

    function card_updated_confirmation(){
        $("#pay_charge").text("Your Creditcard has been updated successfully. Please Wait...");
        App.unBlockUI($("#cc_show_modal_content"));
        reload_account();
    }

    function card_unblocked_confirmation(confirmation_message){
        $("#pay_charge").text(confirmation_message);
        App.unBlockUI($("#cc_show_modal_content"));
        reload_account();
    }

    function show_invalid_card_error(){
        $("#pay_charge").text("Invalid card details submitted.");
        $("#pay_charge").removeClass().addClass("unathorized-error");
        App.unBlockUI($("#cc_show_modal_content"));
    }

    function reload_account(){
        setTimeout(function(){
            window.location.reload();
        },2500);
    }