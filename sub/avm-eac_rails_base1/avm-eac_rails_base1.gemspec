# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_rails_base1/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_rails_base1'
  s.version     = Avm::EacRailsBase1::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/*']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'avm', '~> 0.102', '>= 0.102.3'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.43', '>= 0.43.2'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.22', '>= 0.22.3'
  s.add_dependency 'eac_ruby_base1', '~> 0.1', '>= 0.1.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.14'
end
