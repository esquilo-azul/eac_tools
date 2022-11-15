# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_redmine_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_redmine_base0'
  s.version     = Avm::EacRedmineBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,locale,template}/**/*']

  s.add_dependency 'avm', '~> 0.56', '>= 0.56.1'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.8'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.7'
  s.add_dependency 'avm-eac_ubuntu_base0', '~> 0.3'
  s.add_dependency 'curb', '~> 0.9', '>= 0.9.11'
  s.add_dependency 'eac_fs', '~> 0.15'
  s.add_dependency 'eac_rest', '~> 0.6', '>= 0.6.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.107', '>= 0.107.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
