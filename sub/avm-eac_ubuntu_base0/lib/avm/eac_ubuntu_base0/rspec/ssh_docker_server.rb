# frozen_string_literal: true

require 'eac_docker/images/templatized'
require 'eac_ruby_utils/core_ext'
require 'eac_templates/core_ext'

module Avm
  module EacUbuntuBase0
    module Rspec
      class SshDockerServer < ::EacDocker::Images::Templatized
        # @return [EacRubyUtils::Envs::SshEnv]
        def env
          raise '@env is blank' if @env.blank?

          @env
        end

        def on_run
          on_container do
            on_env do
              yield
            end
          end
        end

        private

        def container
          raise '@container is blank' if @container.blank?

          @container
        end

        def env_identity_file
          template.child('id_rsa').path
        end

        def env_identity_file_good_permissions
          r = ::EacRubyUtils::Fs::Temp.file
          ::FileUtils.cp env_identity_file, r
          r.chmod(0o600)
          r
        end

        def close_env
          @identity_file.remove
          @env = nil
        end

        def on_env
          open_env
          begin
            yield
          ensure
            close_env
          end
        end

        def on_container
          provide.container.temporary(true).on_detached do |container|
            @container = container
            begin
              yield
            ensure
              @container = nil
            end
          end
        end

        def open_env
          raise 'Environment already open' if @env.present?

          @identity_file = env_identity_file_good_permissions
          @env = ::EacRubyUtils::Envs::SshEnv.new(
            "ssh://root@#{container.hostname}" \
            '?StrictHostKeyChecking=no' \
            '&BatchMode=yes' \
            "&IdentityFile=#{@identity_file}"
          )
        end
      end
    end
  end
end
