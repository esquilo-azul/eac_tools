# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_php_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_php_base0'
  s.version     = Avm::EacPhpBase0::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'AVM stereotype for PHP applications.'

  s.files = Dir['{lib,locale,template}/**/*']

  s.add_dependency 'avm-eac_generic_base0', '~> 0.12', '>= 0.12.2'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.18', '>= 0.18.3'
  s.add_dependency 'eac_ruby_utils', '~> 0.121'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.10'
end
