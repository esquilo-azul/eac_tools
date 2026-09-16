# frozen_string_literal: true

module EacGit
  class Local
    # A git-subrepo (https://github.com/ingydotnet/git-subrepo) in a [EacGit::Local].
    class Subrepo
      require_sub __FILE__
      enable_memoized

      common_constructor :local, :subpath do
        self.subpath = subpath.to_pathname
        local.raise_error "Config file \"#{config_absolute_path}\" not found" unless
          config_absolute_path.file?
      end

      def command(subrepo_subcommand, *subrepo_subcommand_args)
        local.command('subrepo', subrepo_subcommand, subpath.to_path,
                      *subrepo_subcommand_args)
      end

      delegate(*::EacGit::Subrepo::Configuration::MAPPING.keys, to: :config)

      def write_config
        config_absolute_path.write(config.to_content)
      end

      memoize def config
        ::EacGit::Subrepo::Configuration.from_file(config_absolute_path)
      end

      memoize def config_absolute_path
        config_relative_path.expand_path(local.root_path)
      end

      memoize def config_relative_path
        subpath.join('.gitrepo')
      end

      memoize def remote
        ::EacGit::Remote.new(remote_uri)
      end
    end
  end
end
