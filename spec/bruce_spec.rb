require_relative '../app/bruce'

describe Bruce do
  describe 'build_populated_world' do
    let(:bruce) { Bruce.new }
    it 'should build a world with the given dimensions' do
      world = bruce.build_populated_world 5, 7
      expect(world.width).to eq(5)
      expect(world.height).to eq(7)
    end
  end
end
