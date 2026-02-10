# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_redmine_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_redmine_base0'
  s.version     = Avm::EacRedmineBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,locale,template}/**/*']

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'avm', '~> 0.98', '>= 0.98.4'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.15', '>= 0.15.2'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.11', '>= 0.11.1'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.7'
  s.add_dependency 'eac_fs', '~> 0.20'
  s.add_dependency 'eac_rest', '~> 0.12'
  s.add_dependency 'eac_ruby_utils', '~> 0.128', '>= 0.128.6'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12', '>= 0.12.1'
end
