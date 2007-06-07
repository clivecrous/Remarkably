module Remarkably
  module Engines
    class HTML < XML
      def bookmarklet args, hash, &block
        inline_javascript = args.shift.split("\n").map{|l|l.strip}.join('')
        inline_javascript.gsub!( '%', '%25' )
        { "'" => "%27",
          '"' => "%22",
          '&' => "%26",
          '/' => "%2F",
        }.each_pair do |key,value|
          inline_javascript.gsub!( key, value )
        end
        hash[:href]=%|javascript:(function(){#{inline_javascript}})();|
        method!( :a, args, hash, &block )
      end
    end
  end
end
