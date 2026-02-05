# frozen_string_literal: true

module Avm
  module EacRedmineBase0
    module Instances
      class RestApi < ::EacRest::Api
        class EntityBase < ::EacRest::Entity
          def build_request(url_suffix)
            api.request_json("#{url_suffix}.json")
          end

          def data_from_response(response)
            raise "\"#{response.url}\" returned non-ok status: #{response.status}" unless
            response.status.to_s.start_with?('2')

            return {} if response.body_str.blank?

            response.body_data
          rescue ::JSON::ParserError
            raise "\"#{response.url}\" returned invalid JSON: \"#{response.body_str}\" " \
                  "(Status: #{response.status})"
          end

          def fetch_data(url_suffix)
            data_from_response(build_request(url_suffix).response)
          end
        end
      end
    end
  end
end
