# frozen_string_literal: true

RSpec.describe Avm::EacRubyBase0::Sources::Base do
  let(:instance) { avm_eac_ruby_base0_source }

  include_examples 'in_avm_registry', 'sources'

  it { expect(instance).to be_a(described_class) }

  it do
    expect(instance.version).to eq(Avm::VersionNumber.new('0.0.0'))
  end
end
