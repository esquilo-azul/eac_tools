# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_tools/version'

Gem::Specification.new do |s|
  s.name        = 'eac_tools'
  s.version     = EacTools::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'avm-eac_generic_base0', '~> 0.2', '>= 0.2.1'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.3', '>= 0.3.1'
  s.add_dependency 'avm-eac_redmine_base0', '~> 0.7'
  s.add_dependency 'avm-eac_redmine_plugin_base0', '~> 0.1', '>= 0.1.1'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.8', '>= 0.8.2'
  s.add_dependency 'avm-tools', '~> 0.121'
  s.add_dependency 'eac_ruby_utils', '~> 0.95', '>= 0.95.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
