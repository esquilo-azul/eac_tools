# frozen_string_literal: true

RSpec.describe EacConfig::EntryPath do
  describe '#assert' do
    {
      ['a.b.c'] => %w[a b c],
      [['a', 1], 'b', []] => %w[a 1 b],
      ['a', 'b', ['c', 1.2], 'd', 'e.f'] => %w[a b c 1 2 d e f]
    }.each do |data|
      source = data[0] # rubocop:disable RSpec/LeakyLocalVariable

      context "when source is #{source}" do
        let(:instance) { described_class.assert(source) }
        let(:expected_parts) { data[1] }

        it { expect(instance.parts).to eq(expected_parts) }
      end
    end

    [['a..c'], ['a', ' ']].each do |source|
      context "when invalid source is #{source}" do
        it do
          expect { described_class.assert(source) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
