# frozen_string_literal: true

RSpec.describe Object, '#eac_template' do
  let(:instance_class) do
    Class.new do
      def self.name
        'MyStubWithTemplate'
      end
    end
  end
  let(:instance) { instance_class.new }
  let(:templates_path) { fixtures_directory.join('path') }

  before do
    EacTemplates::Sources::Set.default.included_paths.add(templates_path)
  end

  after do
    EacTemplates::Sources::Set.default.included_paths.delete(templates_path)
  end

  include_examples 'spec_paths', __FILE__

  EacTemplates::InterfaceMethods::FILE.each do |method_name|
    it { expect(instance.eac_template).to respond_to(method_name) }
  end

  it do
    expect(instance.eac_template.apply(the_var: 'friend')).to eq("Hello, friend!\n")
  end
end
