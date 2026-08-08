# frozen_string_literal: true

module Avm
  module EacRubyBase1
    module Sources
      class Base < ::Avm::EacGenericBase0::Sources::Base
        module Rubocop
          RUBOCOP_CONFIG_SUBPATH = '.rubocop.yml'

          # @return [Avm::EacRubyBase1::Sources::Base::RubocopCommand]
          def rubocop_command
            ::Avm::EacRubyBase1::Sources::Base::RubocopCommand.new(self)
          end

          # @return [Pathname]
          def rubocop_config_path
            path.join(RUBOCOP_CONFIG_SUBPATH)
          end

          # @return [Avm::EacRubyBase1::Sources::Base::RubocopCommand]
          def rubocop_root_command
            rubocop_command.ignore_parent_exclusion(true).file(path)
          end
        end
      end
    end
  end
end
