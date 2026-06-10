# frozen_string_literal: true

require 'eac_ruby_utils'
EacRubyUtils::RootModuleSetup.perform __FILE__

module Avm
  autoload :EacAsciidoctorBase0, 'avm/eac_asciidoctor_base0'
  autoload :EacGenericBase0, 'avm/eac_generic_base0'
  autoload :EacGithubBase0, 'avm/eac_github_base0'
  autoload :EacGitlabBase0, 'avm/eac_gitlab_base0'
  autoload :EacLatexBase0, 'avm/eac_latex_base0'
  autoload :EacPhpBase0, 'avm/eac_php_base0'
  autoload :EacPostgresqlBase0, 'avm/eac_postgresql_base0'
  autoload :EacPythonBase0, 'avm/eac_python_base0'
  autoload :EacRailsBase0, 'avm/eac_rails_base0'
  autoload :EacRailsBase1, 'avm/eac_rails_base1'
  autoload :EacRedmineBase0, 'avm/eac_redmine_base0'
  autoload :EacRedminePluginBase0, 'avm/eac_redmine_plugin_base0'
  autoload :EacRubyBase0, 'avm/eac_ruby_base0'
  autoload :EacRubyBase1, 'avm/eac_ruby_base1'
  autoload :EacWebappBase0, 'avm/eac_webapp_base0'
  autoload :EacWordpressBase0, 'avm/eac_wordpress_base0'
  autoload :Git, 'avm/git'
  autoload :Tools, 'avm/tools'
end

module EacTools
end
