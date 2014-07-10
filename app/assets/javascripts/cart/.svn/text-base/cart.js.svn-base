ready = function(){

    $(".new-sub-snacks").on("click","a", function(){
        console.log("clicked");
        App.blockUI($('#snack_show_modal_content'));
    });

   //to show the count down timer in the snack queue page.
    show_snack_queue_timer();

    //to toggle the snack details with the snack list modal window(in snack list page)
    toggle_snack_details_modal();

    //will bind the on hover(show details/shipping) effects once item is added/removed(in snack queue)
    bind_hover_effect_on_snack();


   //binding the remove snack option in new subscription section.
    $("#new_subscription_list").on("click", ".new-sub-snack-remove", function(){
        console.log("RM_19");
        remove_snack_item($(this));
    });

    //binding the remove snack option in the snack queue page.
    $(".snack-queue-page").on("click", ".snack-remove", function(){
        remove_snack_item($(this));
    });

    //Binding the remove snack option in the update subscription section.
    $("#subscription_update_section").on("click", ".update-page-snack-remove", function(){
        remove_snack_item($(this));
    });


 /* Description: Below function will call the carts/remove_item action to remove one item from
    new/update subscription, Snack queue page.
    Argument List: snack_tab(id)
    Return: nil
*/
    function remove_snack_item(snack_tab){

        var cart_item_id = $(snack_tab).children("#cart_item_id").val();
        var cart_id = $(snack_tab).children("#cart_id").val();
        var color_code = $(snack_tab).children("#color_id").val();

        $.ajax({
            url: '/carts/remove_item',
            data: {cart_item_id: cart_item_id, cart_id: cart_id, color_code: color_code},
            type: "post",
            success: function(data){
                console.log("Snack Item removed Successfully!");
            },

            failure: function(){
                cosole.log("Please try after refreshing the page");
            }
        });
    }

/* Description: Below function will show the product details on
    clicking over each product tab in snack list page.
*/

    $(document).on("click", "#hover_section", function(){

        var snack_id = $("#snack_id", this).val();

        $.ajax({
           url: '/spree/products/product_details',
           data: {snack_id: snack_id},
           type: "post",
           dataType: "json",

           success: function(data){

            show_snack(
                data.snack_detail.name,
                data.snack_detail.description,
                data.snack_detail.ingredients,
                data.snack_image,
                data.snack_nutritional_fact_image
            )
           },
           failure: function(error){
                console.log("Some Error"+ error);
           }
        });
    });

/* Description: Below ajax call function will trigger the remove_item action written under
    carts_controller to remove an item from the queue.
*/
     $("#complete_queue").on("click", ".sub-snack-tab", function(){
        var item_id = $(this).attr('id'); //item needs to be removed.
        var quantity = 1 ;
        App.blockUI($(this));

        $.ajax({
            url: "/carts/remove_item",
            data: {variant_id: item_id, quantity: quantity},
            type: "post",
            dataType: "json",
            success: function(data){
                console.log("104_RM");
            },
            failure: function(error){
                console.log(error);
            }
        });
    });

/* Description: ON changing the payment choice section, it wil toggle user with options to
    select from existing cards or enter new card
*/
    $("#payment_choice").on("change", "#payment_selection", function() {

        var n = $(this).val();
        $("div#payment_area").empty('');
        switch(n)
        {
            case 'select existing card':
                $("div#payment_area").append($("#existing_card").html());
                break;
            case 'add a new card':
                $("div#payment_area").append($("#new_card").html());
                break;
        }
    });

/* ON changing address selection it will toggle user with options to select existing address or enter new address */
    $("#complete_add_body").on("change","#address_selection", function(){

        //value will be  either select existing address or add New shipping address.
        var selected_address = $(this).val();

        console.log(selected_address);

        $("#ship_area").empty('');
        $('.snack-added').hide();

        switch(selected_address){
            case 'select existing Shipping Address':
                //if user has selected existing shipping address, then append the relevant div in ship_area
                $("#ship_area").append($("#existing_address").html());
                break;
            case 'Add a new Shipping Address':
                //if user has chosen for new address, then append the required ship address for in that area.
                $("#ship_area").append($("#new_address").html());
                $(".address-section").height($(document).height());
                break;
        }
    });

};

$(document).ready(ready);
$(document).on("page:load", ready);
    $('.each-ingredient').show();

/*  Description:  Below function will show snacks details over the complete description of a snack
    Argument: snack_name, snack_Description, snack_image_link
    Return: nil
*/
    function show_snack(name, description, ingredients, image_link, nutritional_fact_image){

        $('#each-ingredient').hide();
        if(name == ""){
            $("#snack_s_name").text("Oops! Something Went Wrong!");
            $("#snack_s_desc").remove();
            $("#snack_s_image").remove();
            $('.add_nutri_image').remove();
            $("#snack_show_modal_content").css("height", "auto");
        }
        else{
            $("#snack_s_name").text(name);
            $('#snack_s_desc').text(description);
            $('#add_nutri_image img').attr("src", nutritional_fact_image);
            $("#snack_s_image").attr('src',image_link);
            $('#each-ingredient').html(ingredients);
            $('#myModal').modal();
        }

        $(".ingredient-button").on("click", function(){
            $('#add_nutri_image').hide();
            $('#each-ingredient').show();
        });

        $(".nutrition-button").on("click", function(){
            $('#add_nutri_image').show();
            $('#each-ingredient').hide();
        });
        $("#snack_show_modal_content").toggle();
        $("#myModal").modal();
    }

