# frozen_string_literal: true

module EacGit
  class Local
    module Log
      def log(until_commit = nil, from_commit = nil)
        until_commit, from_commit = [until_commit, from_commit].map { |c| commitize(c) }
        from_commit ||= head
        command('log', '--format=%H', "#{until_commit.id}..#{from_commit.id}")
          .execute!.each_line.map { |line| commitize(line.strip) }
      end
    end
  end
end
