# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/envs'
require 'avm/eac_ruby_base1/rubygems/version_file'
require 'avm/eac_ruby_base1/sources/base'
require 'rubygems'

module EacRubyGemsUtils
  class Gem
    enable_simple_cache

    GEMSPEC_EXTNAME = '.gemspec'

    common_constructor :root, :host_env, default: [nil] do
      @root = ::Pathname.new(root).expand_path
      self.host_env ||= ::EacRubyUtils::Envs.local
    end

    def to_s
      name
    end

    # @return [Avm::EacRailsBase1::Sources::Base::BundleCommand]
    def bundle(*args)
      ::Avm::EacRailsBase1::Sources::Base.new(root).bundle(*args)
    end

    # @return A [Pathname] array with relative paths from root listed in gemspec's .file directive.
    def files
      gemspec.files.map(&:to_pathname)
    end

    def gemfile_lock_gem_version(gem_name)
      gemfile_lock_content.specs.find { |gem| gem.name == gem_name }.if_present(&:version)
    end

    def gemfile_lock_content
      ::Bundler::LockfileParser.new(::Bundler.read_file(gemfile_lock_path))
    end

    def name
      name_by_gemspec || name_by_path
    end

    def name_by_gemspec
      gemspec_path.if_present { |v| v.basename(GEMSPEC_EXTNAME).to_path }
    end

    def name_by_path
      fullname = root.basename.to_s
      /\A(.+)(?:-\d+(?:\.\d+)*)\z/.if_match(fullname, false) { |m| m[1] }.if_present(fullname)
    end

    def namespace_parts
      name.split('-')
    end

    def rake(*args)
      raise "File \"#{rakefile_path}\" does not exist" unless rakefile_path.exist?

      bundle('exec', 'rake', '--rakefile', rakefile_path, *args)
    end

    def version
      version_file.value
    end

    private

    def gemfile_path_uncached
      root.join('Gemfile')
    end

    def gemfile_lock_path_uncached
      gemfile_path.basename_sub { |b| "#{b}.lock" }
    end

    def gemspec_uncached
      ::Gem::Specification.load(gemspec_path.to_path)
    end

    def gemspec_path_uncached
      ::Pathname.glob("#{root.to_path}/*#{GEMSPEC_EXTNAME}").first
    end

    def rakefile_path_uncached
      root.join('Rakefile')
    end

    def version_file_uncached
      ::Avm::EacRubyBase1::Rubygems::VersionFile.new(version_file_path)
    end

    def version_file_path_uncached
      root.join('lib', *namespace_parts, 'version.rb')
    end
  end
end
