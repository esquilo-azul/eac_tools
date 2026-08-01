# frozen_string_literal: true

module EacRubyBase0
  class ErrorPresenter
    enable_speaker
    common_constructor :the_error

    # @return [String]
    def full_backtrace_message
      the_error.backtrace.map { |v| "#{v}\n" }.join
    end

    # @return [String]
    def full_message
      self_full_message + the_error.cause.if_present('') do |e|
        "#{'-' * 16}\n#{self.class.new(e).full_message}"
      end
    end

    # @return [String]
    def message
      "#{the_error.message} (#{the_error.class})"
    end

    # @return [Pathname]
    def log_path
      @log_path ||= ::EacRubyUtils::Fs::Temp.file.to_pathname.tap { |e| e.write(full_message) }
    end

    # @return [String]
    def self_full_message
      "Error class: #{the_error.class}\n" \
      "Message: #{the_error.message}\n" \
      "Backtrace:\n" + the_error.backtrace.map { |v| "#{v}\n" }.join
    end

    # @return [void]
    def show
      show_message
      show_log_file
    end

    # @return [void]
    def show_message
      error message
    end

    # @return [void]
    def show_log_file
      infov 'Full log', log_path
    end
  end
end
