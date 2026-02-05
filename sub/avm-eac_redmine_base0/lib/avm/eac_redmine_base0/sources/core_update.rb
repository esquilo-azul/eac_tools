# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Sources
      class CoreUpdate
        enable_speaker
        enable_simple_cache
        common_constructor :source, :version, :url

        GITIGNORE_ADD = %w[/public/assets/**/* /config/install.sh /config/secrets_key.txt
                           /log/**/*].freeze
        GITIGNORE_DEL = %w[/Gemfile.lock /plugins/* /public/themes/*].freeze
        TARGET_KEEP = ::Avm::Sources::Base::Configuration::CONFIGURATION_FILENAMES
                        .map { |b| "/#{b}" } + %w[/Gemfile.lock /plugins/*/**
                                                  /public/themes/*/**].freeze
        TARGET_REMOVE = %w[alternate classic].map { |t| "/public/themes/#{t}/**" }

        def run
          ::EacRubyUtils::Fs::Temp.on_directory do |dir|
            @tempdir = dir
            assert_source_package
            extract_package_to_tempdir
            sync_content
            change_git_ignore
            validate_empty_dir
          end
          git_commit
          success 'Done!'
        end

        def assert_source_package
          infom 'Asserting source package...'
          source_package.assert
          infov 'Package cache path', source_package.path
          infov 'Package size', source_package.path.size
        end

        def fs_object_id
          [source.path, version].join('_').variableize
        end

        private

        attr_reader :tempdir

        def change_git_ignore
          file = target_path.join('.gitignore')
          file.write(
            (file.read.each_line.map(&:strip).reject { |line| GITIGNORE_DEL.include?(line) } +
                ['', '#eac_redmine_base0'] + GITIGNORE_ADD).map { |line| "#{line}\n" }.join
          )
        end

        def extract_package_to_tempdir
          infom "Extracting package to tempdir #{tempdir}..."
          ::EacRubyUtils::Envs.local.command(
            'tar', '-xf', source_package.path.to_path, '-C', tempdir.to_path,
            '--strip-components', '1'
          ).execute!
        end

        def git_commit
          if git_repo.dirty?
            infom 'Git commiting...'
            git_repo.command('add', '--', target_path).execute!
            git_repo.command('commit', '-m', git_commit_message, '--', target_path).execute!
          else
            infom 'Nothing to commit'
          end
        end

        def git_commit_message
          i18n_translate(__method__, version: version, __locale: source.locale)
        end

        def git_repo_uncached
          ::EacGit::Local.new(target_path)
        end

        def sync_content
          ::Avm::Sync.new(source_path, target_path)
            .add_exclude('/*').add_includes(*target_files_to_remove).move_mode(true).run
        end

        # @return [EacFs::CachedDownload]
        def source_package_uncached
          ::EacFs::CachedDownload.new(url, fs_cache)
        end

        def validate_empty_dir
          if source_path.children.empty?
            infom 'No content left in source directory'
          else
            fatal_error 'Found entries in source directory: ' + # rubocop:disable Style/StringConcatenation
                        source_path.children.map { |c| c.basename.to_path }.join(', ')
          end
        end

        def source_path_uncached
          ::Pathname.new(tempdir.to_path)
        end

        # @return [Enumerable<String>]
        def target_files_to_remove
          git_repo.command('ls-files').execute!
            .each_line.map { |v| "/#{v.strip}" }
            .reject { |tpath| target_keep?(tpath) }
        end

        # @param tpath [String]
        # @return [Boolean]
        def target_keep?(tpath)
          tpath = tpath.to_pathname
          TARGET_REMOVE.none? { |target_remove| tpath.fnmatch?(target_remove) }
          TARGET_KEEP.any? { |target_keep| tpath.fnmatch?(target_keep) }
        end

        def target_path_uncached
          source.path
        end
      end
    end
  end
end
