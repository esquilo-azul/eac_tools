# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/eac_ubuntu_base0/instances/base'
require 'avm/instances/docker_image'
require 'eac_templates/core_ext'

module Avm
  module EacRedmineBase0
    module Instances
      class DockerImage < ::Avm::Instances::DockerImage
        enable_simple_cache

        BASE_IMAGE = 'ubuntu:20.04'
        INSTALLER_TARGET_TASK_WITH_WEB_PATH_BLANK = 'redmine_as_apache_base'
        INSTALLER_TARGET_TASK_WITH_WEB_PATH_PRESENT = 'redmine_as_apache_path'
        DATABASE_INTERNAL_HOSTNAME = 'localhost'
        REDMINE_SOURCE_HOST_SUBPATH = 'redmine_source'

        def avm_fs_cache_object_id
          instance.id
        end

        def apache_setup
          return '' if web_path_present?

          template.child('Dockerfile_apache_setup').apply(self)
        end

        def base_image
          eac_ubuntu_base0_instance.docker_image.provide.id
        end

        def database_internal
          instance.entry(::Avm::Instances::EntryKeys::DATABASE_HOSTNAME).value ==
            DATABASE_INTERNAL_HOSTNAME
        end

        def installer_target_task
          if web_path_present?
            INSTALLER_TARGET_TASK_WITH_WEB_PATH_PRESENT
          else
            INSTALLER_TARGET_TASK_WITH_WEB_PATH_BLANK
          end
        end

        def redmine_user
          eac_ubuntu_base0_instance.docker_image.user_name
        end

        def redmine_user_home
          eac_ubuntu_base0_instance.docker_image.user_home
        end

        def redmine_path
          "#{redmine_user_home}/redmine_app"
        end

        def skip_database
          ENV['SKIP_DATABASE']
        end

        def start_path
          '/start.sh'
        end

        def web_path_present?
          ::Addressable::URI.parse(instance.web_url).path.present?
        end

        private

        def eac_ubuntu_base0_instance
          r = ::Avm::EacUbuntuBase0::Instances::Base.by_id(instance.id)
          r.docker_image_options = instance.docker_image_options
          r
        end

        def git_repo_uncached
          ::EacGit::Local.new(instance.source_instance.fs_path)
        end

        def redmine_source_git_id
          git_repo.rev_parse('HEAD')
        end

        def redmine_source_path_uncached
          r = provide_dir.join(REDMINE_SOURCE_HOST_SUBPATH)
          ::FileUtils.rm_rf(r.to_path)
          r.mkpath
          git_repo.commit(redmine_source_git_id).archive_to_dir(r).system!
          REDMINE_SOURCE_HOST_SUBPATH
        end
      end
    end
  end
end
