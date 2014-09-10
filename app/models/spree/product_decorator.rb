Spree::Product.class_eval do

  #has_many :subscriptions
  #has_many :users, through: :subscriptions
  belongs_to :vendor
  has_one :variant, :class_name => 'Spree::Variant', :foreign_key => 'product_id'
 
  validates :vendor_id, presence: true
=begin
  attr_accessor :nutritional_fact_image_file_name,
                 :nutritional_fact_image_content_type,
                 :nutritional_fact_image_file_size,
                 :nutritional_fact_image_updated_at

  attr_accessor :nutritional_fact_image
=end

  validates_attachment_size :nutritional_fact_image, :less_than => 20.megabytes
  #validates_attachment_presence :nutrional_fact_image

  validates_attachment_content_type :nutritional_fact_image,
    
      content_type: ["image/jpg","image/png","image/x-png","image/jpeg","image/bmp","image/pjpeg"],
      message:  "You may only upload .jpeg, .jpg, .bmp, .png files."


  has_attached_file :nutritional_fact_image,
      styles: {
        content: '800>',
        thumb: '118x100#',
        slide: "1122X378!",
        feature: "300X200!",
        recent: "325X220!",
        latest: "235X170!"
      },
      url: "/nutritional_fact/:id/:style_:basename.:extension"

=begin
Description: Following action will list all the snacks in listing page.
Argument: NIL
Return: Products with(id, name)
=end
  def get_snacks_list
    @complete_snacks_list = Spree::Product.select('id, name').limit(10).order("updated_at  desc")
  end

  

end