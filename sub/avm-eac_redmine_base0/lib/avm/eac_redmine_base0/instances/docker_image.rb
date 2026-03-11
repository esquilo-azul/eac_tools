# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class DockerImage < ::Avm::Instances::DockerImage
        enable_simple_cache

        APACHE_HOST_DOCKERFILE_SUBPATH = 'apache_host_dockerfile'
        APACHE_PATH_DOCKERFILE_SUBPATH = 'apache_path_dockerfile'
        INSTALLER_TARGET_TASK_WITH_WEB_PATH_BLANK = 'redmine_as_apache_base'
        INSTALLER_TARGET_TASK_WITH_WEB_PATH_PRESENT = 'redmine_as_apache_path'
        REDMINE_SOURCE_HOST_SUBPATH = 'redmine_source'
        SSH_SERVER_INSTALL = <<~CODE
          RUN sudo apt-get install -y openssh-server
          EXPOSE 22/tcp
        CODE

        delegate :database_internal, to: :instance

        def avm_fs_cache_object_id
          instance.id
        end

        def apache_setup
          template.child(apache_setup_dockerfile).apply(self)
        end

        # @return [String]
        def apache_setup_dockerfile
          web_path_present? ? APACHE_PATH_DOCKERFILE_SUBPATH : APACHE_HOST_DOCKERFILE_SUBPATH
        end

        def base_image
          eac_ubuntu_base0_instance.docker_image.provide.id
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
          ENV.fetch('SKIP_DATABASE', nil)
        end

        # Optionally install the SSH server.
        # @return [String]
        def ssh_server_install
          ENV.fetch('SSH_SERVER', false).to_bool ? SSH_SERVER_INSTALL : ''
        end

        def start_path
          '/start.sh'
        end

        def web_path_present?
          ::Addressable::URI.parse(instance.web_url).path.present?
        end

        def write_in_provide_dir
          super

          ::Avm::EacRedmineBase0::Instances::Deploy.template.child('config')
            .child('install.sh')
            .apply_to_file(variables_source, provide_dir.join('install_settings.sh'))
        end

        private

        def eac_ubuntu_base0_instance
          r = ::Avm::EacUbuntuBase0::Instances::Base.by_id(instance.id)
          r.docker_image_options = instance.docker_image_options
          r
        end

        def git_repo_uncached
          ::EacGit::Local.new(instance.source_instance.install_path)
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
