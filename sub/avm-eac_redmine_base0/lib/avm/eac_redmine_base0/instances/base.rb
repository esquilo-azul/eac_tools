# frozen_string_literal: true

require 'addressable/uri'

module Avm
  module EacRedmineBase0
    module Instances
      class Base < ::Avm::EacRailsBase1::Instances::Base
        require_sub __FILE__, include_modules: true
        enable_simple_cache

        include ::Avm::EacRubyBase1::Instances::Mixin

        # @return [String]
        def auto_install_ruby_version
          application.local_source.default_ruby_version.if_present(&:to_s) || super
        end

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

        # @return [Avm::Instances::Data::Package]
        def data_package_create
          r = super.add_unit('files', files_data_unit).add_unit('gitolite', gitolite_data_unit)
          r.after_load { instance.run_installer }
          r
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
          url.query_values = { key: admin_api_key }
          ::Avm::EacRedmineBase0::Instances::RestApi.new(url)
        end
      end
    end
  end
end
