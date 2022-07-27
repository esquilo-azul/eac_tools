# frozen_string_literal: true

APP_PATH = ::File.dirname(__dir__) unless defined?(APP_PATH)
require File.expand_path('boot', __dir__)
require 'eac_rails_base0/app_base/application.rb'

module EacRailsBase0App
  class Application
    config.load_defaults 5.2
  end
end
