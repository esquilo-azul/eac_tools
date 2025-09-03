# frozen_string_literal: true

module EacCli
  class Parser
    class Alternative
      module ShortOptions
        SHORT_OPTION_PREFIX = '-'
        SHORT_OPTION_CHAR_PATTERN = /\A[0-9a-zA-Z]\z/.freeze

        private

        # @return [Boolean]
        def argv_current_short_option?
          phase == PHASE_ANY && argv_enum.peek.start_with?(SHORT_OPTION_PREFIX) &&
            !argv_current_long_option?
        end

        # @para char [String]
        # @return [EacCli::Definition::Option, nil]
        def find_short_option(char)
          alternative.options.find do |option|
            short_without_prefix(option.short).if_present(false) { |v| v == char }
          end
        end

        # @return [void]
        def short_option_collect_argv_value
          last_option = nil
          short_without_prefix(argv_enum.peek).each_char do |char|
            raise_error "Invalid option: \"#{char}\"" unless SHORT_OPTION_CHAR_PATTERN.match?(char)
            raise_error "Option \"#{last_option}\" requires a argument not provided" if
            last_option.present?

            collected_option = short_option_collect_char(char)
            last_option = collected_option if collected_option.argument?
          end
        end

        # @param char [String]
        # @return [EacCli::Definition::Option] The option collected.
        def short_option_collect_char(char)
          option = find_short_option(char)
          option ? option_collect_option(option) : any_option_collect_option
        end

        # @param short [String]
        # @return [String]
        def short_without_prefix(short)
          short.to_s.gsub(/\A#{::Regexp.quote(SHORT_OPTION_PREFIX)}/, '')
        end
      end
    end
  end
end
