/*$(document).ready(function(){

    $('.sub-snack-tab').on("click", function(){
        var line_item_id = $(this).attr('id');
        var quantity = 1 ;

        $.ajax({
            url: "/spree/cart",
            data: {line_item_id: line_item_id, quantity: quantity},
            type: "patch"
        });
    });

});
*/

$(document).ready(function(){


    //will open the payment info modal, when customer clicks for subscription resume.
    ask_payment_on_subscription_resume();
    //on any cancel/pause option selection in subscription update page, loader will be shown.
    show_loader_on_subscription_update();

    show_modal_on_payment_submit();

    hide_subscription_notification();

});

/*
$(window).bind("load", function(){


});
*/
    function hide_subscription_notification(){

        setTimeout(function(){
            $("#sub_can_notify").fadeOut();
        }, 5000);

    }

    function show_modal_on_payment_submit(){

        $("#resume_form_footer").on("click", "#resume_form_submit", function(){
            $("#pay_charge").removeClass();
            $("#pay_charge").text("Payment in progress. Please wait...");
            App.blockUI($("#cc_show_modal_content"));
        });
    }
/*
    Description: Below method will ask for payment info when customer wishes to resume his subscription.
*/

    function ask_payment_on_subscription_resume(){

        $("#profile_sub_list").on("click", "#sub_resume", function(){

            var subscription_id = $(this).attr('data-sub-id');
            console.log("subscription_id is " + subscription_id);

            $.ajax({
                url: '/my_subscriptions/fetch_subscriptions_payment',
                data: {subscription_id: subscription_id},
                type: "post",
                success: function(payment_message){
                    preserve_subscription(subscription_id);
                    $("#pay_charge").removeClass();
                    $("#pay_charge").text(payment_message);
                    $("#card_modal").modal("show");
                },

                failure: function(error){
                    console.log("oops, some error occured" + error);
                }
            });
        });
    }

    function preserve_subscription(subscription_id){
        console.log("preserved id" + subscription_id);
        $("#resume_subscription").val(subscription_id);
    }

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