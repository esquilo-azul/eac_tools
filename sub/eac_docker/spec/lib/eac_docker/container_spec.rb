# frozen_string_literal: true

RSpec.describe(EacDocker::Container, :docker) do
  let(:image) { EacDocker::Images::Named.new('alpine') }
  let(:instance) { described_class.new(image) }

  it do
    expect(instance.id).to be_blank
  end

  describe '#run_command' do
    it do
      expect(instance.command_arg('whoami').run_command.execute!.strip).to eq('root')
    end
  end

  describe '#on_detached' do
    it do
      instance.on_detached do
        expect(instance.id).to be_present
      end
    end
  end
end
