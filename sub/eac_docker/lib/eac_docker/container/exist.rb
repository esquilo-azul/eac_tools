# frozen_string_literal: true

module EacDocker
  class Container
    # Verify if a container identified by {#id}, if present, or {#name} already exists
    # (running or not).
    class Exist
      acts_as_instance_method name_mark: :'?'
      common_constructor :container
      delegate :id, :name, to: :container

      # @return [Boolean]
      def result # rubocop:disable Naming/PredicateMethod
        ::EacDocker::Executables.docker.command(
          'ps', '--all', '--quiet', '--filter', filter
        ).execute!.present?
      end

      # Filter used by {#result}: by {#id}, if present, or by {#name}.
      #
      # @return [String]
      def filter
        id.presence ? "id=#{id}" : "name=^/#{name}$"
      end
    end
  end
end
