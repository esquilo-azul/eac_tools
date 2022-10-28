# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_generic_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_generic_base0'
  s.version     = Avm::EacGenericBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,locale}/**/*']

  s.add_dependency 'avm', '~> 0.53'
  s.add_dependency 'eac_ruby_utils', '~> 0.106', '>= 0.106.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
