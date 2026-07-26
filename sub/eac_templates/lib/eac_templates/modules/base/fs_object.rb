# frozen_string_literal: true

module EacTemplates
  module Modules
    class Base
      module FsObject
        def self_ancestor
          owner.self_ancestor.send(type)
        end
      end
    end
  end
end
