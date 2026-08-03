# frozen_string_literal: true

RSpec.shared_context 'spec_paths' do |the_spec_file|
  cattr_accessor :spec_paths_controller
  self.spec_paths_controller = EacRubyGemSupport::Rspec::SpecPathsController.new(self,
                                                                                 the_spec_file)

  %i[fixtures_directory spec_directory spec_file].each do |m|
    let(m) { self.class.spec_paths_controller.send(m) }
  end
end
