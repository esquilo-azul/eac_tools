# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_latex_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_latex_base0'
  s.version     = Avm::EacLatexBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'avm', '~> 0.45'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.9'
  s.add_dependency 'eac_ruby_utils', '~> 0.104'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5', '>= 0.5.1'
end
