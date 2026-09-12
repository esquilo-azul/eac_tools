# frozen_string_literal: true

require 'tmpdir'

RSpec.describe EacGit::Local, '#dirty_files', :git do
  let(:repo) { stubbed_git_local_repo }
  let(:dirty_files_paths) { Set.new(repo.dirty_files.lazy.map(&:path).map(&:to_path)) }

  before do
    repo.file('a_file').touch
    repo.directory('b_directory').create.file('c_file').touch
    repo.file('d file').touch
  end

  it do
    expect(dirty_files_paths).to eq(Set.new(['a_file', 'b_directory/c_file', 'd file']))
  end
end
