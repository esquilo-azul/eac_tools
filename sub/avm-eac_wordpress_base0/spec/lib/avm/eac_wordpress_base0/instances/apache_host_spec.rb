# frozen_string_literal: true

require 'avm/instances/entry_keys'
require 'avm/eac_wordpress_base0/instances/apache_host'
require 'avm/eac_wordpress_base0/instances/base'

RSpec.describe ::Avm::EacWordpressBase0::Instances::ApacheHost do
  describe '#no_ssl_site_content' do
    let(:instance) { ::Avm::EacWordpressBase0::Instances::Base.by_id('stub-app_0') }
    let(:apache_host) { described_class.new(instance) }
    let(:expected_content) do
      ::File.read(::File.join(__dir__, 'apache_host_spec_no_ssl_content.conf'))
    end

    before do
      instance.entry(::Avm::Instances::EntryKeys::INSTALL_PATH).write('/path/to/stub-app_0')
      instance.entry(::Avm::Instances::EntryKeys::WEB_URL).write('http://stubapp.net')
      instance.entry(::Avm::Instances::EntryKeys::INSTALL_USERNAME).write('myuser')
    end

    it do
      expect(apache_host.no_ssl_site_content).to eq(expected_content)
    end
  end
end
