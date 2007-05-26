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
      def style context, *args, &block
        if block_given?
          @context.remarkable_engine( @css_engine )
          block.call
          @context.remarkable_engine( self )
          css_result = @css_engine.to_s
        end
        args = [css_result]+args if css_result
        method_missing( :style, @context, *args )
      end
    end
  end
end
