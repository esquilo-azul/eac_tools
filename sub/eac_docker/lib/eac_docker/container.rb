# frozen_string_literal: true

module EacDocker
  class Container
    enable_immutable
    immutable_accessor :interactive, :temporary, :tty, type: :boolean
    immutable_accessor :env, type: :hash
    immutable_accessor :capability, :command_arg, :volume, type: :array
    attr_reader :id

    common_constructor :image

    def immutable_constructor_args
      [image]
    end

    alias immutable_volume volume

    def hostname
      ::EacDocker::Executables.docker.command(
        'inspect', '--format={{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}',
        id
      ).execute!.strip
    end

    # @return [String]
    def logs
      ::EacDocker::Executables.docker.command('logs', id).execute!
    end

    def on_detached
      self.id = run_command(%w[--detach]).execute!.strip
      begin
        yield(self)
      ensure
        stop
      end
    end

    def volume(left_part, right_part = nil)
      immutable_volume(right_part.if_present(left_part) { |v| "#{left_part}:#{v}" })
    end

    def stop
      ::EacDocker::Executables.docker.command('stop', id).execute!
    end

    private

    attr_writer :id

    require_sub __FILE__, require_mode: :kernel
  end
end
