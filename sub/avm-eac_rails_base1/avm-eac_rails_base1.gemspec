# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_rails_base1/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_rails_base1'
  s.version     = Avm::EacRailsBase1::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'avm', '~> 0.94'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.35', '>= 0.35.1'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.20', '>= 0.20.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.122'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.10'
end
