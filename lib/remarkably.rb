require 'remarkably/version'

module Remarkably

  module Config
    class << self
      attr_accessor :default_engine
    end
  end

  module Base

    class Engine

      attr_reader :remarkably_engine

      def initialize *args, &block
        clear!
        @remarkably_engine = self
        self.instance_eval( &block ) if block_given?
      end

      def missing_method(sym, context, *args, &block)
        @context = context
        hash = args.last.is_a?(Hash) ? args.pop : {}
        responder ||= context.remarkably_engine if context.remarkably_engine.respond_to?( sym )
        responder ||= self if self.respond_to?( sym )
        if responder
          responder.send( sym, args, hash, &block )
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
      @remarkably_engine ||= Config.default_engine.new
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
