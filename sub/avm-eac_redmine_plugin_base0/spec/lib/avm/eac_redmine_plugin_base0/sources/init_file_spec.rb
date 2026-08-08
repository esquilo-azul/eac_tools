# frozen_string_literal: true

require 'avm/eac_redmine_plugin_base0/sources/init_file'

RSpec.describe Avm::EacRedminePluginBase0::Sources::InitFile do
  let(:stubs_dir) { Pathname.new(__dir__).join('init_file_spec_files') }
  let(:stub_file) { stubs_dir.join('a_init_file.rb') }
  let(:instance) { described_class.new(stub_file) }
  let(:target_version) { Gem::Version.new('0.16.0') }

  describe '#version' do
    it { expect(instance.version).to eq(target_version) }
  end
end
