# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'avm/launcher/context/instance_manager'
require 'eac_ruby_utils/simple_cache'
require 'eac_cli/speaker'
require 'avm/launcher/context/instance_discovery'
require 'avm/launcher/context/settings'
require 'avm/launcher/paths/logical'
require 'avm/launcher/project'
require 'avm/tools/self'

module Avm
  module Launcher
    class Context
      include ::EacRubyUtils::SimpleCache
      enable_speaker

      class << self
        attr_writer :current

        def current
          @current ||= default
        end

        def default
          @default ||= Context.new
        end
      end

      attr_reader :root, :settings, :cache_root
      attr_accessor :publish_options, :recache, :instance_manager

      CONFIG_PATH_PREFIX = 'launcher'

      def initialize(options = {})
        @options = options.with_indifferent_access
        @root = ::Avm::Launcher::Paths::Logical.new(self, nil, build_option(:projects_root), '/')
        @settings = ::Avm::Launcher::Context::Settings.new(build_option(:settings_file))
        @cache_root = build_option(:cache_root)
        @publish_options = { new: false, confirm: false, stereotype: nil }
        @instance_manager = ::Avm::Launcher::Context::InstanceManager.new(self)
        @recache = false
      end

      def instance(name)
        instances.find { |i| i.name == name }
      end

      def instances
        @instance_manager.instances
      end

      def pending_instances
        @instance_manager.pending_instances
      end

      private

      def build_option(key)
        @options[key] || config_option(key) || default_option(key)
      end

      def config_option(key)
        ::Avm::Self::Instance.default.entry([CONFIG_PATH_PREFIX, key].join('.')).optional_value
      end

      def default_cache_root
        ::Avm::Tools::Self.application.cache_dir.join('launcher')
      end

      def default_option(key)
        send("default_#{key}".underscore)
      end

      def default_projects_root
        '.'
      end

      def default_settings_file
        ::Avm::Tools::Self.application.config_dir.join('launcher.yaml')
      end

      def projects_uncached
        r = {}
        instances.each do |i|
          r[i.project_name] ||= []
          r[i.project_name] << i
        end
        r.map { |name, instances| ::Avm::Launcher::Project.new(name, instances) }
      end
    end
  end
end
