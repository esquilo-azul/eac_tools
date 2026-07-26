# frozen_string_literal: true

module EacTemplates
  module Abstract
    class FsObjectByPathname
      common_constructor :path do
        self.path = path.to_pathname
      end
    end
  end
end
