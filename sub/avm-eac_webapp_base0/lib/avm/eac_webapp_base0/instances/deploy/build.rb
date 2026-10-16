# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        module Build
          private

          attr_accessor :build_dir, :source_dir

          def append_instance_content
            ::Avm::Files::Appender
              .new
              .variables_source_set(variables_source)
              .append_templatized_directory(eac_template)
              .append_templatized_directories(appended_directories)
              .append_file_content(version_target_path, version)
              .write_appended_on(build_dir)
          end

          def build_dir_env
            ::EacRubyUtils::Envs.local
          end

          def create_build_dir
            self.build_dir = ::EacRubyUtils::Fs::Temp.directory
          end

          def create_source_dir
            self.source_dir = ::EacRubyUtils::Fs::Temp.directory
            infom 'Writing Git source code...'
            scm.commit(commit_reference).deploy_to_env_path(
              build_dir_env,
              source_dir
            ).variables_source_set(variables_source).run
          end

          def remove_build_dir
            build_dir&.remove
          end

          def remove_source_dir
            source_dir&.remove
          end

          def build_content
            ::FileUtils.copy_entry(source_dir.to_path, build_dir.to_path)
          end
        end
      end
    end
  end
end
