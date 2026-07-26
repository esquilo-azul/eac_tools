# frozen_string_literal: true

RSpec.describe Avm::EacUbuntuBase0::Runners::Base::Docker do
  it do
    expect { run_command('--registry-name', 'testing', '--image-name') }.not_to raise_error
  end

  def run_command(*argv)
    Avm::EacUbuntuBase0::Runners::Base.run(argv: %w[docker] + argv)
  end
end
