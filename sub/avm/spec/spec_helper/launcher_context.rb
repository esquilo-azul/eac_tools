# frozen_string_literal: true

DUMMY_DIR = File.expand_path('../dummy', __dir__)

RSpec.shared_context 'with launcher' do
  before do
    require 'avm/launcher/context'
    Avm::Launcher::Context.current = Avm::Launcher::Context.new(
      projects_root: DUMMY_DIR,
      settings_file: File.join(__dir__, 'launcher_context', 'settings.yml'),
      cache_root: Dir.mktmpdir
    )
    @remotes_dir = Dir.mktmpdir
    allow(ProgressBar).to receive(:create).and_return(double.as_null_object)
  end

  def temp_context(settings_path)
    require 'avm/launcher/context'
    require 'tmpdir'
    Avm::Launcher::Context.current = Avm::Launcher::Context.new(
      projects_root: Dir.mktmpdir, settings_file: settings_path, cache_root: Dir.mktmpdir
    )
  end

  def init_remote(name)
    require 'avm/git/launcher/base'
    r = Avm::Git::Launcher::Base.new(File.join(@remotes_dir, name)) # rubocop:disable RSpec/InstanceVariable
    r.init_bare
    r
  end

  def init_git(subdir)
    require 'avm/git/launcher/base'
    r = Avm::Git::Launcher::Base.new(File.join(Avm::Launcher::Context.current.root.real,
                                               subdir))
    r.git
    r.execute!('config', 'user.email', 'theuser@example.net')
    r.execute!('config', 'user.name', 'The User')
    r
  end

  def touch_commit(repos, subpath)
    require 'fileutils'
    FileUtils.mkdir_p(File.dirname(repos.subpath(subpath)))
    FileUtils.touch(repos.subpath(subpath))
    repos.execute!('add', repos.subpath(subpath))
    repos.execute!('commit', '-m', subpath)
  end
end
