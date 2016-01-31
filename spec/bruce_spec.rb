require_relative '../app/bruce'

describe Bruce do
  describe 'build_populated_world' do
    let(:bruce) { Bruce.new }
    it 'should build a world with the given dimensions' do
      world = bruce.build_populated_world 5, 7
      expect(world.width).to eq(5)
      expect(world.height).to eq(7)
    end

    it 'should create organisms in each cell' do
      world = bruce.build_populated_world 2, 3
      expect(world.get_cell 0, 0).to be_a_kind_of(Organism)
    end
  end
end
