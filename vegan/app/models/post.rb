class Post < ActiveRecord::Base

  # Description: Schema Description for Post Class.

  #create_table "posts", force: true do |t|
  #  t.string   "title"
  #  t.text     "content"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #  t.string   "post_image_file_name"
  #  t.string   "post_image_content_type"
  #  t.integer  "post_image_file_size"
  #  t.datetime "post_image_updated_at"
  #end

  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment :avatar, :presence => true,
  #                     :content_type => { :content_type => "image/jpg" },
  #                     :size => { :in => 0..10.kilobytes }

  has_and_belongs_to_many :tags

  has_many :comments, dependent: :destroy

  has_attached_file :post_image,
                    :styles => { :medium => "331x221#", :thumb => "275X183#" } #,
                    #:url  => "/assets/products/:id/:style/:basename.:extension",
                    #:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

                   # :url  => "/images/:id/:style/:basename.:extension",
                   # :path => ":rails_root/assets/images/:id/:style/:basename.:extension"

                   #:path => ":rails_root/public/system/:attachment/:username.:extension",
                   #:url  => "/:attachment/:username.:extension"

validates_attachment_content_type :post_image, :content_type => /\Aimage\/.*\Z/


  validates :title, :presence =>{:message => "Blog post title is compulsory field."},
            :uniqueness => { :case_sensitive => false,  :message => "Blog post with same title already taken."}


  validates :content, :presence =>{:message => "Adding Content is Mandatory."}


  after_save :save_blog_image

  ########################################################################################
  # Description:  Following method saves the Added tags Tag_ID and post_id to the intermediate table posts_tags table.
  # Argument   : tag_id & post_id
  # Return     : NIL
  ########################################################################################
  def insert_ids_to_post_tags(new_tag_id)
    insert_query = "INSERT INTO posts_tags(tag_id, post_id)VALUES(#{new_tag_id}, #{self.id});"
    ActiveRecord::Base.connection.execute(insert_query)
  end


=begin
  Description: On removing tag from post edit, at the backend following method will remove the tag_id & post_id link from posts_tags table
  Argument: tag_id
  Return: NIL
=end

  def self.remove_tagpost_link_from_posts_tag_table(tag_id)
    deletion_query = "DELETE FROM posts_tags WHERE tag_id=#{tag_id};"
    ActiveRecord::Base.connection.execute(deletion_query)
  end


=begin
  Description: On adding a new tag in New post page, this method will add the unregistered/new tag to Tag table and establish the link with post using posts_tags table
  Argument: tag_attribute_list, post_id
  Return: NIL
=end

  def save_new_tag_to_tag_table(tag_attributes)

    tag_attributes.split(",").each do |value|
      value=value.strip
      available_tag = Tag.where('tagname = ?', value).first #checking if added tag is available in the list/not.
      new_tag = Tag.create(:tagname => value) if available_tag.blank? #If it's a new tag then create and Add it to Tag list.
      available_tag.blank? ?  self.insert_ids_to_post_tags(new_tag.id) : self.insert_ids_to_post_tags(available_tag.id) #Depending on tag available or it's a new tag, updating post_tags tag.
    end

  end

=begin
  Description: On updating a post(in edit post), this method will filter the newly added tags to Tag table & establish the relation with post table(using posts_tags relational table)
  Argument: tag_attributes, post_id
  Return : NIL
=end

  def update_new_tag_to_tag_table(tag_attributes)

    tag_attributes.split(",").each do |value|
      value = value.strip
      is_a_new_tag = Tag.where(:tagname => value).blank?

        if is_a_new_tag
          new_tag = Tag.create(:tagname => value)
          insertion_query = "INSERT INTO posts_tags(tag_id, post_id)VALUES(#{new_tag.id}, #{self.id});"
          ActiveRecord::Base.connection.execute(insertion_query)
        end
    end
  end

=begin
   Descripition: Method fetches the most recent N  posts which will be rendered in right side panel.
   Argument: number_of_posts
  Return : NIL
=end

  def get_latest_post(post_count)
    #Post.select("title AS post_title, content AS post_body, post_image AS blog_image").limit(post_count).order("created_at desc")
    Post.all.limit(3).order("created_at desc") #added for testin purpose as I am not getting post_image in show.
  end

=begin
    Description: Method will be extracting the image from raw HTML content and save under avatar column.
    Argument: NIL
    Return: NIL
=end

  def save_blog_image

    #raise self.content.inspect
  end
end