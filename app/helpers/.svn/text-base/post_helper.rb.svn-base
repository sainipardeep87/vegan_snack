module PostHelper

=begin
      Description:Pass already existing tags list to blog post(edit action)
=end
    def get_list_of_tags_in_edit_form(selected_post)
        selected_post.tags.pluck(:tagname).join(',')
    end


=begin
    Description: Method will be sending respective social media sharing links depending on type of media.
    Argument: social_media
    return: String
=end

  def get_social_sharing_links(social_media)
    "https://www.facebook.com/sharer/sharer.php?t=#{@post.title}&u=#{post_url(@post)}" if social_media == "facebook"
    #"https://plus.google.com/share?url=#{post_url(@post)}&t=#{@post.title}" if social_media == "google_plus"
  end

end