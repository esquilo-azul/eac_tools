# frozen_string_literal: true

module EacDocker
  module Images
    class Templatized < ::EacDocker::Images::Base
      enable_immutable
      immutable_accessor :tag
      attr_reader :provide_dir

      def id
        tag
      end

      def provide
        ::EacRubyUtils::Fs::Temp.on_directory do |provide_dir|
          self.provide_dir = provide_dir
          write_in_provide_dir
          coded_image(provide_dir).tag(tag).provide
        ensure
          self.provide_dir = nil
        end
      end

      def coded_image(provide_dir)
        ::EacDocker::Images::Coded.new(provide_dir)
      end

      protected

      def variables_source
        self
      end

      def write_in_provide_dir
        template.apply(variables_source, provide_dir)
      end

      private

      attr_writer :provide_dir
    end
  end
end
