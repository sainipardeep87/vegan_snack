class Post < ActiveRecord::Base
=begin
   Description: Schema Description for Post Class.

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_image_file_name"
    t.string   "post_image_content_type"
    t.integer  "post_image_file_size"
    t.datetime "post_image_updated_at"
  end
=end
  before_save :get_image
  #before_update :check_image
  #before_save :save_short_description
  has_and_belongs_to_many :tags
  has_many :banner_images, dependent: :destroy
  #accepts_nested_attributes_for :banner_images

  # has_many :banner_images, :dependent => :delete_all
  accepts_nested_attributes_for :banner_images, :allow_destroy => true
  #, :reject_if => proc { |attributes| attributes['banner_image'].blank? }

  has_many :comments, dependent: :destroy

  validates :title, presence: { message: "Blog post title is compulsory field."},
            uniqueness: { case_sensitive: false,  message: "Blog post with same title already taken." }


  validates :content, presence: {message: "Adding Content is Mandatory."}

  has_attached_file :post_image,
                    styles: { content: '800>', thumb: '118x100#', slide: "1122X378!", feature: "300X200!", recent: "325X220!", latest: "235X170!" },
                    url: "/blog_images/:id/:style_:basename.:extension"

=begin
DescriptioN: Following method will fetch image link from ckeditors saved location and save it to our post_image attribute.
Argument List: NIL
Return: NIL
=end
def get_image
  blog_contents = Nokogiri::HTML(self.content)

  if blog_contents.xpath("//img").blank?
    self.post_image = nil
    else
      image_link = blog_contents.xpath("//img")[0]['src']

      if image_link.include?("http://")
        self.post_image = File.open(image_link)
      else
        image_link = Dir.pwd.concat("/public" + image_link)
        self.post_image = File.open(image_link)
        end
    end

end

  #def save_short_description
  #  self.summary = "Oh to be Vegan! To all the nayasayers that think you can't have a heartly meal well here is an"
  #end

=begin
  # Description:  Following method saves the Added tags Tag_ID and post_id to the intermediate table posts_tags table.
  # Argument   : tag_id & post_id
  # Return     : NIL
=end
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
    @latest_p =Post.all.limit(post_count).order("updated_at  desc") #added for testin purpose as I am not getting post_image in show.
  end

=begin
          Description: : fetch snack name & ID to be slide on the the index section top part.
          Argument: NIL
         Return:  snack name, ID
=end
   def self.get_post(post_count)
     #post = Post.select('id, title, post_image').limit(post_count).order("created_at desc");
     post = Post.all.limit(post_count).order("created_at desc");
   end

end


#DXBPS5150J