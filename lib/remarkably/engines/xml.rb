require "#{File::dirname(__FILE__)}/../../remarkably"

module Remarkably
  module Engines
    class XML < Base::Engine

      def method! sym, args, hash, &block
        sym = sym.to_s.downcase

        tag_attributes =
          hash.inject([]){|s,(k,v)| s << %{#{k.to_s.downcase}="#{v}"} }

        @output << ["<#{sym}", tag_attributes].flatten.grep(/\S/).join(' ')

        if block_given? or not args.empty?
          @output << ">"
          block.call if block_given?
          @output << "#{args.join}</#{sym}>"
        else
          @output << "/>"
        end

        self
      end

      def text context, *args
        @output << args.join
        self
      end

    end
  end
end
