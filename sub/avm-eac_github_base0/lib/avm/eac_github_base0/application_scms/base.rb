# frozen_string_literal: true

require 'avm/git/application_scms/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    module ApplicationScms
      class Base < ::Avm::Git::ApplicationScms::Base
        REPOSITORY_URL_SUFFIX = '.git'

        # @return [Addressable::URI]
        def git_https_url
          r = web_url.dup
          r.path = "#{r.path}#{REPOSITORY_URL_SUFFIX}"
          r
        end

        # @return [Addressable::URI]
        def git_ssh_url
          ::Addressable::URI.new(
            scheme: 'ssh',
            user: application.scm_ssh_username,
            host: web_url.host,
            path: "#{application.scm_repos_path}#{REPOSITORY_URL_SUFFIX}"
          )
        end

        # @return [Addressable::URI]
        def web_url
          application.scm_url.to_uri + application.scm_repos_path.to_s
        end
      end
    end
  end
end
