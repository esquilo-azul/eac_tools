# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Base < ::Avm::Instances::Base
        module Apache
          common_concern

          class_methods do
            # @return [Class]
            def apache_path_class
              ancestors.lazy.map { |ancestor| apache_path_class_by_ancestor(ancestor) }
                .find(&:present?) || raise("No apache patch class found for \"#{self}\"")
            end

            private

            # @param ancestor [Module]
            # @return [Class]
            def apache_path_class_by_ancestor(ancestor)
              "#{ancestor.name.deconstantize}::ApachePath".constantize
            rescue ::NameError
              nil
            end
          end

          # @return [Class]
          def apache_path_class
            self.class.apache_path_class
          end

          # @return [Avm::EacUbuntuBase0::Apache::Resource, nil]
          def apache_resource
            %i[conf site]
              .lazy
              .map { |type| platform_instance.apache.send(type, install_apache_resource_name) }
              .find(&:available?)
          end
        end
      end
    end
  end
end
