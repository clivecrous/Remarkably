require 'remarkably/engines/css'
require 'remarkably/engines/css/helpers'

describe "Remarkably::Engines::CSS Helpers" do
  include Remarkably::Common

  before( :all ) do
    @remarkably_engine = Remarkably::Engines::CSS.new
  end

  it "Uses numbers correctly" do
    body do
      P do
        background_color :white
        border 1.px, :solid, :black
        font_size 2.5.em
      end
      div do
        color :blue
      end
    end.to_s.should == "body p {background-color:white;border:1px solid black;font-size:2.5em}\nbody div {color:blue}\n"
  end

  it "uses arrays" do
    body do
      %w{h1 h2 h3}.css do
        color :blue
      end
    end.to_s.should == "body h1 {color:blue}\nbody h2 {color:blue}\nbody h3 {color:blue}\n"
  end

end
