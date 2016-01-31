require_relative '../app/world'

describe World do
  describe 'initialize' do
    it "creates a cell grid with the given height and width" do
      world = World.new 3, 4
      expect(world.width).to eq(3)
      expect(world.height).to eq(4)
    end

    it "should only allow positive height values" do
      expect { World.new 3, 0 }.to raise_error(InvalidWorldInputError)
      expect { World.new 3, -4 }.to raise_error(InvalidWorldInputError)
    end

    it "should only allow positive width values" do
      expect { World.new 0, 3 }.to raise_error(InvalidWorldInputError)
      expect { World.new(-2, 3) }.to raise_error(InvalidWorldInputError)
    end

    it "should not allow characters for dimension values" do
      expect { World.new "chair", 3 }.to raise_error(InvalidWorldInputError)
      expect { World.new 5, 'x' }.to raise_error(InvalidWorldInputError)
    end
  end

  describe 'set_cell' do
    let(:world) { World.new 5, 5 }
    it 'assigns the contents to the given coordinates' do
      world.set_cell 3, 3, 'foo'
      expect(world.get_cell 3, 3).to eq('foo')
    end

    it 'raises an error if the coordinates dont exist in the world' do
      expect { world.set_cell 3, 7, 'foo' }.to raise_error(OutOfWorldBoundsError)
    end

    it 'raises an error if the coordinates arent integers' do
      expect { world.set_cell 'chair', 7, 'foo' }.to raise_error(OutOfWorldBoundsError)
      expect { world.set_cell '3.3', 7, 'foo' }.to raise_error(OutOfWorldBoundsError)
    end
  end

  describe 'get_cell' do
    let(:world) { World.new 5, 5 }

    it 'raises an error if the coordinates arent integers' do
      expect { world.get_cell 'chair', 7 }.to raise_error(OutOfWorldBoundsError)
      expect { world.get_cell '3.3', 7 }.to raise_error(OutOfWorldBoundsError)
    end
  end
end
