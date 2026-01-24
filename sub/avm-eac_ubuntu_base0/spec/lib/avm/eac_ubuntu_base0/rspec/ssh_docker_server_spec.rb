# frozen_string_literal: true

RSpec.describe Avm::EacUbuntuBase0::Rspec::SshDockerServer do
  let(:instance) { described_class.new }

  describe '#provide' do
    it do
      expect(instance.provide).to be_a(EacDocker::Images::Base)
    end
  end
end
