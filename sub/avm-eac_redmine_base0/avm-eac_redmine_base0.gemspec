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

  s.add_dependency 'avm', '~> 0.80'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.12'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.9', '>= 0.9.3'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.5'
  s.add_dependency 'curb', '~> 0.9', '>= 0.9.11'
  s.add_dependency 'eac_fs', '~> 0.16'
  s.add_dependency 'eac_rest', '~> 0.10'
  s.add_dependency 'eac_ruby_utils', '~> 0.119', '>= 0.119.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.8.0'
end
