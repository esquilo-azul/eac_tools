# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  require 'avm/eac_ruby_base1'
  require 'eac_cli'
  require 'eac_config'
  require 'eac_fs'
end
