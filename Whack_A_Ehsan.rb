require 'gosu'

class WhackAEhsan < Gosu::Window
  def initialize
  	super(800, 600)
    self.caption = 'Finish him!'
    @image = Gosu::Image.new('ehsanhoofd.png')
    @hammer = Gosu::Image.new('hammer.png')
    @x = 200
    @y = 200
    @width = 156
    @height = 222
    @velocity_x = 5
    @velocity_y = 3 
    @visible = 0
  end
  def update
  	@x += @velocity_x
  	@y += @velocity_y
  	@velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
  	@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
  	@visible -= 1
  	@visible = 30 if @visible < 10 && rand < 0.01
  end	
  def draw
    @image.draw(@x - @width / 2, @y - @height / 2, 1) if @visible > 0
    @hammer.draw(mouse_x - 130, mouse_y - 160, 1)
  end	
end

window = WhackAEhsan.new
window.show