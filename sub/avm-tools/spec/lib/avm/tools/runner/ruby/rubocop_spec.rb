# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'avm/tools/runner'

::RSpec.describe ::Avm::Tools::Runner::Ruby::Rubocop do
  let(:fixtures_root) { ::Pathname.new(__dir__).expand_path.join('rubocop_spec_files') }
  let(:dir1) { fixtures_root.join('dir1') }
  let(:dir2) { fixtures_root.join('dir2') }
  let(:dir3) { dir1.join('dir3') }
  let(:dir4) { fixtures_root.join('dir4') }

  {
    dir1: '0.48.1',
    dir2: ::Avm::EacRubyBase1::Sources::Base.new(APP_ROOT).gemfile_lock_gem_version('rubocop').to_s,
    dir3: '0.48.1',
    dir4: '33.33.33'
  }.each do |dir_name, rubocop_version|
    context "when dir is #{dir_name}" do
      let(:dir) { send(dir_name) }
      let(:thegem) { ::Avm::EacRubyBase1::Sources::Base.new(dir) }

      before do
        thegem.bundle.system! if thegem.gemfile_path.exist?
      end

      it "return #{rubocop_version} as Rubocop version" do
        argv = ['--quiet', 'ruby', 'rubocop', '-C', dir.to_s, '--', '--version']
        expect { ::Avm::Tools::Runner.run(argv: argv) }.to(
          output("#{rubocop_version}\n").to_stdout_from_any_process
        )
      end
    end
  end
end
