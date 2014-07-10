class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :styles => { :content => '800>', :thumb => '118x100#' }

  validates_attachment_size :data, :less_than => 20.megabytes
  validates_attachment_presence :data

  validates_attachment_content_type :data,
                                    content_type: ["image/jpg","image/png","image/x-png","image/jpeg","image/bmp","image/pjpeg"],
                                    message:  "You may only upload .jpeg, .jpg, .bmp, .png files."

  def url_content
    url(:content)
  end
end
