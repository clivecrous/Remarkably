module Remarkably
  def method_missing(sym, *args, &block)
    hash = args.last.is_a?(Hash) ? args.pop : {}
    tag!(sym, args, hash, &block)
  end

  def tag_xml!( tag, inline, attributes, &block )
    tag_attributes =
      attributes.inject([]){|s,(k,v)| s << %{#{k.to_s.downcase}="#{v}"} }

    @remarkably << ["<#{tag}", tag_attributes].flatten.grep(/\S/).join(' ')

    if block_given? or not inline.empty?
      @remarkably << ">"
      @remarkably_method = :css if @remarkably_method == :xml and tag == "style"
      block.call if block_given?
      if @remarkably_method == :css and tag == "style"
        @remarkably_method = :xml
        @remarkably << "\n"
      end
      @remarkably << "#{inline.join}</#{tag}>"
    else
      @remarkably << "/>"
    end
  end

  def tag_css!( tag, inline, attributes, &block )
    @remarkably_method = :css_inner
    if block_given?
      @remarkably << "\n "
      tag_css_inner!( tag, inline, attributes, &block )
      @remarkably << "}"
    end
    @remarkably_method = :css
  end

  def inline_style &block
    current_remarkably = @remarkably
    @remarkably_method = :css_inner
    @remarkably = ''
    block.call if block_given?
    result = @remarkably
    @remarkably_method = :xml
    @remarkably = current_remarkably
    result
  end

  def tag_css_inner!( tag, inline, attributes, &block )
    if block_given?
      @remarkably.chop!
      @remarkably << "#{tag}#{inline.join}"
      @remarkably << ".#{attributes[:class]}" if attributes.has_key?( :class )
      @remarkably << "##{attributes[:id]}" if attributes.has_key?( :id )
      @remarkably << ":#{attributes[:pseudo]}" if attributes.has_key?( :pseudo )
      @remarkably << " {"
      block.call
    else
      tag.gsub!('_','-')
      @remarkably << "#{tag}:#{inline.join(' ')};"
    end
  end

  def tag!(tag, inline=[], attributes={}, &block)
    tag = tag.to_s.downcase
    inline = [inline] if inline.class != Array
    @remarkably ||= ''
    @remarkably_method ||= :xml

    case @remarkably_method
    when :xml       then tag_xml!( tag, inline, attributes, &block )
    when :css       then tag_css!( tag, inline, attributes, &block )
    when :css_inner then tag_css_inner!( tag, inline, attributes, &block )
    else raise "Unknown remarkably method type '#{@remarkably_method}'"
    end

    self
  end

  def text content
    @remarkably << content
    self
  end

  def to_s
    result = @remarkably
    @remarkably = nil
    result
  end
end
