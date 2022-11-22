# frozen_string_literal: true

require 'avm/eac_php_base0/source_generators/base'
require 'avm/source_generators/runner'

RSpec.describe ::Avm::EacPhpBase0::SourceGenerators::Base do
  include_examples 'avm_source_generated', __FILE__, 'EacPhpBase0'
end
