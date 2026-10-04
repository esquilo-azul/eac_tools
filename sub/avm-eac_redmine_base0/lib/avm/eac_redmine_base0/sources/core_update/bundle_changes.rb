# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class CoreUpdate
        module BundleChanges
          GEMFILE_CONFLICTED_GEMS = %w[rubocop rubocop-rails].freeze

          # @return [void]
          def bundle_changes
            disable_gemfile_conflicted_gems
            load_subs_from_gemfile
            generate_gemfile_lock
          end

          # @return [void]
          def disable_gemfile_conflicted_gems
            GEMFILE_CONFLICTED_GEMS.each do |gem_name|
              disable_gemfile_gem(gem_name)
            end
          end

          # @param gem_name [String]
          # @return [void]
          def disable_gemfile_gem(gem_name)
            source.gemfile_path.write(
              source.gemfile_path.read.gsub(gemfile_gem_line_pattern(gem_name), '\1# \2')
            )
          end

          # @param gem_name [String]
          # @return [Regexp]
          def gemfile_gem_line_pattern(gem_name)
            /^([ \t]*)(gem[ \t]+['"]#{::Regexp.quote(gem_name)}['"].*)$/
          end

          # @return [void]
          def generate_gemfile_lock
            source.bundle_update.system!
          end

          # @return [void]
          def load_subs_from_gemfile
            source.gemfile_path.write(load_subs_from_gemfile_code, mode: 'a')
          end

          # @return [String]
          def load_subs_from_gemfile_code
            <<~'CODE'

              # Subs
              Dir["#{File.join(__dir__, 'sub')}/*"].each do |dir|
                next unless File.exist?(File.join(dir, "#{File.basename(dir)}.gemspec"))

                gem File.basename(dir), path: dir, require: false
              end
            CODE
          end
        end
      end
    end
  end
end
