require 'gosu'

class WhackAEhsan < Gosu::Window

  def initialize
  	super(800, 600)
    self.caption = 'FINISH HIM!'
    @image = Gosu::Image.new('ehsanhoofd.png')
    @hammer = Gosu::Image.new('hammer.png')
    @x = 200
    @y = 200
    @width = 156
    @height = 222
    @velocity_x = 5
    @velocity_y = 3 
    @visible = 0
    @hit = 0
    @font = Gosu::Font.new(30)
    @score = 0
    @playing = true
    @start_time = 0
  end

  def update
    if @playing
	  @x += @velocity_x
	  @y += @velocity_y
      @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
	  @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
	  @visible -= 1
	  @visible = 30 if @visible < 10 && rand < 0.01
	  @time_left = (60 - ((Gosu.milliseconds - @start_time) / 1000))
	  @playing = false if @time_left <= 0
    end	
  end	

  def button_down(id)
  	if @playing 
      if id == Gosu::MsLeft
  	    if Gosu.distance(mouse_x, mouse_y, @x, @y) < 150 && @visible >= 0
  	      @hit = 1
  	      @score += 5
  	    else 
  	      @hit = -1
  	      @score -= 1 if @score > 0
  	    end
  	  end
  	else
  	  if id == Gosu::KbSpace
  	    @playing = true
  	    @visible = 0
  	    @start_time = Gosu.milliseconds
  	    @score = 0
  	  end  
  	end            	
  end

  def draw
    @image.draw(@x - @width / 2, @y - @height / 2, 1) if @visible > 0
    @hammer.draw(mouse_x - 220, mouse_y - 75, 1)
    if @hit == 0 
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end   
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c) 
    @hit = 0
    @font.draw(@score.to_s, 700, 20, 2)
    @font.draw(@time_left.to_s, 20, 20, 2)

    unless @playing 
      if @score < 10
        @font.draw('Serieus, niet eens 10 punten?', 210, 100, 3)
        @font.draw('Druk op de spatieknop om je eer te herstellen', 110, 200, 3)
        @visible = 0
      elsif @score == (20...50)
        @font.draw('Mwah, kan beter...', 210, 100, 3)
        @font.draw('Druk op de spatieknop om opnieuw te spelen', 110, 200, 3)
        @visible = 0
      elsif @score == (50...100)
        @font.draw('Pit Pit Pit!!', 210, 100, 3) 
        @font.draw('Druk op de spatieknop om nog een keer te spelen', 110, 200, 3) 
        @visible = 0
      end  
    end  
  end	

end

window = WhackAEhsan.new
window.show


