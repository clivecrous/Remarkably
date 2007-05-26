class Fixnum
  %w{em ex cm in mm pt pc px}.each do |unit|
    define_method( unit ) {"#{self}#{unit}"}
  end
end
