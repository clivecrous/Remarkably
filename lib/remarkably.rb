module Remarkably
  alias :ramazing_method_missing :method_missing
  def method_missing(sym, *args, &block)
    tag_attributes = args.size > 0 ? args[0] : {}
    return send( :ramazing_method_missing, sym, args, &block ) if args.size > 1 or tag_attributes.class != Hash
    tag! sym.to_s.downcase, tag_attributes, &block
  end
  def tag! tag, attributes, &block
    @remarkably = '' if !@remarkably
    tag_attributes = attributes.inject([]) do |result,data_pair|
      key,data = data_pair
      result << "#{key.to_s.downcase}=\"#{data.to_s}\""
    end.join(' ')
    @remarkably << "<#{tag}" +
      (tag_attributes.size > 0 ? ' ' + tag_attributes : '')
    if block_given?
      @remarkably << ">"
      result = block.call
      @remarkably << result.to_s if result.class != self.class
      @remarkably << "</#{tag}>"
    else
      @remarkably << "/>"
    end
    self
  end
  def text content
    @remarkably << content
    self
  end
  def remarkably
    result = @remarkably
    @remarkably = nil
    result
  end
end
