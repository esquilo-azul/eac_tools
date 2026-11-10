# frozen_string_literal: true

module Avm
  module EacRailsBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        class DependsOnEacRailsBase0
          acts_as_instance_method
          common_constructor :source

          EAC_RAILS_BASE0_GEMNAME = 'eac_rails_base0'
          GEMFILE_GEM_PATTERN = /^\s*gem\s+['"]#{EAC_RAILS_BASE0_GEMNAME}['"]/

          # @return [Boolean]
          def result # rubocop:disable Naming/PredicateMethod
            by_gemfile_lock? || by_gemfile? || by_gemspec?
          end

          # @return [Boolean]
          def by_gemfile?
            source.gemfile_path.exist? && GEMFILE_GEM_PATTERN.match?(source.gemfile_path.read)
          end

          # @return [Boolean]
          def by_gemfile_lock?
            source.gemfile_lock_gem_version(EAC_RAILS_BASE0_GEMNAME).present?
          rescue ::Bundler::LockfileError
            false
          end

          # @return [Boolean]
          def by_gemspec?
            source.gemspec_path.present? &&
              source.gemspec.dependencies.any? { |d| d.name == EAC_RAILS_BASE0_GEMNAME }
          end
        end
      end
    end
  end
end
