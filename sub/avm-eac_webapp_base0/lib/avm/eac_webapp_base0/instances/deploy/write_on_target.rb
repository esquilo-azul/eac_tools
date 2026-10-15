# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        module WriteOnTarget
          def write_on_target
            ::Avm::Files::Deploy.new(
              instance.host_env,
              instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)
            ).append_plain_directory(build_dir).run
          end
        end
      end
    end
  end
end
