# frozen_string_literal: true

require 'avm/eac_ruby_base1/sources/base'
require 'eac_templates/core_ext'
require 'eac_ruby_utils/core_ext'

module Avm
  module Ruby
    module Gems
      class Generator
        IDENT = '  '
        JOBS = %w[root_directory gemspec root_lib version_lib static gemfile_lock].freeze
        TEMPLATE_VARIABLES = %w[lib_path name root_module].freeze

        enable_speaker
        enable_simple_cache
        common_constructor :root_directory, :options, default: [{}] do
          self.root_directory = root_directory.to_pathname
          run
        end

        def eac_ruby_gem_support_version
          dependency_version('eac_ruby_gem_support')
        end

        def eac_ruby_utils_version
          dependency_version('eac_ruby_utils')
        end

        def name
          root_directory.basename.to_s
        end

        def lib_path
          name.split('-').join('/')
        end

        def root_module
          lib_path.camelize
        end

        def root_module_close
          root_module_components.count.times.map do |index|
            (IDENT * index) + 'end'
          end.reverse.join("\n")
        end

        def root_module_inner_identation
          IDENT * root_module_components.count
        end

        def root_module_open
          root_module_components.each_with_index.map do |component, index|
            (IDENT * index) + 'module ' + component
          end.join("\n")
        end

        def root_module_components
          root_module.split('::')
        end

        protected

        def apply_to_root_directory(template, subpath)
          if template.is_a?(::EacTemplates::Directory)
            template.children.each do |child|
              apply_to_root_directory(child, subpath.join(child.basename))
            end
          elsif template.is_a?(::EacTemplates::File)
            template.apply_to_file(template_variables, root_directory.join(subpath))
          else
            raise "Unknown template object: #{template}"
          end
        end

        def dependency_version(gem_name)
          VersionBuilder.new(gem_name, options).to_s
        end

        def generate_gemspec
          template_apply('gemspec', "#{name}.gemspec")
        end

        def generate_gemfile_lock
          self_gem.bundle('install').chdir_root.execute!
        end

        def generate_root_directory
          root_directory.mkpath
        end

        def generate_root_lib
          template_apply('root_lib', "lib/#{lib_path}.rb")
        end

        def generate_static
          template.child('static').apply(self, root_directory)
        end

        def generate_version_lib
          template_apply('version', "lib/#{lib_path}/version.rb")
        end

        def run
          infov 'Root directory', root_directory
          infov 'Gem name', name
          JOBS.each do |job|
            infom "Generating #{job.humanize}..."
            send("generate_#{job}")
          end
        end

        def self_gem_uncached
          ::Avm::EacRubyBase1::Sources::Base.new(root_directory)
        end

        def template_apply(from, to)
          target = root_directory.join(to)
          target.dirname.mkpath
          template.child("#{from}.template").apply_to_file(self, target.to_path)
        end

        class VersionBuilder
          enable_simple_cache
          common_constructor :gem_name, :options

          def to_s
            r = "'~> #{two_segments}'"
            r += ", '>= #{three_segments}'" if segments.count >= 3 && segments[2].positive?
            r
          end

          # @return [Gem::Version]
          def version
            (options_version || default_version)
          end

          def two_segments
            segments.first(2).join('.')
          end

          def three_segments
            segments.first(3).join('.')
          end

          private

          def segments_uncached
            version.release.to_s.split('.').map(&:to_i)
          end

          def default_version
            ::Gem.loaded_specs[gem_name].version
          end

          def options_version
            options["#{gem_name}_version".to_sym].if_present do |v|
              ::Gem::Version.new(v)
            end
          end
        end
      end
    end
  end
end
