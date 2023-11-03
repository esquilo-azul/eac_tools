# frozen_string_literal: true

require 'avm/eac_github_base0/application_scms/base'

RSpec.describe Avm::EacGithubBase0::ApplicationScms::Base do
  let(:stub_application) do
    {
      scm_url: 'https://github.com'.to_uri,
      scm_repos_path: 'esquilo-azul/eac_tools'.to_pathname
    }.to_struct
  end
  let(:instance) { described_class.new(stub_application) }

  include_examples 'in_avm_registry', 'application_scms'

  describe '#git_https_url' do
    it do
      expect(instance.git_https_url).to(
        eq(Addressable::URI.parse('https://github.com/esquilo-azul/eac_tools.git'))
      )
    end
  end

  describe '#web_url' do
    it do
      expect(instance.web_url).to(
        eq(Addressable::URI.parse('https://github.com/esquilo-azul/eac_tools'))
      )
    end
  end
end
