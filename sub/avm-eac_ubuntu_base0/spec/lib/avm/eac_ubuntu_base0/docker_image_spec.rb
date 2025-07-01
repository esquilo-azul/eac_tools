# frozen_string_literal: true

RSpec.describe Avm::EacUbuntuBase0::DockerImage do
  let(:registry) { EacDocker::Registry.new('stub') }
  let(:instance) { described_class.new(registry) }

  describe '#provide' do
    it do
      expect(instance.provide).to be_a(EacDocker::Images::Base)
    end
  end
end
