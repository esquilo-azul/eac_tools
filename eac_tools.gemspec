# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_tools/version'

Gem::Specification.new do |s|
  s.name        = 'eac_tools'
  s.version     = EacTools::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,sub}/**/*', 'Gemfile', 'Gemfile.lock']

  s.add_dependency 'avm-eac_asciidoctor_base0', '~> 0.4'
  s.add_dependency 'avm-eac_generic_base0', '~> 0.5'
  s.add_dependency 'avm-eac_latex_base0', '~> 0.1'
  s.add_dependency 'avm-eac_rails_base0', '~> 0.6', '>= 0.6.1'
  s.add_dependency 'avm-eac_rails_base1', '~> 0.4', '>= 0.4.2'
  s.add_dependency 'avm-eac_redmine_base0', '~> 0.11'
  s.add_dependency 'avm-eac_redmine_plugin_base0', '~> 0.3'
  s.add_dependency 'avm-eac_ruby_base1', '~> 0.15'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.3', '>= 0.3.1'
  s.add_dependency 'avm-eac_wordpress_base0', '~> 0.1'
  s.add_dependency 'avm-tools', '~> 0.131'
  s.add_dependency 'eac_ruby_utils', '~> 0.97'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
