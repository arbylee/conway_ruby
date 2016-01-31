require 'set'

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

    it 'raises an error if the coordinates arent integers' do
      expect { world.set_cell 'chair', 7, 'foo' }.to raise_error(OutOfWorldBoundsError)
      expect { world.set_cell '3.3', 7, 'foo' }.to raise_error(OutOfWorldBoundsError)
    end

    it 'accepts negative values to set cells' do
      world.set_cell 0, -1, 'chair'
      expect(world.get_cell 0, 4).to eq('chair')
    end
  end

  describe 'get_cell' do
    let(:world) { World.new 5, 5 }

    it 'raises an error if the coordinates arent integers' do
      expect { world.get_cell 'chair', 7 }.to raise_error(OutOfWorldBoundsError)
      expect { world.get_cell '3.3', 7 }.to raise_error(OutOfWorldBoundsError)
    end

    it 'can use negative values to fetch cells' do
      world.set_cell 0, 4, 'chair'
      expect(world.get_cell 0, -1).to eq('chair')
    end
  end

  describe 'get_neighbors' do
    let(:world) { World.new 5, 5 }
    before(:each) do
      (0...5).each do |x|
        (0...5).each do |y|
          world.set_cell(x, y, "#{x},#{y}")
        end
      end
    end

    it 'should find neighboring cell contents' do
      neighbors = world.get_neighbors(1, 1)
      expected_neighbors = Set.new [
        '0,0', '1,0', '2,0',
        '0,1',        '2,1',
        '0,2', '1,2', '2,2'
      ]
      expect(Set.new(neighbors)).to eq(expected_neighbors)
    end

    it 'should not return empty cells' do
      world.set_cell(0,0,nil)
      world.set_cell(2,2,nil)
      neighbors = world.get_neighbors(1, 1)
      expected_neighbors = Set.new [
               '1,0', '2,0',
        '0,1',        '2,1',
        '0,2', '1,2'
      ]
      expect(Set.new(neighbors)).to eq(expected_neighbors)
    end

    it 'should find neighboring cell contents across min world bounds' do
      neighbors = world.get_neighbors(0,0)
      expected_neighbors = Set.new [
        '4,4', '0,4', '1,4',
        '4,0',        '1,0',
        '4,1', '0,1', '1,1'
      ]
      expect(Set.new(neighbors)).to eq(expected_neighbors)
    end

    it 'should find neighboring cell contents across max world bounds' do
      neighbors = world.get_neighbors(4,4)
      expected_neighbors = Set.new [
        '3,3', '4,3', '0,3',
        '3,4',        '0,4',
        '3,0', '4,0', '0,0'
      ]
      expect(Set.new(neighbors)).to eq(expected_neighbors)
    end
  end
end
