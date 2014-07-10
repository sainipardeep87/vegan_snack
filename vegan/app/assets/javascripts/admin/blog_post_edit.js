
$( document ).ready(function() {

    $("#post_tags_tagname").tagsInput({
        'onRemoveTag' : function(tag){
             console.log(tag);
            var hidden_post_id = $("#hidden_post_id").val(); //Securing the post ID, in case if it's required.

            $.ajax({
                url: "/posts/get_tag_details",
                data:  {tag_name: tag},
                cache: false,
                type: "post"
            });
        }
    });

});