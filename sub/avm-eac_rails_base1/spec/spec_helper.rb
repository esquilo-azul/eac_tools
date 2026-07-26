# frozen_string_literal: true

require 'avm/eac_rails_base1'
require 'eac_ruby_gem_support'
EacRubyUtils::Rspec.default_setup_create(File.expand_path('..', __dir__))
EacRubyUtils::Rspec.default_setup.stub_eac_config_node
