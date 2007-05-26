require "#{File::dirname(__FILE__)}/../../remarkably"
require "#{File::dirname(__FILE__)}/xml"
require "#{File::dirname(__FILE__)}/css"

module Remarkably
  module Engines
    class HTML < XML
      def initialize
        super
        @css_engine = Engines::CSS.new
      end
      def style args, hash, &block
        if block_given?
          @css_engine.clear!
          @context.remarkably_engine = @css_engine
          block.call
          @context.remarkably_engine = self
          args = ["\n#{@css_engine}"]+args
        end
        method!( :style, args, hash )
      end
    end
    Config.default_engine = HTML
  end
end
