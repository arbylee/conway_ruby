require_relative './errors/invalid_world_dimension_error'

class World
  def initialize width, height
    validate_dimensions width, height
    @cell_grid = []
    height.times do
      row = []
      width.times do
        row << nil
      end
      @cell_grid << row
    end
  end

  def validate_dimensions width, height
    if !width.is_a?(Integer) || !height.is_a?(Integer) ||
        height <= 0 || width <= 0
      raise InvalidWorldDimensionError.new
    end
  end

  def height
    @cell_grid.size
  end

  def width
    @cell_grid[0].size
  end
end
