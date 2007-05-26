require '../loadpath'
require 'remarkably/engines/xml'

class Products
  include Remarkably::Common

  def range
    products do
      (1...10).each do |product_number|
        product :id => product_number do
          colour %w{red green blue yellow black}[product_number%5]
          description "This is the description for product No #{product_number}"
        end
      end
    end
  end

  def range_page
    html do
      head do
        title "Our product range"
      end
      body do
        h1 "Our product range"
        table do
          tr do
            th "Product ID"
            th "Product Description"
            th "Colour"
          end
          (1...10).each do |product_number|
            tr do
              td product_number
              td "This is the description for product No #{product_number}"
              td %w{red green blue yellow black}[product_number%5]
            end
          end
        end
      end
    end
  end

end

our_products = Products.new

puts "\n== Product Range ==\n"
puts our_products.range.to_s

puts "\n== Product Range web page ==\n"
puts our_products.range_page.to_s
