# frozen_string_literal: true

require 'active_support/callbacks'
require 'avm/entries/jobs/base'
require 'eac_ruby_utils/core_ext'
require 'eac_templates/core_ext'
require 'net/http'

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        require_sub __FILE__, include_modules: true, require_dependency: true

        DEFAULT_REFERENCE = 'HEAD'

        REQUEST_TEST_JOB = 'request_test'
        JOBS = (%w[create_build_dir build_content append_instance_content write_on_target
                   setup_files_units assert_instance_branch] + [REQUEST_TEST_JOB]).freeze

        include ::Avm::Entries::Jobs::Base

        lists.add_symbol :option, :appended_directories, :no_request_test, :reference,
                         :remote_read, :remote_write

        def option_list
          ::Avm::EacWebappBase0::Instances::Deploy.lists.option
        end

        def run
          super
        ensure
          remove_build_dir
        end

        def start_banner
          infov 'Instance', instance
          infov 'Git reference (User)', git_reference.if_present('- BLANK -')
          infov 'Git remote name', git_remote_name
          infov 'Git reference (Found)', git_reference_found
          infov 'Git commit SHA1', commit_reference
          infov 'Appended directories', appended_directories
        end

        def setup_files_units
          instance.data_package.units.values.map(&:installation_files_data).select(&:present?)
            .each { |unit_install| setup_files_unit(unit_install.key, unit_install.subpath) }
        end

        def assert_instance_branch
          return unless remote_write?

          infom 'Setting instance branch...'
          git.command('push', git_remote_name, "#{commit_reference}:refs/heads/#{instance.id}",
                      '-f').execute!
        end

        def request_test
          infom 'Requesting web interface...'
          uri = URI(instance.read_entry('web.url'))
          response = ::Net::HTTP.get_response(uri)
          infov 'Response status', response.code
          fatal_error "Request to #{uri} failed" unless response.code.to_i == 200
        end

        protected

        def jobs
          r = super
          r.delete(REQUEST_TEST_JOB) if options[OPTION_NO_REQUEST_TEST]
          r
        end
      end
    end
  end
end
