# frozen_string_literal: true

require 'avm/eac_webapp_base0/file_formats/json'

::RSpec.describe ::Avm::EacWebappBase0::FileFormats::Json do
  include_examples 'avm_file_formats_with_fixtures', __FILE__
end
