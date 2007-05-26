require 'remarkably'

class Page
  include Remarkably

  def header
    h1 { "A Header and Footer example with Remarkably" }
    hr
  end

  def footer
    hr
    text "Find out more about Remarkably "
    a(:href=>"http://www.darkarts.co.za") { "here" }
    text "."
  end

  def entire_page
    html do
      head do
        title { "Remarkably: Headers and Footers" }
      end
      body do
        header
        P { "This is some page content" }
        footer
      end
    end
  end

end

page = Page.new

puts "Just the header => #{page.header.remarkably}"
puts "Just the footer => #{page.footer.remarkably}"
puts "The entire page => #{page.entire_page.remarkably}"
