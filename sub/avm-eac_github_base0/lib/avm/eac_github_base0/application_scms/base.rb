# frozen_string_literal: true

require 'avm/git/application_scms/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGithubBase0
    module ApplicationScms
      class Base < ::Avm::Git::ApplicationScms::Base
        # @return [Addressable::URI]
        def web_url
          application.scm_url.to_uri + application.scm_repos_path.to_s
        end
      end
    end
  end
end
