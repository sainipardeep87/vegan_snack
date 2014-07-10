
/* Description: setting the height and width of the container as per my screen/device width and height */

$(document).ready(function(){
    var width = $('html').width();
    var height = $('html').height();
    $('.container').width(width);
//    $('.container').height(height);
    $('.bg-image.span12').width($(window).width());
    $('.product-listing').height($(document).height());
});