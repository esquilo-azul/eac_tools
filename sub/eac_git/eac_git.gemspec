# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_git/version'

Gem::Specification.new do |s|
  s.name        = 'eac_git'
  s.version     = EacGit::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,vendor}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.120'
  s.add_dependency 'parseconfig', '~> 1.1', '>= 1.1.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
