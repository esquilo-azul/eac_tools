# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_config/version'

Gem::Specification.new do |s|
  s.name        = 'eac_config'
  s.version     = EacConfig::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 3.2' # rubocop:disable Gemspec/RequiredRubyVersion

  s.add_dependency 'addressable', '~> 2.9'
  s.add_dependency 'eac_ruby_base1', '~> 0.1', '>= 0.1.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.15'
end
