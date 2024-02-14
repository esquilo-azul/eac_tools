# frozen_string_literal: true

require 'avm/git/launcher_stereotypes/git_subrepo/publish'
require 'avm/launcher/publish/check_result'

RSpec.describe Avm::Git::LauncherStereotypes::GitSubrepo::Publish do
  describe '#check' do
    context 'with clean context' do
      let(:settings_path) { ::File.join(__dir__, 'publish_spec_settings.yml') }

      before do
        temp_context(settings_path)
      end

      context 'with app with subrepo' do # rubocop:disable RSpec/NestedGroups
        let(:remote_repos) { init_remote('mylib') }

        before do
          wc = init_git('mylib')
          touch_commit(wc, 'file1')
          wc.execute!('remote', 'add', 'publish', remote_repos)
          wc.execute!('push', 'publish', 'master')
        end

        let!(:app) do
          r = init_git('app')
          touch_commit(r, 'file2')
          r.execute!('subrepo', 'clone', remote_repos, 'mylib')
          r
        end

        it { check_publish_status(:updated) }

        context 'after subrepo updated and before publishing' do # rubocop:disable RSpec/ContextWording, RSpec/NestedGroups
          before do
            ::Avm::Launcher::Context.current.publish_options[:confirm] = true
            touch_commit(app, 'mylib/file3')
          end

          it { expect(::Avm::Launcher::Context.current.publish_options[:confirm]).to be(true) }
          it { check_publish_status(:pending) }

          context 'after publishing' do # rubocop:disable RSpec/ContextWording, RSpec/NestedGroups
            before { described_class.new(app_mylib_instance).run }

            it { check_publish_status(:updated) }

            context 'after reset context' do # rubocop:disable RSpec/ContextWording, RSpec/NestedGroups
              before do
                sleep 2
                ::Avm::Launcher::Context.current = ::Avm::Launcher::Context.new(
                  projects_root: ::Avm::Launcher::Context.current.root.real,
                  settings_file: settings_path,
                  cache_root: ::Dir.mktmpdir
                )
              end

              it { check_publish_status(:updated) }
            end
          end
        end

        def check_publish_status(status_key) # rubocop:disable Metrics/AbcSize
          instance = app_mylib_instance
          expect(instance).to be_a(::Avm::Launcher::Instances::Base)
          expect(instance.stereotypes).to include(::Avm::Git::LauncherStereotypes::GitSubrepo)

          status = ::Avm::Launcher::Publish::CheckResult.const_get("STATUS_#{status_key}".upcase)
          publish = described_class.new(instance)
          expect(publish.check.status).to(
            eq(status),
            "Expected: #{status}, Actual: " \
            "#{publish.check.status}, Message: #{publish.check.message}"
          )
        end

        def app_mylib_instance
          ::Avm::Launcher::Context.current.instance('/app/mylib')
        end
      end
    end
  end
end
