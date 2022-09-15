# frozen_string_literal: true

require 'addressable/uri'
require 'avm/eac_redmine_base0/instances/data_unit'
require 'avm/eac_redmine_base0/instances/docker_image'
require 'avm/eac_redmine_base0/instances/runners'
require 'avm/eac_redmine_base0/instances/rest_api'
require 'avm/eac_rails_base1/instances/base'

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        enable_simple_cache

        FILES_UNITS = { files: 'files' }.freeze

        def docker_image_class
          ::Avm::EacRedmineBase0::Instances::DockerImage
        end

        def docker_run_arguments
          [
            '--volume',
            "#{install_path}:/home/myuser/eac_redmine_base0",
            '--publish', "#{read_entry(:ssh_port)}:22",
            '--publish', "#{read_entry(:http_port)}:80",
            '--publish', "#{read_entry(:https_port)}:443"
          ]
        end

        def data_package
          @data_package ||= ::Avm::Data::Instance::Package.new(
            self,
            units: {
              all: ::Avm::EacRedmineBase0::Instances::DataUnit.new(self)
            }
          )
        end

        # @return [Addressable::URI]
        def root_url
          r = ::Addressable::URI.parse(read_entry(::Avm::Instances::EntryKeys::WEB_URL))
          r.query_values = nil
          r
        end

        private

        # @return [Avm::EacRedmineBase0::Instances::RestApi]
        def rest_api_uncached
          url = root_url
          url.query_values = { key: read_entry('api.key') }
          ::Avm::EacRedmineBase0::Instances::RestApi.new(url)
        end
      end
    end
  end
end
