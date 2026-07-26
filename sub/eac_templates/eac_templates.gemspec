# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_templates/version'

Gem::Specification.new do |s|
  s.name        = 'eac_templates'
  s.version     = EacTemplates::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'eac_config', '~> 0.15'
  s.add_dependency 'eac_ruby_base1', '~> 0.1', '>= 0.1.1'

  s.add_development_dependency 'eac_fs', '~> 0.20', '>= 0.20.2'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.14'
end
