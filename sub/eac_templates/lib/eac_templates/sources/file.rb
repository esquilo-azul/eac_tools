# frozen_string_literal: true

module EacTemplates
  module Sources
    class File < ::EacTemplates::Abstract::File
      include ::EacTemplates::Sources::FsObject
    end
  end
end
