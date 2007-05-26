module Remarkably
  def method_missing(sym, *args, &block)
    hash = args.last.is_a?(Hash) ? args.pop : {}
    tag!(sym.to_s.downcase, args, hash, &block)
  end

  def tag!(tag, inline, attributes, &block)
    @remarkably ||= ''

    tag_attributes =
      attributes.inject([]){|s,(k,v)| s << %{#{k.to_s.downcase}="#{v}"} }

    @remarkably << ["<#{tag}", tag_attributes].flatten.grep(/\S/).join(' ')

    if block_given? or not inline.empty?
      @remarkably << ">"
      block.call if block_given?
      @remarkably << "#{inline.join}</#{tag}>"
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