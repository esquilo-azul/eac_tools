# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/files/version'

Gem::Specification.new do |s|
  s.name        = 'avm-files'
  s.version     = Avm::Files::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'avm', '~> 0.84', '>= 0.84.2'
  s.add_dependency 'eac_cli', '~> 0.40'
  s.add_dependency 'eac_fs', '~> 0.17'
  s.add_dependency 'eac_ruby_utils', '~> 0.121'
  s.add_dependency 'eac_templates', '~> 0.5'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
