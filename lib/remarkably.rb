module Remarkably

  module Base

    class Engine
      def initialize *args, &block
        clear!
        self.instance_eval( &block ) if block_given?
      end

      def missing_method(sym, context, *args, &block)
        @context = context
        hash = args.last.is_a?(Hash) ? args.pop : {}
        if methods.index( sym.to_s )
          self.send( sym, args, hash, &block )
        else
          method!(sym, args, hash, &block)
        end
      end

      def method_missing(sym, *args, &block)
        missing_method( sym, self, *args, &block )
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
      @remarkably_engine ||= eval("Engines::#{Engines::constants[0]}.new")
      @remarkably_engine.send( :missing_method, sym, self, *args, &block )
    end

    def remarkably_engine= engine
      @remarkably_engine = engine
    end

    def remarkably_engine
      @remarkably_engine
    end

  end

  module Engines
  end

end
