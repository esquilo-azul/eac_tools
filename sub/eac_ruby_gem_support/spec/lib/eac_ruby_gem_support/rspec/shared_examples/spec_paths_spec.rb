# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

RSpec.describe "RSpec.shared_examples('spec_paths')" do # rubocop:disable RSpec/DescribeClass
  include_context 'spec_paths', __FILE__

  it do
    expect(spec_file).to eq(__FILE__.to_pathname)
  end

  it do
    expect(spec_directory).to eq(__FILE__.to_pathname.dirname)
  end

  it do
    expect(fixtures_directory).to eq(__FILE__.to_pathname.dirname.join('spec_paths_spec_files'))
  end
end
