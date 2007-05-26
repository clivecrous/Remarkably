require 'lib/remarkably/engines/css'
require 'lib/remarkably/engines/css/helpers'

describe "Remarkably::Engines::CSS Helpers" do
  include Remarkably::Common

  before( :all ) do
    @remarkably_engine = Remarkably::Engines::CSS.new
  end

  it "Uses helpers correctly" do
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

end
