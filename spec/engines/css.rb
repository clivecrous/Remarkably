require 'lib/remarkably/engines/css'

describe Remarkably::Engines::CSS do
  include Remarkably::Common

  before( :all ) do
    @remarkably_engine = Remarkably::Engines::CSS.new
  end

  it "Does basic styling" do
    body do
      P do
        background_color :white
        border "1px", :solid, :black
      end
      div do
        color :blue
      end
    end.to_s.should == "body p {background-color:white;border:1px solid black}\nbody div {color:blue}\n"
  end

end
