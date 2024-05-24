# frozen_string_literal: true

require 'avm/eac_ruby_base0/source_generators/base'

RSpec.describe Avm::EacRubyBase0::SourceGenerators::Base do
  include_examples 'avm_source_generated', __FILE__, 'EacRubyBase0', {
    'eac-ruby-base0-version' => '0.9.0',
    'eac-ruby-utils-version' => '0.122.0',
    'eac-ruby-gem-support-version' => '0.10.0',
    'gemfile-lock' => true,
    block_on_each_source:
      proc do
        context 'when bundle install is executed' do
          let(:executable_name) { source.path.basename }

          before do
            source.bundle('install').system!
          end

          it do
            expect(source.bundle('exec', executable_name,
                                 '--version').chdir_root.execute!).to eq("0.0.0\n")
          end
        end
      end
  }

  alias_method :fs_comparator_super, :fs_comparator

  def fs_comparator
    fs_comparator_super.truncate_file('Gemfile.lock')
  end
end
