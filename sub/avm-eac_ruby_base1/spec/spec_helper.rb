# frozen_string_literal: true

require 'avm/eac_ruby_base1'
require 'eac_ruby_gem_support'
EacRubyUtils::Rspec.default_setup_create(File.expand_path('..', __dir__)).stub_avm_contexts
