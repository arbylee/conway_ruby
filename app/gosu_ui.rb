require 'gosu'

class GosuUi < Gosu::Window
  WHITE = Gosu::Color::WHITE
  BLACK = Gosu::Color::BLACK
  SCALE = 10

  def initialize x, y
    super(x * SCALE, y * SCALE, false)
    @world = nil
    self.show
  end

  def draw_cell x, y, color
    self.draw_quad(
      x * SCALE,         y * SCALE,         color,
      x * SCALE + SCALE, y * SCALE,         color,
      x * SCALE,         y * SCALE + SCALE, color,
      x * SCALE + SCALE, y * SCALE + SCALE, color
    )
  end

  def draw
    if !@world
      return
    end

    (0...@world.height).each do |y|
      (0...@world.width).each do |x|
        if @world.get_cell(x, y)
          draw_cell(x, y, WHITE)
        else
          draw_cell(x, y, BLACK)
        end
      end
    end
  end

  def display world
    @world = world
    self.show
  end

  def update
    self.close
  end
end
