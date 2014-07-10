ready = function(){
    var slide_snack_names = [];
    var slide_links= [];
    var counter = 0;
    remove_tagname_from_post();

    $('#post_content img').addClass('img-thumbnail'); //Added responsive class to blog posts img section

    $("#hidden_snack_list a").each(function() {
        slide_snack_names.push($(this).text());
        slide_links.push($(this).attr('href'));
    });

    $(".slide-header-title  a").text(slide_snack_names[0]);

    $("#next_slide").on("click", function(){

        if(!$(this).hasClass("inactive")) {
            counter +=1;
            $(".slide-header-title a").text(slide_snack_names[counter]);
            $(".read-post a").attr('href', slide_links[counter]);
            $(".slide-header-title a").attr('href', slide_links[counter]);
        }
    }) ;

    $("#prev_slide").on("click", function(){

        if(!$(this).hasClass("inactive")) {
            counter -=1;
            $(".slide-header-title a").text(slide_snack_names[counter]);
            $(".read-post a").attr('href', slide_links[counter]);
            $(".slide-header-title a").attr('href', slide_links[counter]);
        }
    });
    
    $('.jcarousel img').width($('.jcarousel').width());
    $('.jcarousel img').height($('.jcarousel').height());

};


$(document).ready(ready);
$(document).on('page:load', ready);


(function($) {
    $(function() {
        $('.jcarousel').jcarousel();

        $('.jcarousel-control-prev') .on('jcarouselcontrol:active', function() {
                $(this).removeClass('inactive');
            }).on('jcarouselcontrol:inactive', function() {
                $(this).addClass('inactive');
            })
            .jcarouselControl({
                target: '-=1'
            });

        $('.jcarousel-control-next').on('jcarouselcontrol:active', function() {

                $(this).removeClass('inactive');
            }).on('jcarouselcontrol:inactive', function() {
                $(this).addClass('inactive');
            })
            .jcarouselControl({
                target: '+=1'
            });

        $('.jcarousel-pagination').on('jcarouselpagination:active', 'a', function() {
                $(this).addClass('active');
            }).on('jcarouselpagination:inactive', 'a', function() {
                $(this).removeClass('active');
            })
            .jcarouselPagination();
    });
})(jQuery);


 function remove_tagname_from_post() {
     $("#post_tags_tagname").tagsInput({
         'onRemoveTag' : function(tag){
             var hidden_post_id = $("#hidden_post_id").val();
             $.ajax({
                 url: "/posts/get_tag_details",
                 data:  {tag_name: tag},
                 cache: false,
                 type: "post"
             });
         }
     });
     $("#blog-tag-field").tagsInput({
//         'onRemoveTag' : function(tag){
//             var hidden_post_id = $("#hidden_post_id").val();
//             $.ajax({
//                 url: "/posts/get_tag_details",
//                 data:  {tag_name: tag},
//                 cache: false,
//                 type: "post"
//             });
//         }
     });
 }