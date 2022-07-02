# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    module Git
      class Remote
        common_constructor :git, :name

        def exist?
          git.execute!('remote').each_line.any? { |line| line.strip == name }
        end

        def ls
          git.execute!(['ls-remote', name]).each_line.map do |line|
            x = line.strip.split(/\s+/)
            [x[1], x[0]]
          end.to_h
        end

        # +git remote add ...+
        def add(url)
          git.execute!('remote', 'add', name, url)
        end

        # +git remote rm ...+
        def remove
          git.execute!('remote', 'rm', name)
        end

        # +git remote get-url ...+
        def url
          git.execute!('remote', 'get-url', name).strip.if_present(nil)
        end

        # git remote set-url ...
        def url_set(url)
          git.execute!('remote', 'set-url', name, url)
        end

        # Add or set URL if +url+ is present, remove remote if is blank.
        def url=(url)
          if exist? && url.blank?
            remove
          elsif exist? && self.url != url
            url_set(url)
          elsif !exist?
            add(url)
          end
        end
      end
    end
  end
end
