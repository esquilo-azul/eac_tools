# frozen_string_literal: true

RSpec.describe(EacDocker::Executables, :docker) do
  it 'output version' do
    expect(described_class.docker.command('--version').execute!).to be_present
  end
end
