require_relative './organism'

class Bruce
  def build_populated_world width, height
    world = World.new width, height
    (0...width).each do |x_coord|
      (0...height).each do |y_coord|
        alive = [true, false].sample
        world.set_cell x_coord, y_coord, Organism.new(alive)
      end
    end

    world
  end
end
