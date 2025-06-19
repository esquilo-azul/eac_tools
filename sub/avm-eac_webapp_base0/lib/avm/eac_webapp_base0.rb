# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__

require 'eac_ruby_gem_support'

module Avm
  module EacWebappBase0
    require_sub __FILE__
  end
end
