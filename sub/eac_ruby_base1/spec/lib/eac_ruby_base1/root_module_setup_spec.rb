# frozen_string_literal: true

RSpec.describe(EacRubyBase1::RootModuleSetup) do
  {
    'avm-eac_ruby_base1' => [
      'lib/avm/eac_ruby_base1.rb',
      'Avm',
      'avm/eac_ruby_base1'
    ],
    'eac_ruby_utils' => [
      'lib/eac_ruby_utils.rb',
      'Object',
      'eac_ruby_utils'
    ]
  }.each do |gem_name, values|
    context "when gem is \"#{gem_name}\"" do
      let(:root_module_file_subpath) { values[0] }
      let(:namespace_name) { values[1] }
      let(:relative_root_module_file) { values[2] }

      let(:root_module_file) do
        Gem.loaded_specs[gem_name].full_gem_path.to_pathname
          .join(root_module_file_subpath)
      end
      let(:instance) { described_class.new(root_module_file) }

      it do
        expect(instance.namespace).to eq(namespace_name.constantize)
      end

      it do
        expect(instance.relative_root_module_file).to eq(relative_root_module_file)
      end
    end
  end
end
