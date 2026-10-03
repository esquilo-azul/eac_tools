# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class CoreUpdate
        module Tempdir
          def on_temp_dir
            ::EacRubyUtils::Fs::Temp.on_directory do |dir|
              @tempdir = dir
              yield
            end
          end

          protected

          attr_accessor :tempdir
        end
      end
    end
  end
end
