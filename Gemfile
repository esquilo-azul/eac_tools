# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

::Dir["#{::File.join(__dir__, 'sub')}/*"].each do |dir|
  gem ::File.basename(dir), path: dir, require: false if ::File.file?(::File.join(dir, 'Gemfile'))
end
