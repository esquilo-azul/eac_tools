# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'dashed/mygem/version'

Gem::Specification.new do |s|
  s.name        = 'dashed-mygem'
  s.version     = Dashed::Mygem::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{exe,lib}/**/*', 'Gemfile', 'Gemfile.lock']
  s.required_ruby_version = '>= 2.7'
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.add_dependency 'eac_ruby_base0', '~> 0.9'
  s.add_dependency 'eac_ruby_utils', '~> 0.122'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.10'
end
