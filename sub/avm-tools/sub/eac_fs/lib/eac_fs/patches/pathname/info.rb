# frozen_string_literal: true

require 'eac_fs/file_info'
require 'pathname'

class Pathname
  # Shortcut for `EacFs::FileInfo.new(self)`.
  # @return [EacFs::FileInfo]
  def info
    ::EacFs::FileInfo.new(self)
  end
end
