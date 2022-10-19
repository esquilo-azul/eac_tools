# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/files/version'

Gem::Specification.new do |s|
  s.name        = 'avm-files'
  s.version     = Avm::Files::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'avm', '~> 0.51'
  s.add_dependency 'eac_cli', '~> 0.28'
  s.add_dependency 'eac_fs', '~> 0.12', '>= 0.12.3'
  s.add_dependency 'eac_ruby_utils', '~> 0.105'
  s.add_dependency 'eac_templates', '~> 0.3', '>= 0.3.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
