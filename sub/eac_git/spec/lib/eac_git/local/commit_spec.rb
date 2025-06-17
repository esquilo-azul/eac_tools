# frozen_string_literal: true

require 'tmpdir'

RSpec.describe EacGit::Local::Commit, :git do
  let(:git) { stubbed_git_local_repo }

  let(:first_commit_sha1) do
    git.file('a.txt').write('AAA')
    git.file('b.txt').write('BBB')
    git.command('add', '.').execute!
    git.command('commit', '-m', 'First commit.').execute!
    git.rev_parse('HEAD')
  end

  let(:second_commit_sha1) do
    first_commit_sha1
    git.file('a.txt').write('AAAAA')
    git.file('b.txt').delete
    git.file('ç.txt').write('CCC')
    git.command('add', '.').execute!
    git.command('commit', '-m', 'Second commit.').execute!
    git.rev_parse('HEAD')
  end

  let(:first_commit) { described_class.new(git, first_commit_sha1) }
  let(:second_commit) { described_class.new(git, second_commit_sha1) }

  describe '#changed_files' do
    it { expect(first_commit.changed_files.count).to eq(2) }
    it { expect(second_commit.changed_files.count).to eq(3) }

    {
      'first_commit' => %w[a.txt b.txt],
      'second_commit' => %w[a.txt b.txt ç.txt]
    }.each do |commit_name, filenames|
      filenames.each do |filename|
        it "find file \"#{filename}\" in commit \"#{commit_name}\"" do
          commit = send(commit_name)
          file = commit.changed_files.find { |f| f.path == filename }
          expect(file).to be_a(EacGit::Local::Commit::ChangedFile)
        end
      end
    end
  end

  describe '#changed_files_size' do
    it { expect(first_commit.changed_files_size).to eq(6) }
    it { expect(second_commit.changed_files_size).to eq(8) }
  end

  describe '#root_child?' do
    it { expect(first_commit.root_child?).to be(true) }
    it { expect(second_commit.root_child?).to be(false) }
  end
end
