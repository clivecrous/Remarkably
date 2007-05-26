require '../lib/remarkably'

class Page
  include Remarkably

  def initialize
    @title = "A Basic Remamarkably example"
  end

  def draw
    html do
      head do
        title @title
      end
      body do
        h1 @title
        hr
        P "Hello and welcome to Remarkably. This is a very basic example on how to get a basic page up."
        hr
      end
    end
  end

end

puts Page.new.draw.to_s
