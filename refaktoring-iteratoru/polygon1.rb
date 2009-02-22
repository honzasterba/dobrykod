class Polygon

  CORNERS = [:ur_x, :ur_y, :ul_x, :ul_y, :lr_x, :lr_y, :ll_x, :ll_y]

  CORNERS.each do |corner|
    attr_accessor corner
  end

  def print_corners
    CORNERS.each do |corner|
      puts send(corner)
    end
  end

end

p = Polygon.new
Polygon::CORNERS.each do |corner|
   p.send("#{corner.to_s}=", rand)
end
p.print_corners
