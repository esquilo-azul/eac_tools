# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  require 'avm'
  require 'avm/eac_generic_base0'
  require 'avm/eac_postgresql_base0'
  require 'avm/eac_ubuntu_base0'
end
