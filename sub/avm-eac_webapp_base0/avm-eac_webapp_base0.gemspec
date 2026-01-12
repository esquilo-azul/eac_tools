# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_webapp_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_webapp_base0'
  s.version     = Avm::EacWebappBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/{*,.*}']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'avm', '~> 0.98', '>= 0.98.1'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.15', '>= 0.15.1'
  s.add_dependency 'avm-eac_postgresql_base0', '~> 0.5', '>= 0.5.3'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.6'
  s.add_dependency 'eac_ruby_utils', '~> 0.128', '>= 0.128.4'
  s.add_dependency 'htmlbeautifier', '~> 1.4', '>= 1.4.3'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12'
end
