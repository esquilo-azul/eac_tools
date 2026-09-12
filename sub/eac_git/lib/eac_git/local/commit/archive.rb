# frozen_string_literal: true

module EacGit
  class Local
    class Commit
      module Archive
        # @return [EacRubyUtils::Envs::Command]
        def archive_to_dir(path)
          path = path.to_pathname
          repo.command('archive', '--format=tar', id).pipe(
            ::EacGit::Executables.tar.command('-xC', path)
          )
        end
      end
    end
  end
end
