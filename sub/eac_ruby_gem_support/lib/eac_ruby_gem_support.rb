# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__

require 'active_support/ordered_options' # Fix "super_diff" '0.18.0'.
require 'super_diff'
require 'super_diff/active_support'
require 'super_diff/rspec'

module EacRubyGemSupport
end
