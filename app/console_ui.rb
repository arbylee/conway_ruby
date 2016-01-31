class ConsoleUi
  def display world
    (0...world.height).each do |y|
      row = ""
      (0...world.width).each do |x|
        if world.get_cell(x, y)
          row << "[X]"
        else
          row << "[ ]"
        end
      end
      puts row
    end
    puts
  end
end
