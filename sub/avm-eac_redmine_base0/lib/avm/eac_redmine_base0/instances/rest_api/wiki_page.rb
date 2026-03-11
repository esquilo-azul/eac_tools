# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class RestApi < ::EacRest::Api
        class WikiPage < ::Avm::EacRedmineBase0::Instances::RestApi::EntityBase
          enable_simple_cache

          # @return [Hash]
          def data_from_id
            fetch_data(prefix)
          end

          # @return [String]
          def data_root
            'wiki_page'
          end

          # @return [String]
          def prefix
            "#{parent_entity.prefix}/wiki/#{id}"
          end

          # @return [String]
          def read
            data.fetch(data_root).fetch('text')
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
              data_root => { 'text' => text }
            }
          end
        end
      end
    end
  end
end
