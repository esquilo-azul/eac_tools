# frozen_string_literal: true

require 'avm/eac_github_base0/application_scms/base'

::RSpec.describe ::Avm::EacGithubBase0::ApplicationScms::Base do
  include_examples 'in_avm_registry', 'application_scms'
end
