# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class RestApi < ::EacRest::Api
        class WikiPage < ::Avm::EacRedmineBase0::Instances::RestApi::EntityBase
          enable_simple_cache

          DATA_ROOT = 'wiki_page'

          # @return [Hash]
          def data_from_id
            data_from_response(request_json.response)
          end

          # @return [Integer]
          def id_from_data
            ::CGI.escape(title)
          end

          # @return [String]
          def read
            unless data.fetch(DATA_ROOT).key?('text')
              self.data_or_id = id
              self.internal_data = nil
            end
            data.fetch(DATA_ROOT).fetch('text')
          end

          # @return [String, nil]
          def parent_title
            data.fetch(DATA_ROOT).if_key('parent').if_present { |v| v.if_key('title') }
          end

          # @return [String]
          def to_api_address_suffix_self
            "/wiki/#{id}"
          end

          # @return [String]
          def title
            data.fetch(DATA_ROOT).fetch('title')
          end

          # @param content [String]
          # @return [+self+]
          def write(text)
            data_from_response(
              build_request(prefix).verb(:put).header('Content-type', 'application/json')
              .body_data(write_data(text).to_json).response
            )
          end

          # @param text [String]
          # @return [Hash]
          def write_data(text)
            {
              DATA_ROOT => { 'text' => text }
            }
          end
        end
      end
    end
  end
end
