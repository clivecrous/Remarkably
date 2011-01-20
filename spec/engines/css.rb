require 'remarkably/engines/css'

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

  it "uses css class" do
    div do
      css_class do
        foo do
          color :red
        end
      end
      bar? do
        color :blue
      end
      P do
        color :green
      end
    end.to_s.should == "div .foo {color:red}\ndiv .bar {color:blue}\ndiv p {color:green}\n"
  end

  it "uses css id" do
    div do
      css_id do
        foo do
          color :red
        end
        bar do
          color :blue
        end
      end
      baz! do
        color :green
      end
    end.to_s.should == "div #foo {color:red}\ndiv #bar {color:blue}\ndiv #baz {color:green}\n"
  end

  it "uses css pseudo" do
    css_pseudo do
      hover do
        color :red
      end
    end.to_s.should == ":hover {color:red}\n"
  end

end
