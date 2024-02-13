# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'i18n'

module Avm
  module Sources
    class Base
      module Locale
        LOCALE_KEY = 'locale'

        def locale
          configured_locale || default_locale
        end

        def configured_locale
          configuration_entry(LOCALE_KEY).value
        end

        def default_locale
          ::I18n.default_locale
        end

        # @param entry_suffix [String]
        # @param values [Hash]
        # @return [String]
        def i18n_translate(entry_suffix, values = {})
          self.class.i18n_translate(entry_suffix, values.merge(__locale: locale))
        end
      end
    end
  end
end
