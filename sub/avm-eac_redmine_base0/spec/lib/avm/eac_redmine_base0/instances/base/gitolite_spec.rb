# frozen_string_literal: true

require 'avm/eac_redmine_base0/instances/base'

RSpec.describe Avm::EacRedmineBase0::Instances::Base, '#gitolite' do
  include_examples 'entries_values', __FILE__, {
    'app_0' => {
      'gitolite.username' => 'git',
      'gitolite.path' => '/var/lib/git',
      'gitolite.scheme' => 'file',
      'gitolite.hostname' => 'localhost'
    },
    'app_1' => {
      'gitolite.username' => 'git1',
      'gitolite.path' => '/var/lib/git1',
      'gitolite.scheme' => 'file',
      'gitolite.hostname' => 'localhost'
    },
    'app_2' => {
      'gitolite.username' => 'git2',
      'gitolite.path' => '/home/git2',
      'gitolite.scheme' => 'file',
      'gitolite.hostname' => 'localhost'
    }
  }
end
