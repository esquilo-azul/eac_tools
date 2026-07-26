# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_docker/version'

Gem::Specification.new do |s|
  s.name        = 'eac_docker'
  s.version     = EacDocker::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'eac_ruby_base1', '~> 0.1', '>= 0.1.1'
  s.add_dependency 'eac_templates', '~> 0.9'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.14'
end
