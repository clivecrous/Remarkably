require 'remarkably'

class Page
  include Remarkably

  def main_page
    page do
      P "Hello World!"
    end
  end

  def exit_page
    page do
      P "Goodbye World!"
    end
  end

  private

  def menu
    div :id=>"menu" do
      ul do
        li 'foo'
        li 'bar'
        li 'baz'
      end
    end
  end

  def footer
    div "This is a footer", :id=>"footer"
  end

  def page
    html do
      head do
        title "Test Page"
      end
      body do
        menu
        div :id => "content" do
          yield
        end
        footer
      end
    end
  end

end

page = Page.new
puts "Main Page => #{page.main_page.remarkably}"
puts "Exit Page => #{page.exit_page.remarkably}"
