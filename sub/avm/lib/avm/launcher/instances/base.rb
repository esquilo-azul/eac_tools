# frozen_string_literal: true

require 'avm/launcher/errors/non_project'
require 'eac_ruby_utils/speaker/sender'

module Avm
  module Launcher
    module Instances
      module Base
        class << self
          def extend_object(object)
            object.extend ::EacRubyUtils::SimpleCache
            object.extend ::EacRubyUtils::Speaker::Sender
            object.extend ::Avm::Launcher::Instances::Base::Cache
            super
          end

          def instanciate(path, parent)
            unless path.is_a?(::Avm::Launcher::Instances::Base)
              raise ::Avm::Launcher::Errors::NonProject, path unless path.project?

              path.extend(::Avm::Launcher::Instances::Base)
              path.parent = parent
            end
            path
          end
        end

        require_sub __FILE__

        attr_accessor :parent

        def name
          logical
        end

        def stereotype?(stereotype)
          stereotypes.include?(stereotype)
        end

        def to_parent_path
          return self unless @parent

          logical.gsub(/\A#{Regexp.quote(@parent.logical)}/, '')
        end

        def project?
          stereotypes.any?
        end

        def publish_run
          stereotypes.each do |s|
            next unless publish?(s)

            infov(name, "publishing #{s.label}")
            s.publish_class.new(self).run
          end
        end

        def publish_check
          stereotypes.each do |s|
            next unless publish?(s)

            puts "#{name.to_s.cyan}|#{s.label}|" \
              "#{s.publish_class.new(self).check}"
          end
        end

        def project_name
          ::File.basename(logical)
        end

        def included?
          !::Avm::Launcher::Context.current.settings.excluded_projects.include?(project_name)
        end

        def to_h
          super.to_h.merge(parent: parent ? parent.logical : nil)
        end

        private

        def publish?(stereotype)
          return false unless stereotype.publish_class
          return false unless options.stereotype_publishable?(stereotype)

          filter = ::Avm::Launcher::Context.current.publish_options[:stereotype]
          filter.blank? ? true : filter == stereotype.name.demodulize
        end

        def options_uncached
          ::Avm::Launcher::Context.current.settings.instance_settings(self)
        end
      end
    end
  end
end
