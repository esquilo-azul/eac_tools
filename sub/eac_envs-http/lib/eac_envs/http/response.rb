# frozen_string_literal: true

require 'active_support/core_ext/hash/conversions'
require 'eac_envs/http/error'
require 'eac_ruby_utils/core_ext'
require 'faraday'
require 'json'

module EacEnvs
  module Http
    class Response < ::StandardError
      COMMON_HEADERS = %w[Content-Type].freeze
      HEADER_LINE_PARSER = /\A([^:]+):(.*)\z/.to_parser do |m|
        [m[1].strip, m[2].strip]
      end

      # https://www.w3.org/wiki/LinkHeader
      LINKS_HEADER_NAME = 'Link'

      # https://www.w3.org/wiki/LinkHeader
      LINK_PARSER = /\A\<(.+)\>\s*;\s*rel\s*=\s*\"(.*)\"\z/.to_parser do |m|
        [m[2], m[1]]
      end

      common_constructor :request
      delegate :response_body_data_proc, to: :request

      def body_data
        r = performed.headers['Accept'].if_present(body_str) do |v|
          method_name = "body_data_from_#{v.parameterize.underscore}"
          respond_to?(method_name) ? send(method_name) : body_str
        end
        r = response_body_data_proc.call(r) if response_body_data_proc.present?
        r
      end

      def body_data_or_raise
        raise_unless_200

        body_data
      end

      # @return [String]
      def body_str
        performed.body
      end

      def body_str_or_raise
        raise_unless_200

        body_str
      end

      def header(name)
        hash_search(headers, name)
      end

      # @return [Hash<String, String>]
      def headers
        performed.headers.to_hash
      end

      def link(rel)
        hash_search(links, rel)
      end

      def links
        header(LINKS_HEADER_NAME).if_present({}) do |v|
          v.split(',').map { |w| LINK_PARSER.parse!(w.strip) }.to_h
        end
      end

      def raise_unless_200
        return nil if status == 200

        raise self
      end

      def status
        performed.status.to_i
      end

      delegate :url, to: :request

      def to_s
        "URL: #{url}\nStatus: #{status}\nBody:\n\n#{body_str}"
      end

      COMMON_HEADERS.each do |header_key|
        define_method header_key.underscore do
          header(header_key)
        end
      end

      private

      def body_data_from_application_json
        ::JSON.parse(body_str)
      end

      def body_data_from_application_xml
        Hash.from_xml(body_str)
      end

      def hash_search(hash, key)
        key = key.to_s.downcase
        hash.each do |k, v|
          return v if k.to_s.downcase == key
        end
        nil
      end

      def performed
        @performed ||= request.faraday_response
      rescue ::Faraday::Error
        raise ::EacEnvs::Http::Error
      end
    end
  end
end
