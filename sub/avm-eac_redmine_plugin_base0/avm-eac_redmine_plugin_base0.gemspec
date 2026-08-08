# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_redmine_plugin_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_redmine_plugin_base0'
  s.version     = Avm::EacRedminePluginBase0::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'E.A.C.\'s AVM base for Redmine plugins.'

  s.files = Dir.glob('{lib,locale}/**/*', File::FNM_DOTMATCH)
              .reject { |f| ['.', '..'].include?(File.basename(f)) }
  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'avm-eac_ruby_base1', '~> 0.43', '>= 0.43.3'
  s.add_dependency 'eac_ruby_base1', '~> 0.1', '>= 0.1.1'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.14'
end
