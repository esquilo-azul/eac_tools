# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  require 'avm'
  require 'avm/eac_generic_base0'
  require 'avm/eac_rails_base1'
  require 'avm/eac_ubuntu_base0'
  require 'eac_fs'
  require 'eac_rest'
end
