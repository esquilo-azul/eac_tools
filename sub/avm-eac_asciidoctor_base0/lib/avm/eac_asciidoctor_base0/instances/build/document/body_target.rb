# frozen_string_literal: true

require 'asciidoctor'
require 'avm/eac_asciidoctor_base0/instances/macros'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          module BodyTarget
            common_concern

            BODY_TARGET_BASENAME = 'index.html'

            # Absolute path to the output of Asciidoctor's source file.
            #
            # @return [Pathname]
            def body_target_path
              build.target_directory.join(source_document.subpath).join(BODY_TARGET_BASENAME)
            end

            # @return [Asciidoctor::Document]
            def build_body
              ::Asciidoctor.convert(
                pre_processed_body_source_content,
                base_dir: convert_base_dir,
                to_file: body_target_path.to_path, safe: :unsafe, mkdirs: true
              )
            end
          end
        end
      end
    end
  end
end
