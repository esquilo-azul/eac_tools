# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_php_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_php_base0'
  s.version     = Avm::EacPhpBase0::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'AVM stereotype for PHP applications.'

  s.files = Dir['{lib,locale,template}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.105'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5', '>= 0.5.1'
end
