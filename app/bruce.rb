require_relative './organism'

class Bruce
  def build_populated_world width, height
    world = World.new width, height
    (0...width).each do |x_coord|
      (0...height).each do |y_coord|
        should_populate = [true, false].sample
        if should_populate
          world.set_cell x_coord, y_coord, Organism.new
        end
      end
    end

    world
  end

  def evolve world
    cells_to_destroy = []
    cells_to_spawn = []
    (0...world.width).each do |x|
      (0...world.height).each do |y|
        cell_contents = world.get_cell(x,y)
        neighbors = world.get_neighbors(x, y)
        if cell_contents && (neighbors.size < 2 || neighbors.size > 3)
          cells_to_destroy << [x, y]
        elsif !cell_contents && neighbors.size == 3
          cells_to_spawn << [x, y]
        end
      end
    end

    cells_to_destroy.each do |cell_x, cell_y|
      world.set_cell(cell_x, cell_y, nil)
    end
    cells_to_spawn.each do |spawn_x, spawn_y|
      world.set_cell(spawn_x, spawn_y, Organism.new)
    end
  end
end
