# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/files/version'

Gem::Specification.new do |s|
  s.name        = 'avm-files'
  s.version     = Avm::Files::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'DEPRECATED: use gem "avm" instead.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'avm', '~> 0.93'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.10'
end
