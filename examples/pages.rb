require 'remarkably'

class Page
  include Remarkably

  def menu
    div :class=>"menu" do
      ul do
        li 'foo'
        li 'bar'
        li 'baz'
      end
    end
  end

  def footer
    div "This is a footer", :class=>"footer"
  end

  def normal_content
    P "Hello World!"
  end

  def other_content
    P "Goodbye World!"
  end

  def page content
    html do
      head do
        title "Test Page"
      end
      body do
        menu
        if content.class == Symbol
          send content
        else
          text content.to_s
        end
        footer
      end
    end
  end

  def main_page
    page :normal_content
  end

  def exit_page
    page :other_content
  end
end

page = Page.new
puts "Main Page => #{page.main_page.remarkably}"
puts "Exit Page => #{page.exit_page.remarkably}"
puts "Custom Page => #{page.page( "<p>Some other content</p>" ).remarkably}"
