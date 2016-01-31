require_relative './errors/invalid_world_input_error'
require_relative './errors/out_of_world_bounds_error'

class World
  def initialize width, height
    validate_dimensions width, height
    @grid = []
    height.times do
      row = []
      width.times do
        row << nil
      end
      @grid << row
    end
  end

  def validate_dimensions width, height
    if !width.is_a?(Integer) || !height.is_a?(Integer) ||
        height <= 0 || width <= 0
      raise InvalidWorldInputError.new
    end
  end

  def coordinates_in_world? x, y
    if !x.is_a?(Integer) || !y.is_a?(Integer) || x < 0 || x >= width || y < 0 || y >= height
      raise OutOfWorldBoundsError.new
    end
  end

  def height
    @grid.size
  end

  def width
    @grid[0].size
  end

  def set_cell x, y, contents
    coordinates_in_world?(x, y)
    @grid[y][x] = contents
  end

  def get_cell x, y
    coordinates_in_world?(x, y)
    @grid[y][x]
  end
end
