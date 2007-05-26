module Remarkably

  module Base

    class Engine
      def initialize
        clear!
      end

      def method_missing(sym, context, *args, &block)
        @context = context
        hash = args.last.is_a?(Hash) ? args.pop : {}
        method!(sym, args, hash, &block)
      end

      def clear!
        @output = ''
      end

      def method! sym, args, hash, &block
      end

      def to_s
        result = @output
        clear!
        result
      end

    end

  end

  module Common

    def method_missing(sym, *args, &block)
      @remarkable_engine ||= eval("Engines::#{Engines::constants[0]}.new")
      @remarkable_engine.send( sym, self, *args, &block )
    end

    def remarkable_engine engine
      @remarkable_engine = engine
    end

  end

  module Engines
  end

end
