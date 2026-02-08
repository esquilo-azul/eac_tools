# frozen_string_literal: true

RSpec.describe Avm::EacRedmineBase0::Instances::ApacheHost do
  describe '#no_ssl_site_content' do
    let(:instance) { Avm::EacRedmineBase0::Instances::Base.by_id('stub-app_0') }
    let(:apache_host) { described_class.new(instance) }
    let(:fixtures_dir) { Pathname.new('apache_host_spec_files').expand_path(__dir__) }
    let(:expected_content) { fixtures_dir.join('apache_host_spec_no_ssl_content.conf').read }

    before do
      instance.entry('install.path').write('/path/to/stub-app_0')
      instance.entry('web.url').write('http://stubapp.net')
    end

    it do
      expect(apache_host.no_ssl_site_content).to eq(expected_content)
    end
  end
end
