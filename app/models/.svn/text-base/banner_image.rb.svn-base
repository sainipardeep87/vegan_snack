class BannerImage < ActiveRecord::Base

	belongs_to :post
	has_attached_file :image

  # validates :image, presence: { message: "You hav to upload atleast 1 banner image."}
	validates_attachment_content_type :image, :content_type => ['image/jpeg','image/png','image/jpg', "image/pjpeg","image/x-png", "image/gif" ],
                                    :message => " Please upload only jpeg, jpg, png images.", :allow_blank => true

                                    
end
