require 'truncate_html'
require 'app/helpers/truncate_html_helper'

module Spree
  module OrdersHelper
    include TruncateHtmlHelper
=begin
  Description: Following method will truncate a products Description and will be passed to calling Section.
  Argument :  an object of Product
  Return: truncated result of a products complete description / String
=end
    def truncated_product_description(product)
      truncate_html(raw(product.description))
    end

  end
end