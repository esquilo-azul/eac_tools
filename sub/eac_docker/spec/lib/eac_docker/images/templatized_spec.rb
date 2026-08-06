# frozen_string_literal: true

RSpec.describe(EacDocker::Images::Templatized, :docker) do
  let(:fixtures_dir) { Pathname.new('templatized_spec_files').expand_path(__dir__) }
  let(:instance) { StubDockerImage.new }

  before do
    EacTemplates::Sources::Set.default.included_paths << fixtures_dir
    stub_const('StubDockerImage', Class.new(described_class))
  end

  describe '#provide' do
    it { expect { instance.provide }.not_to raise_error }
  end
end
