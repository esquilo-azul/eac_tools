# frozen_string_literal: true

require 'avm/instances/data/unit'

module Avm
  module Instances
    module Data
      class FilesUnit < ::Avm::Instances::Data::Unit
        EXTENSION = '.tar.gz'

        common_constructor :instance, :fs_path_subpath, super_args: -> { [instance] }

        before_load :clear_files

        def files_path
          ::File.join(instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH),
                      fs_path_subpath)
        end

        def dump_command
          instance.host_env.command('tar', '-czf', '-', '-C', files_path, '.')
        end

        def load_command
          instance.host_env.command('tar', '-xzf', '-', '-C', files_path)
        end

        def clear_files
          infom "Removing all files under #{files_path}..."
          instance.host_env.command('mkdir', '-p', files_path).execute!
          instance.host_env.command('find', files_path, '-mindepth', 1, '-delete').execute!
        end
      end
    end
  end
end
