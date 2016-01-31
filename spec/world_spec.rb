require_relative '../app/world'

describe World do
  it "creates a cell grid with the given height and width" do
    world = World.new 3, 4
    expect(world.width).to eq(3)
    expect(world.height).to eq(4)
  end

  it "should only allow positive height values" do
    expect { World.new 3, 0 }.to raise_error(InvalidWorldDimensionError)
    expect { World.new 3, -4 }.to raise_error(InvalidWorldDimensionError)
  end

  it "should only allow positive width values" do
    expect { World.new 0, 3 }.to raise_error(InvalidWorldDimensionError)
    expect { World.new(-2, 3) }.to raise_error(InvalidWorldDimensionError)
  end

  it "should not allow characters for dimension values" do
    expect { World.new "chair", 3 }.to raise_error(InvalidWorldDimensionError)
    expect { World.new 5, 'x' }.to raise_error(InvalidWorldDimensionError)
  end
end
