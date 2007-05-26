require "#{File::dirname(__FILE__)}/../../remarkably"

module Remarkably
  module Engines
    class CSS < Base::Engine
      def method! sym, args, hash, &block
        sym = sym.to_s.downcase

        if block_given?
          current_prefix = @css_prefix
          @css_prefix = (@css_prefix+" #{sym}#{args.map{|a|a.to_s}.join}").strip
          @css_depth+=1
          @css_prefix_rendered=false
          block.call
          @css_depth-=1
          @css_prefix = current_prefix
        else
          unless @css_prefix_rendered
            unless @css_first_use
              @output.chop!
              @output << "}"
            end
            @output << "\n#{@css_prefix} {"
            @css_prefix_rendered = true
            @css_first_use = false
          end
          @output << "#{sym.gsub('_','-')}:#{args.map{|a|a.to_s}.join};"
        end
      end

      def to_s
        "#{super.chop}}\n"
      end

      def clear!
        super
        @css_prefix=''
        @css_depth=0
        @css_prefix_rendered=false
        @css_first_use=true
      end

    end
  end
end

