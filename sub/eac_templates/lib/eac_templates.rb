# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  ignore 'core_ext'
  ignore 'sources/from_all_gems'
  require 'eac_config'
  require 'eac_templates/core_ext'
end
