[ Fixnum, Float ].each do |extend_class|
  extend_class.class_eval do
    %w{em ex cm in mm pt pc px}.each do |unit|
      define_method( unit ) {"#{self}#{unit}"}
    end
  end
end

class Array
  def css *args, &block
    self.each do |item|
      eval( 'self', block ).send( item.to_sym , *args, &(lambda { yield }) )
    end
  end
end
