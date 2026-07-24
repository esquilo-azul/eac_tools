# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  ignore 'core_ext'
  require 'eac_ruby_base0'
  require 'avm/tools/core_ext'
end
