# frozen_string_literal: true

module EacDocker
  module Images
    class Coded < ::EacDocker::Images::Base
      enable_simple_cache
      enable_immutable
      immutable_accessor :tag
      common_constructor :path do
        self.path = path.to_pathname
      end

      def immutable_constructor_args
        [path]
      end

      def provide
        id
        self
      end

      private

      def id_uncached
        if ::EacDocker::Debug.enabled?
          ::EacDocker::Executables.docker.command(*build_args.excluding('--quiet')).system!
        end
        ::EacDocker::Executables.docker.command(*build_args).execute!.strip
          .then { |digest| tag.presence || digest }
      end

      def build_args
        args = %w[build --quiet]
        args += ['--tag', tag] if tag.present?
        args + [path.to_path]
      end
    end
  end
end
