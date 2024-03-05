# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_wordpress_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_wordpress_base0'
  s.version     = Avm::EacWordpressBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/*']

  s.add_dependency 'avm', '~> 0.86', '>= 0.86.2'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.18', '>= 0.18.4'
  s.add_dependency 'eac_ruby_utils', '~> 0.112'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5', '>= 0.5.1'
end
