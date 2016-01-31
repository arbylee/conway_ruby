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

  def convert_inputs x, y
    if !x.is_a?(Integer) || !y.is_a?(Integer)
      raise OutOfWorldBoundsError.new
    end

    return [x % width, y % height]
  end

  def height
    @grid.size
  end

  def width
    @grid[0].size
  end

  def set_cell x_input, y_input, contents
    x, y = convert_inputs x_input, y_input
    @grid[y][x] = contents
  end

  def get_cell x_input, y_input
    x, y = convert_inputs x_input, y_input
    @grid[y][x]
  end

  def get_neighbors x, y
    top_left      = get_cell x-1, y-1
    top_middle    = get_cell x,   y-1
    top_right     = get_cell x+1, y-1
    middle_left   = get_cell x-1, y
    middle_right  = get_cell x+1, y
    bottom_left   = get_cell x-1, y+1
    bottom_middle = get_cell x,   y+1
    bottom_right  = get_cell x+1, y+1

    return [
      top_left,    top_middle,    top_right,
      middle_left,                middle_right,
      bottom_left, bottom_middle, bottom_right
    ].compact
  end
end