/* Description: below function will bind the hover effect on each snack image */
 function bind_hover_effect_on_snack(){

     /* On hovering over a snack in New Subscription page , it will show the transparent remove image */
     $('div.new-snack-box').on("mouseover", function(){
         $(this).children().filter('.new-sub-snack-remove').attr('style','display:block !important');
     });

     $('div.new-snack-box').on("mouseout", function(){
         $(this).children().filter('.new-sub-snack-remove').attr('style','display:none !important')
     });

     /* make remove message visible on hover in update subscription page */
     $('div.update-snack-box').on("mouseover", function(){
         $(this).children().filter('.update-page-snack-remove').attr('style','display:block !important');
     });

     $('div.update-snack-box').on("mouseout", function(){
         $(this).children().filter('.update-page-snack-remove').attr('style','display:none !important')
     });

     /* make remove message visible on hover in Snack Queue page */
     $('div.cart-row-snack').on("mouseover", function(){
         $(this).children().filter('.snack-remove').attr('style','display:block !important');
     });

     $('div.cart-row-snack').on("mouseout", function(){
         $(this).children().filter('.snack-remove').attr('style','display:none !important')
     });

     $('div.cart-row-snack').on("mouseover", function(){
         $(this).children().filter('.ship-hover').attr('style','display:block !important');
     });

     $('div.cart-row-snack').on("mouseout", function(){
         $(this).children().filter('.ship-hover').attr('style','display:none !important')
     });

 }

/*
Description: Below function will fetch the remaining time to update the Snack Queue(row) and append the same in the
    "your current order will ship by June10,2014 calendar" section. this section can be found in _cart_row.html.erb.
    Those exact time is being caught from the .cart_time div which is present in _cart_row.html.erb file.
 */
function show_snack_queue_timer(){

    var remaining_time = new Date($("#cart_time").text());
    // console.log(remaining_time);
    $('#time_left').countdown({
        until: remaining_time,
        layout: '{dn} {dl}, {hn} {hl}, {mn} {ml} and {sn} {sl} to modify'
    });

}

function add_snack(variant_id, cart_id){

    App.blockUI($('#snack_show_modal_content'));
    console.log(variant_id);
    console.log(cart_id);

    $.ajax({
        url: '/carts/add',
        data: {cart_id: cart_id, variant_id: variant_id},
        type: "post",
        success: function(data){
            console.log("Snack Item added Successfully!");
        },
        failure: function(){
            cosole.log("Please try after refreshing the page");
        }
    });
}

/* Description: Below call will open the modal window of snack list
   Temporarily  disabling this particular function, as this was before used in the snack queue page
*/

function pop_modal(cart_id) {
    $(".snack-added").empty();
    console.log('In pop_modal');
    console.log(cart_id);
    if(typeof cart_id === "undefined"){
    }
    else{
        var cart_id = cart_id.toString().match(/\d+/)[0];
        set_delivery_date_and_snack_count(cart_id)
    }
    $("#snacks_modal").modal();
}


/*  Description: below method will open the "snack list" Modal window on Clicking  over the
    blank tile "ADD A SNACK" oin snack queue page.
*/
function open_snack_modal_in_queue (modal_id) {
    $(".snack-added").empty();
    set_delivery_date_and_snack_count(null);
    $(modal_id).modal();
}

/* Description:  Below function will call the get_notification in carts_controller and will update the
   current cart status(5/10) in snack list modal
   Argument List: cart_id
 */
function set_delivery_date_and_snack_count(cart_id){

   console.log("this cart is being sent" + cart_id);

    $.ajax({
        url: '/carts/get_notification',
        data: {cart_id: cart_id},
        method: 'post',
        dataType: 'JSON',
        success: function(result){

            if (result.hasOwnProperty('status_count')){
             $(".snack-added").html(result['status_count']);
             $(".snack-added").show();
            }

            if(result.hasOwnProperty('order_delivery_date')){

                var delivery_date = result["order_delivery_date"];
                var color_code = result["color_code"]
                var snack_count =  result['snack_count']

                $(".snack-added").html(snack_count);
                $(".snack-added").show();

                $("#queue_cart_delivery_date").text(result["order_delivery_date"].concat(" order "));

                set_delivery_box_background_color(color_code);
            }
        },
        failure: function(data){
            console.log('some error occurred');
        }
    });
}

/* DescriptioN :following function will set the background color of the delivery date tab which appears on the
    snack modal in sanck queue page
    Argument List: color_code
 */

function set_delivery_box_background_color(color_code){

    switch(color_code)
    {
        case 0:
            $("#queue_cart_delivery_date").css("background-color", "#FF6501");
            break;
        case 1:
            $("#queue_cart_delivery_date").css("background-color", "#3AAA3E");
            break;
        case 2:
            $("#queue_cart_delivery_date").css("background-color", "#FFB600");
            break;
        default:
            console.log("escaped color code" + color_code);
    }
}

/* Description :below function will add snacks to snack queue page, this function will never be used/called
 during new subscription creation or update, this is specifically for the snack queue page
 Argument List : variant_id, cart_id
 */
function add_snack_in_queue_page(variant_id, cart_id){

    App.blockUI($('#snack_show_modal_content'));
    console.log("going for snack queue page functionality change");
    console.log(variant_id);
    console.log(cart_id);

    $.ajax({
        url: '/carts/add_snack_to_queue',
        data: {cart_id: cart_id, variant_id: variant_id},
        type: "post",
        success: function(result){
            console.log("388");
        },
        failure: function(error){
            console.log(error);
        }
    });
}

/* Description: Below function will toggle the snack details modal window & the snack list modal
window(in snack queue).
*/
function toggle_snack_details_modal(){

    $(document).on("click", "#close_product_view", function(){
        $("#myModal").modal("toggle");
        $('#add_nutri_image').show();
        $('#each-ingredient').hide();
        $("#snack_show_modal_content").toggle();
    });

}