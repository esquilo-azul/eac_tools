# frozen_string_literal: true

module Avm
  module Git
    module Launcher
      class Base < ::Avm::Launcher::Paths::Real
        module Underlying
          def command(*args)
            args, options = build_args(args)
            r = ::EacGit::Executables.git.command(*args)
            (options[:exit_outputs] || {}).each do |status_code, result|
              r = r.status_result(status_code, result)
            end
            r
          end

          %w[execute execute! system system!].each do |exec_type|
            define_method exec_type do |*args|
              command(*args).send(exec_type)
            rescue ::EacRubyUtils::Envs::ExecutionError
              raise ::Avm::Git::Launcher::Error
            end
          end

          def init
            git
            self
          end

          private

          def build_args(args)
            options = {}
            if args.last.is_a?(Hash)
              options = args.last
              args.pop
            end
            args = args.first if args.first.is_a?(Array)
            [['-C', self, '--no-pager'] + args, options]
          end

          def git_uncached
            FileUtils.mkdir_p(self)
            if File.exist?(subpath('.git'))
              ::Git.open(self)
            else
              ::Git.init(self)
            end
          end
        end
      end
    end
  end
end
