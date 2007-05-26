require 'lib/remarkably/engines/xml'

describe "Remarkably::Engine::XML instance_eval" do
  it "performs an instance_eval when a block is given to new" do
    Remarkably::Engines::XML.new do
      html do
        body do
          P "Hello World!"
        end
      end
    end.to_s.should == "<html><body><p>Hello World!</p></body></html>"
  end
end

describe Remarkably::Engines::XML do
  include Remarkably::Common

  before( :all ) do
    @remarkably_engine = Remarkably::Engines::XML.new
  end

  it "Accepts a string as a paramater" do
    testing( "Hello World" ).to_s.should ==
      "<testing>Hello World</testing>"
  end

  it "Accepts a block as a paramater" do
    testing do
      text "Hello World"
    end.to_s.should ==
      "<testing>Hello World</testing>"
  end

  it "Accepts multiple strings as paramaters" do
    testing( "Hello", "World" ).to_s.should ==
      "<testing>HelloWorld</testing>"
  end

  it "Closes empty tags neatly" do
    testing.to_s.should ==
      "<testing/>"
  end

  it "Accepts only attributes" do
    testing( :id => "attributes" ).to_s.should ==
      '<testing id="attributes"/>'
  end

  it "Accepts strings and attributes" do
    testing( "Hello ", "World",
             :id => "attributes", :class => "test" ).to_s.should ==
      '<testing class="test" id="attributes">Hello World</testing>'
  end

  it "Allows yielding for internal content" do
    def page
      html do
        body do
          yield
        end
      end
    end
      
    page do
      P "Internal Content"
    end.to_s.should == "<html><body><p>Internal Content</p></body></html>"
  end

  it "Does not auto-style" do
    html do
      head do
        style do
          body do
            color :blue
          end
        end
      end
    end.to_s.should == "<html><head><style><body><color>blue</color></body></style></head></html>"
  end

end
