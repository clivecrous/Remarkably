require '../loadpath'
require 'remarkably/engines/html'
require 'remarkably/engines/css/helpers'

class Site
  include Remarkably::Common

  def index
    page do
      P "Hello World!"
    end
  end

  def exit
    page do
      P "Goodbye cruel world"
    end
  end

  private

  def page
    html do
      head do
        title "A basic Remarkably HTML example"
        style do
          body {
            margin 0
            padding 0
            font_size 12.pt
            background_color :white
          }
          div("#header") {
            margin 0
            padding 0
            background_color "#ffd"
            border_bottom 1.px, :dashed, :black
            h1 {
              margin 0
              padding 0, 0, 4.px, 0
              text_align :center
              font_size 24.pt
              font_weight :normal
              a {
                color :black
              }
            }
          }
          div("#footer") {
            text_align :right
            font_size 9.pt
            margin 16.px, 0, 0, 0
            padding 0
            border_top 1.px, :solid, :black
          }
          div("#content") {
            margin 16.px
          }
          a {
            color :blue
          }
          a(":hover") {
            color :red
          }
        end
      end
      body do
        div :id => "header" do
          h1 do
            text "A basic "
            a "Remarkably", :href => "http://www.darkarts.co.za/project/remarkably"
            text " HTML example"
          end
        end
        div :id => "content" do
          yield
        end
        div :id => "footer" do
          text "This was a "
          a "Remarkably", :href => "http://www.darkarts.co.za/project/remarkably"
          text " example."
        end
      end
    end
  end

end

site = Site.new

puts "\n== Index Page ==\n"
puts site.index.to_s

puts "\n== Exit Page ==\n"
puts site.exit.to_s
