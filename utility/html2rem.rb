require 'rubygems'
require 'xml/libxml'

def process_element( element, level = 0)
  children = 0
  element.each_child { children+=1 }

  if element.text?
    text = element.to_s.strip
    return if text.size == 0
  else
    if children == 1 and element.child.name == "text"
      text = element.child.to_s.strip
    else
      text = nil
    end
  end

  element.name = "P" if element.name == "p"

  indentation = ' '*level
  print indentation + "#{element.name.strip}"

  if text and element.name != "text"
    print " \"#{text}\""
  end

  attributes=[]
  element.each_attr do |attribute|
    if attribute.name.grep( /-/ ).size > 0
      attributes << "\"#{attribute.name}\" => \"#{attribute.value}\""
    else
      attributes << ":#{attribute.name} => \"#{attribute.value}\""
    end
  end
  if not attributes.empty?
    print "," if text and element.name != "text"
    print " "+attributes.join(', ').strip 
  end
  if not (text and element.name != "text")
    if element.children?
      puts " do"
      element.each do |inner_element|
        process_element( inner_element, level + 2 )
      end
      print indentation + "end" if element.children?
    else
      print " \"#{text}\"" if text
    end
  end
  print "\n"
end

html =  XML::Document.file( ARGV[0] ) 
process_element( html.root )
