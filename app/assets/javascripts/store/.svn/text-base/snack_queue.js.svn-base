$(document).ready(function(){

    $( ".on_hover" ).mouseover(function() {
        $(".selectpicker").css("background-color","#00ADEE");
        $(".selectpicker").css("color","white"); 
        $(".dropdown-menu").css("background-color","white");
        $(".selectpicker").css("text-align","center");
    });

    $('#order_selection').selectpicker({ 'selectedText': '',style:'btn-lg' });

    /* Description: On changing the subscription value from the snacks queue pages (dropdown list), it will give a call
     to edit_snack_queue(in orders_controller_decorator.rb) and will update the carts in the page as per the selected
     subscription.
     */
    $(function(){
        $('#user_subscription').on("change", "select#order_selection",function() {

            App.blockUI($('#complete_queue'));
            var sub_id = $('option:selected', this).val();
            $("#incomplete_snack_queue").empty();

            $.ajax({
                url: '/spree/orders/edit_snack_queue',
                data: {subscription_id: sub_id},
                type: "post",
                success: function(data){
                    console.log("edit your subscription.")
                },

                failure: function(data){
                    console.log("some error occured while editing subscription");
                }
            });

            });
    });


    $("div#snack_update").on("click", "#update_snack", function(e){
        e.preventDefault();
        check_snack_queue_complete($("#updated_carts").val());
    });


}); /* End of document.ready */


/*
 Description: below ajax call will check whether all the carts in current subscription are filled or not by calling
 the check_cart_status action in orders_controller_decorator action.
 */

    function check_snack_queue_complete(updated_cart_ids){    //[100,101,102]

        $.ajax({
            url: '/carts/check_cart_status/',
            method: 'post',
            datatype: "json",
            data: updated_cart_ids,
            success: function(msg){
                console.log("success");
                $('html').ScrollTo({
                    duration: 1000
                });

                if(msg == "true"){
                    $("#snack_queue_update").submit();
                    //submit it if carts are full.
                }
                if(msg == "false"){
                    console.log("incomplete cart");
                    $("#incomplete_snack_queue").html("Your Snack Queue is incomplete.");
                    $("#incomplete_snack_queue").show();
                    //else just toggle message at the top.(your cart i )
                }
            }
        });
    }  /* End of the check_snack_queue_complete function */
