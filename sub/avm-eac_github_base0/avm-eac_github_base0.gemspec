# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_github_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_github_base0'
  s.version     = Avm::EacGithubBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'avm', '~> 0.81'
  s.add_dependency 'eac_rest', '~> 0.10'
  s.add_dependency 'eac_ruby_utils', '~> 0.119', '>= 0.119.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.8', '>= 0.8.2'
end
