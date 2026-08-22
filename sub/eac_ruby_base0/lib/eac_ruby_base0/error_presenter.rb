# frozen_string_literal: true

module EacRubyBase0
  class ErrorPresenter
    enable_memoized
    enable_speaker
    common_constructor :the_error

    # @return [EacRubyBase0::ErrorPresenter, nil]
    memoize def cause
      the_error.cause.if_present { |v| self.class.new(v) }
    end

    # @return [String]
    def full_backtrace_message
      the_error.backtrace.map { |v| "#{v}\n" }.join
    end

    # @return [String]
    def full_message
      self_full_message + cause.if_present('') do |e|
        "#{'-' * 16}\n#{e.full_message}"
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
    def show_message(caused_by = false) # rubocop:disable Style/OptionalBooleanParameter
      prefix = caused_by ? 'Caused by: ' : ''
      error [prefix, message].join
      cause.if_present { |v| v.show_message(true) }
    end

    # @return [void]
    def show_log_file
      infov 'Full log', log_path
    end
  end
end
