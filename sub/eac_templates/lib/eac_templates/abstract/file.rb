# frozen_string_literal: true

module EacTemplates
  module Abstract
    class File < ::EacTemplates::Abstract::FsObject
      enable_abstract_methods
      delegate(*::EacTemplates::InterfaceMethods::FILE - %i[content path], to: :applier)

      # @return [String]
      def content
        path.read
      end

      # @return [Pathname]
      def path
        raise_abstract_method __method__
      end
    end
  end
end
