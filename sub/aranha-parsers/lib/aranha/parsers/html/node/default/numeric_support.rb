# frozen_string_literal: true

require 'aranha/parsers/html/node/base'
require 'eac_ruby_utils/core_ext'

module Aranha
  module Parsers
    module Html
      module Node
        class Default < ::Aranha::Parsers::Html::Node::Base
          module NumericSupport
            def integer_value(node, xpath)
              r = string_value(node, xpath)
              return nil if r.blank?

              m = /\d+/.match(r)
              raise "Integer not found in \"#{r}\"" unless m

              m[0].to_i
            end

            def integer_optional_value(node, xpath)
              r = string_value(node, xpath)
              m = /\d+/.match(r)
              m ? m[0].to_i : nil
            end

            def float_value(node, xpath)
              parse_float(node, xpath, true)
            end

            def float_optional_value(node, xpath)
              parse_float(node, xpath, false)
            end

            def us_decimal_value(node, xpath)
              parse_us_decimal(node, xpath, true)
            end

            def us_decimal_optional_value(node, xpath)
              parse_us_decimal(node, xpath, false)
            end

            private

            def parse_float(node, xpath, required)
              s = string_value(node, xpath)
              m = /\d+(?:[\.\,](\d+))?/.match(s)
              if m
                m[0].delete('.').tr(',', '.').to_f
              elsif required
                raise "Float value not found in \"#{s}\""
              end
            end

            def parse_us_decimal(node, xpath, required)
              s = string_value(node, xpath)
              m = /\d+(?:[\.\,](\d+))?/.match(s)
              if m
                m[0].delete(',').to_f
              elsif required
                raise "US decimal value not found in \"#{s}\""
              end
            end
          end
        end
      end
    end
  end
end
