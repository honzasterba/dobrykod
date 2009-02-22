class Polygon

  CORNERS = ["ur", "ul", "lr", "ll"]
  PARTS = ["x", "y"]

  CORNERS.each do |corner|
    PARTS.each do |part|
      attr_accessor "#{corner}_#{part}".to_sym
    end
  end

  def print_corners
    CORNERS.each do |corner|
      PARTS.each do |part|
        puts send("#{corner}_#{part}".to_sym)
      end
    end
  end

  def fix_zero_to_nil
    all_zero = true
    CORNERS.each do |corner|
      PARTS.each do |part|
        val = send("#{corner}_#{part}".to_sym)
        all_zero &&= val.nil? || val == 0
      end
    end
    return unless all_zero
    CORNERS.each do |corner|
      PARTS.each do |part|
        send("#{corner}_#{part}=".to_sym, nil)
      end
    end
  end

end

p = Polygon.new
Polygon::CORNERS.each do |corner|
  Polygon::PARTS.each do |part|
    p.send("#{corner}_#{part}=", rand)
  end   
end
p.print_corners

zero = Polygon.new
zero.fix_zero_to_nil
