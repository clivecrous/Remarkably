require '../loadpath'
require 'remarkably/engines/css'
require 'remarkably/engines/css/helpers'

class Page
  include Remarkably::Common

  def style
    body do
      background_color :white
      color :black

      div( "#header" ) do
        ul do
          margin 0
          padding 8.px, 2.px, 4.px, 1.5.em
          li do
            padding_left 2.em
          end
        end
      end

      P do
        color :black
        font_size 12.pt
      end

      P(".special") do
        color :blue
      end

    end
  end

end

page = Page.new
puts page.style.to_s
