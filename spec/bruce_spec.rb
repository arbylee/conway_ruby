require_relative '../app/bruce'

describe Bruce do
  let(:bruce) { Bruce.new }
  describe 'build_populated_world' do
    it 'should build a world with the given dimensions' do
      world = bruce.build_populated_world 5, 7
      expect(world.width).to eq(5)
      expect(world.height).to eq(7)
    end
  end

  describe 'evolve' do
    let(:world) { World.new 5, 5 }
    it 'should kill cells with only 1 neighbor' do
      world.set_cell(1, 1, 'foo')
      world.set_cell(1, 2, 'foo')
      bruce.evolve world

      expect(world.get_cell(1,1)).to be(nil)
    end

    it 'should kill cells with no neighbors' do
      world.set_cell(1, 1, 'foo')
      bruce.evolve world
      expect(world.get_cell(1, 1)).to be_nil
    end

    it 'should kill cells with 4 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(0, 2, 'foo')
      world.set_cell(1, 0, 'foo')
      world.set_cell(1, 1, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to be_nil
    end

    it 'should kill cells with 5 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(0, 2, 'foo')
      world.set_cell(1, 0, 'foo')
      world.set_cell(1, 1, 'foo')
      world.set_cell(1, 2, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to be_nil
    end

    it 'should kill cells with 6 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(0, 2, 'foo')
      world.set_cell(1, 0, 'foo')
      world.set_cell(1, 1, 'foo')
      world.set_cell(1, 2, 'foo')
      world.set_cell(2, 0, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to be_nil
    end

    it 'should kill cells with 7 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(0, 2, 'foo')
      world.set_cell(1, 0, 'foo')
      world.set_cell(1, 1, 'foo')
      world.set_cell(1, 2, 'foo')
      world.set_cell(2, 0, 'foo')
      world.set_cell(2, 1, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to be_nil
    end

    it 'should kill cells with 8 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(0, 2, 'foo')
      world.set_cell(1, 0, 'foo')
      world.set_cell(1, 1, 'foo')
      world.set_cell(1, 2, 'foo')
      world.set_cell(2, 0, 'foo')
      world.set_cell(2, 1, 'foo')
      world.set_cell(2, 2, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to be_nil
    end

    it 'should not kill cells with 2 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(1, 1, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to eq('foo')
    end

    it 'should not kill cells with 3 neighbors' do
      world.set_cell(0, 0, 'foo')
      world.set_cell(0, 1, 'foo')
      world.set_cell(0, 2, 'foo')
      world.set_cell(1, 1, 'foo')

      bruce.evolve world
      expect(world.get_cell(1, 1)).to eq('foo')
    end
  end
end
