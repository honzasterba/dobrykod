class Polygon

  CORNERS = ["ur", "ul", "lr", "ll"]
  PARTS = ["x", "y"]

  def Polygon.each_corner_and_part
    CORNERS.each do |corner|
      PARTS.each do |part|
        yield(corner, part)
      end
    end
  end

  def Polygon.each_coordinate
    each_corner_and_part do |corner, part|
      yield("#{corner}_#{part}")
    end
  end

  each_coordinate do |coord|
    attr_accessor coord.to_sym
  end

  def print_corners
    Polygon.each_coordinate do |coord|
      puts send(coord.to_sym)
    end
  end

  def fix_zero_to_nil
    all_zero = true
    Polygon.each_coordinate do |coord|
      val = send(coord.to_sym)
      all_zero &&= val.nil? || val == 0
    end
    return unless all_zero
    Polygon.each_coordinate do |coord|
      send("#{coord}=".to_sym, nil)
    end
  end

end

p = Polygon.new
Polygon.each_coordinate do |coord|
  p.send("#{coord}=".to_sym, rand)
end
p.print_corners

zero = Polygon.new
zero.fix_zero_to_nil
