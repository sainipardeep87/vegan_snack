$(document).ready(function(){
    
    $("#new_spree_user").validate({
              
        debug: true,
        rules: {
            
            'spree_user[address][firstname]':{
                required:true,
                 maxlength: 30
            },
            'spree_user[address][lastname]':{
                required:true,
                maxlength: 30
            },
           
            'spree_user[email]':{
                required: true,
                email: true,
                maxlength: 30
            },
            'spree_user[address][phone]':{
                required: true,
                maxlength: 15
            },
            'spree_user[address][company]':{
                maxlength: 30
            },
            'spree_user[address][address1]':{
                required: true,
                maxlength: 30
            },
            'spree_user[address][address2]':{
                maxlength: 30
           },
           'spree_user[address][city]':{
                required: true,
                maxlength: 30
                
           },
           'spree_user[address][state_name]':{
                required: true
           },
           'spree_user[address][zipcode]':{
                required: true,
                maxlength: 10
           },
           'spree_user[password]':{
                required: true,
                minlength: 6
           },
           'spree_user[password_confirmation]':{
                required: true,
                minlength: 6,
                equalTo: "#spree_user_password"
           }
           
        },
        messages: {
            'spree_user[address][firstname]':{
                required: "Name Can't be blank",
                maxlength: "Entered text exceeds maximum limit {0}"
            },
               
            'spree_user[last_name]':{
                required: "Last Name Can't be blank",
                maxlength: "Entered text exceeds maximum limit {0}"
            }
        },

        submitHandler: function (form) {
            $("#submitBtn").prop("disabled", true);
            form.submit();
        }
          
    });

});