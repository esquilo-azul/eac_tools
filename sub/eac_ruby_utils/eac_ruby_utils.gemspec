# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'eac_ruby_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'eac_ruby_utils'
  s.version     = ::EacRubyUtils::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Utilities for E.A.C.\'s Ruby projects.'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'README.rdoc']

  s.add_dependency 'activesupport', '>= 4', '< 7'
  s.add_dependency 'addressable', '~> 2.8', '>= 2.8.4'
  s.add_dependency 'bundler'
  s.add_dependency 'filesize', '~> 0.2'
  s.add_dependency 'net-ssh', '~> 4.2'
  s.add_development_dependency 'avm-eac_ubuntu_base0', '~> 0.4'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
