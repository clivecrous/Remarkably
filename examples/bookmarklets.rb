require '../loadpath'
require 'remarkably/engines/html'
require 'remarkably/engines/html/helpers'

class Site
  include Remarkably::Common

  def index
    html do
      head do
        title "A Remarkably bookmarklet example"
      end
      body do
        h1 "The bookmarklet"
        P do
          text "Simply click \""
          java_script = %w{h1 h2 h3 h4 p a}.inject('') do |result,tag|
            result+= <<-EOS

tags = document.getElementsByTagName("#{tag}");
for (i=0;i<tags.length;i++) {
  header_content = tags[i].innerHTML;
  tags[i].innerHTML =
    '<span style="border:1px solid black;color:black;background-color:#FFA">&lt;#{tag}&gt;</span>' + header_content +
    '<span style="border:1px solid black;color:black;background-color:#FFA">&lt;/#{tag}&gt;</span>';
}

EOS
          end
          bookmarklet java_script, "Show some tags"
          text "\", or drag it and drop it on your toolbar to use it on any site."
        end
        h1 "Header 1"
        lorum_ipsum
        h2 "Header 2"
        lorum_ipsum
        h3 "Header 3"
        lorum_ipsum
        h3 "Header 3"
        lorum_ipsum
        h2 "Header 2"
        lorum_ipsum
        h3 "Header 3"
        lorum_ipsum
        h1 "Header 1"
        lorum_ipsum
        h2 "Header 2"
      end
    end
  end

  private

  def lorum_ipsum
    P <<-EOS
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vestibulum vehicula lectus vitae sapien. Nam quis lorem id velit tempor convallis. Nullam est orci, placerat a, hendrerit rutrum, dictum quis, magna. Nulla pharetra libero ac risus. Fusce in elit. Cras vel nisl nec enim tincidunt vehicula. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Praesent sollicitudin, libero sit amet hendrerit fermentum, odio nisl mollis enim, quis faucibus nisi nisi eu erat. Vivamus eu urna at velit mattis congue. Morbi feugiat erat vel libero.
    EOS
  end

end

puts Site.new.index.to_s
