# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      class Base < ::Avm::EacRubyBase1::Sources::Base
        module Parent
          PARENT_RAKE_TASK_TEST_NAME = 'parent_rake_task'

          # @return [String]
          def parent_rake_test_task_name
            [gem_name, 'test'].map(&:variableize).join(':')
          end

          # @return [Boolean]
          def parent_rake_test_command?
            ruby_parent.rake_task?(parent_rake_test_task_name)
          end

          # @return [EacRubyUtils::Envs::Command]
          def parent_rake_test_command
            ruby_parent.rake(parent_rake_test_task_name).chdir_root.envvar('RAILS_ENV', 'test')
          end
        end
      end
    end
  end
end
