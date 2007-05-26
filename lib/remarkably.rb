module Remarkably
  def method_missing(sym, *args, &block)
    hash = if args.size > 0 && args[-1].class == Hash
             args.pop
           else
             Hash.new
           end
    tag! sym.to_s.downcase, args, hash, &block
  end
  def tag! tag, inline, attributes, &block
    @remarkably = '' if !@remarkably
    tag_attributes =
      attributes.inject([]) do |result,data_pair|
        key,data = data_pair
        result << "#{key.to_s.downcase}=\"#{data.to_s}\""
      end.join(' ')
    @remarkably << "<#{tag}" +
      (tag_attributes.size > 0 ? ' ' + tag_attributes : '')
    if block_given? or inline.size > 0
      @remarkably << ">"
      result = block.call if block_given?
      @remarkably << inline.shift.to_s while inline.size > 0
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
