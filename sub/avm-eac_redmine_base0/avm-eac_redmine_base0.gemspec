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

  s.add_dependency 'avm', '~> 0.97', '>= 0.97.1'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.15', '>= 0.15.1'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.10', '>= 0.10.2'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.6'
  s.add_dependency 'curb', '~> 0.9', '>= 0.9.11'
  s.add_dependency 'eac_fs', '~> 0.17'
  s.add_dependency 'eac_rest', '~> 0.12'
  s.add_dependency 'eac_ruby_utils', '~> 0.122'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.9.0'
end
