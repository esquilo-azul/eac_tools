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

  s.add_dependency 'avm', '~> 0.96', '>= 0.96.1'
  s.add_dependency 'avm-eac_asciidoctor_base0', '~> 0.25'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.15', '>= 0.15.1'
  s.add_dependency 'avm-eac_github_base0', '~> 0.3'
  s.add_dependency 'avm-eac_gitlab_base0', '~> 0.5'
  s.add_dependency 'avm-eac_latex_base0', '~> 0.3', '>= 0.3.2'
  s.add_dependency 'avm-eac_php_base0', '~> 0.5'
  s.add_dependency 'avm-eac_postgresql_base0', '~> 0.5', '>= 0.5.3'
  s.add_dependency 'avm-eac_python_base0', '~> 0.2', '>= 0.2.2'
  s.add_dependency 'avm-eac_rails_base0', '~> 0.11', '>= 0.11.1'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.10', '>= 0.10.2'
  s.add_dependency 'avm-eac_redmine_base0', '~> 0.22', '>= 0.22.3'
  s.add_dependency 'avm-eac_redmine_plugin_base0', '~> 0.4', '>= 0.4.1'
  s.add_dependency 'avm-eac_ruby_base0', '~> 0.1'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.36'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.21'
  s.add_dependency 'avm-eac_wordpress_base0', '~> 0.3', '>= 0.3.2'
  s.add_dependency 'avm-git', '~> 0.20'
  s.add_dependency 'avm-tools', '~> 0.163', '>= 0.163.2'
  s.add_dependency 'eac_ruby_utils', '~> 0.128'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12'
end
