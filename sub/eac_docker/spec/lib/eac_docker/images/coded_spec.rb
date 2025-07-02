# frozen_string_literal: true

RSpec.describe(EacDocker::Images::Coded, :docker) do
  let(:fixtures_dir) { Pathname.new('coded_spec_files').expand_path(__dir__) }
  let(:instance) { described_class.new(fixtures_dir / 'image1') }

  describe '#provide' do
    it { expect { instance.provide }.not_to raise_error }
  end
end
