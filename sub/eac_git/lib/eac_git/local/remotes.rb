# frozen_string_literal: true

module EacGit
  class Local
    module Remotes
      def remote(name)
        ::EacGit::Local::Remote.new(self, name)
      end

      def remotes
        command('remote').execute!.each_line.map(&:strip).compact_blank.map do |name|
          remote(name)
        end
      end
    end
  end
end
