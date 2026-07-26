# frozen_string_literal: true

module EacTemplates
  module Modules
    class Ancestor
      class File < ::EacTemplates::Abstract::File
        include ::EacTemplates::Modules::Ancestor::FsObject

        TEMPLATE_EXTNAME_PATTERN =
          /#{::Regexp.quote(::EacTemplates::Variables::FsObject::TEMPLATE_EXTNAME)}\z/

        class << self
          def parse_basename(basename)
            basename.if_present do |v|
              v.to_pathname
                .to_path
                .gsub(TEMPLATE_EXTNAME_PATTERN, '')
                .to_pathname
            end
          end
        end

        # @return [Boolean]
        def found?
          source_object.found? || template?
        end

        # @return [Pathname]
        def path
          template? ? template_source_object.path : source_object.path
        end

        # @return [Pathname]
        def basename
          self.class.parse_basename(super)
        end

        # @return [Boolean]
        def template?
          template_source_object.found?
        end

        protected

        # @return [EacTemplates::Sources::File]
        def template_source_object_uncached
          owner.source_set.send(type, template_source_object_path_for_search)
        end

        # @return [Pathname]
        def template_source_object_path_for_search
          path_for_search.basename_sub do |b|
            "#{b}#{::EacTemplates::Variables::FsObject::TEMPLATE_EXTNAME}"
          end
        end
      end
    end
  end
end
