require_relative './bruce'

class GameOfLife
  def run world_x, world_y, ui
    bruce = Bruce.new
    world = bruce.build_populated_world world_x, world_y
    while true
      ui.display world
      bruce.evolve world
      sleep 0.2
    end
  end
end
