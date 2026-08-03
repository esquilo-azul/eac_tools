# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  ignore 'rspec/shared_examples/**/*'
  require 'super_diff'
  require 'super_diff/active_support'
  require 'super_diff/rspec'
end
