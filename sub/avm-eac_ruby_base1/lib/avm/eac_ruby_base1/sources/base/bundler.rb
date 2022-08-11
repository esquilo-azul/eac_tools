# frozen_string_literal: true

require 'avm/eac_generic_base0/sources/base'
require 'avm/eac_ruby_base1/sources/base/bundle_command'
require 'avm/eac_ruby_base1/sources/bundle_update'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase1
    module Sources
      class Base < ::Avm::EacGenericBase0::Sources::Base
        module Bundler
          CONFIGURED_GEMFILE_PATH_ENTRY_KEY = 'ruby.gemfile_path'
          DEFAULT_GEMFILE_PATH = 'Gemfile'

          # @return [Avm::EacRubyBase1::Sources::Base::BundleCommand]
          def bundle(*args)
            ::Avm::EacRubyBase1::Sources::Base::BundleCommand.new(self, %w[bundle] + args)
              .envvar_gemfile
          end

          # @return [Avm::EacRubyBase1::Sources::BundleUpdate]
          def bundle_update
            ::Avm::EacRubyBase1::Sources::BundleUpdate.new(self)
          end

          # @return [String]
          def configured_gemfile_path
            configuration_entry(CONFIGURED_GEMFILE_PATH_ENTRY_KEY).value
          end

          # @return [String]
          def default_gemfile_path
            DEFAULT_GEMFILE_PATH
          end

          # @return [Bundler::LockfileParser]
          def gemfile_lock_content
            ::Bundler::LockfileParser.new(::Bundler.read_file(gemfile_lock_path))
          end

          def gemfile_lock_gem_version(gem_name)
            gemfile_lock_content.specs.find { |gem| gem.name == gem_name }.if_present(&:version)
          end

          # @return [Pathname]
          def gemfile_lock_path
            gemfile_path.basename_sub { |b| "#{b}.lock" }
          end

          # @return [Pathname]
          def gemfile_path
            path.join(configured_gemfile_path || default_gemfile_path)
          end
        end
      end
    end
  end
end
