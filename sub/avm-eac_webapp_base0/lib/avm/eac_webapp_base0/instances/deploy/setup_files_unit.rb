# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        class SetupFilesUnit < ::SimpleDelegator
          enable_method_class
          attr_reader :data_key, :fs_path_subpath

          def initialize(deploy, data_key, fs_path_subpath)
            super(deploy)
            @data_key = data_key
            @fs_path_subpath = fs_path_subpath
          end

          def result
            assert_source_directory
            link_source_target
          end

          def assert_source_directory
            infom "Asserting \"#{data_key}\" source directory..."
            instance.host_env.command('mkdir', '-p', source_path).execute!
          end

          def source_path
            ::File.join(instance.install_data_path, data_key.to_s)
          end

          def target_path
            ::File.join(instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH),
                        fs_path_subpath.to_s)
          end

          def link_source_target
            infom "Linking \"#{data_key}\" directory..."
            instance.host_env.command('rm', '-rf', target_path).execute!
            instance.host_env.command('ln', '-s', source_path, target_path).execute!
          end
        end
      end
    end
  end
end
