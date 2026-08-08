# frozen_string_literal: true

module Avm
  module EacRedminePluginBase0
    module Sources
      module UpdateChanges
        class PluginsRequirements < ::Avm::Sources::Change
          # @return [String]
          def commit_message
            i18n_translate(
              __method__,
              dependencies_file: source.dependencies_file.relative_path_from(source.path)
            )
          end

          # @return [void]
          def perform
            return if source.dependencies_file.blank?

            source.dependencies_file.write(dependencies.to_yaml)
          end

          # @return [Hash<String, Hash>]
          def dependencies
            ::YAML.load_file(source.dependencies_file).keys.to_h do |plugin_id|
              [plugin_id, { 'version_or_higher' => plugin_version(plugin_id.to_sym) }]
            end
          end

          # @param plugin_id [Symbol]
          # @return [String]
          def plugin_version(plugin_id)
            plugin_source(plugin_id).version.to_s
          end

          # @param plugin_id [Symbol]
          # @return [Avm::EacRedminePluginBase0::Sources::Base]
          def plugin_source(plugin_id)
            source.parent.subs.find do |e|
              e.is_a?(::Avm::EacRedminePluginBase0::Sources::Base) && e.plugin_id == plugin_id
            end || raise("Plugin with id \"#{plugin_id}\" not found")
          end
        end
      end
    end
  end
end
