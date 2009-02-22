class Polygon

  attr_accessor :ur_x, :ur_y, :ul_x, :ul_y, :lr_x, :lr_y, :ll_x, :ll_y

  def print_corners
    puts ur_x, ur_y, ul_x, ul_y, lr_x, lr_y, ll_x, ll_y  
  end 

end

p = Polygon.new
[:ur_x, :ur_y, :ul_x, :ul_y, :lr_x, :lr_y, :ll_x, :ll_y].each do |corner|
   p.send("#{corner.to_s}=", rand)
end
p.print_corners
