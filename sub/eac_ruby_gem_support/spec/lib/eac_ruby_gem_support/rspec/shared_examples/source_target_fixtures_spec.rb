# frozen_string_literal: true

require 'yaml'

RSpec.describe "RSpec.shared_examples('source_target_fixtures')" do # rubocop:disable RSpec/DescribeClass
  include_examples 'source_target_fixtures', __FILE__

  def source_data(file)
    YAML.load_file(file)
  end
end
