# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/files/version'

Gem::Specification.new do |s|
  s.name        = 'avm-files'
  s.version     = Avm::Files::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'avm', '~> 0.93'
  s.add_dependency 'eac_cli', '~> 0.42'
  s.add_dependency 'eac_fs', '~> 0.18'
  s.add_dependency 'eac_ruby_utils', '~> 0.122'
  s.add_dependency 'eac_templates', '~> 0.7', '>= 0.7.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.10'
end
