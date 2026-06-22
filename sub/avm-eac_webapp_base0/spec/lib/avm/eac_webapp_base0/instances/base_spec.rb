# frozen_string_literal: true

require 'avm/eac_webapp_base0/instances/base'

RSpec.describe Avm::EacWebappBase0::Instances::Base do
  let(:instance) { described_class.by_id('the-app_0') }

  describe '#install_apache_resource_name' do
    it { expect(instance.install_apache_resource_name).to eq(instance.id) }
  end
end
