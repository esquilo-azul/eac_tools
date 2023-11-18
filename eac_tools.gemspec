# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_tools/version'

Gem::Specification.new do |s|
  s.name        = 'eac_tools'
  s.version     = EacTools::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,sub}/**/*', 'Gemfile', 'Gemfile.lock']

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'avm', '~> 0.84'
  s.add_dependency 'avm-eac_asciidoctor_base0', '~> 0.20'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.12', '>= 0.12.1'
  s.add_dependency 'avm-eac_github_base0', '~> 0.3'
  s.add_dependency 'avm-eac_latex_base0', '~> 0.3', '>= 0.3.1'
  s.add_dependency 'avm-eac_php_base0', '~> 0.4', '>= 0.4.2'
  s.add_dependency 'avm-eac_postgresql_base0', '~> 0.5', '>= 0.5.2'
  s.add_dependency 'avm-eac_python_base0', '~> 0.2', '>= 0.2.1'
  s.add_dependency 'avm-eac_rails_base0', '~> 0.11'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.10'
  s.add_dependency 'avm-eac_redmine_base0', '~> 0.22'
  s.add_dependency 'avm-eac_redmine_plugin_base0', '~> 0.4'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.33'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.18', '>= 0.18.2'
  s.add_dependency 'avm-eac_wordpress_base0', '~> 0.3', '>= 0.3.1'
  s.add_dependency 'avm-git', '~> 0.14'
  s.add_dependency 'avm-tools', '~> 0.159'
  s.add_dependency 'eac_ruby_utils', '~> 0.119', '>= 0.119.2'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.8.0'
end
