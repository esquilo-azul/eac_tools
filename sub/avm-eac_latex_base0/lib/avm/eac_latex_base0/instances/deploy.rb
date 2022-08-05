# frozen_string_literal: true

require 'avm/eac_webapp_base0/deploy'
require 'avm/eac_latex_base0/sources/base'
require 'avm/eac_latex_base0/sources/build'

module Avm
  module EacLatexBase0
    module Instances
      class Deploy < ::Avm::EacWebappBase0::Deploy
        def build_content
          ::Avm::EacLatexBase0::Sources::Build.new(project, output_file:
              build_dir.join(pdf_path))
        end

        def title
          instance.id.humanize
        end

        def pdf_path
          "#{instance.id.underscore}.pdf"
        end

        def variables_source
          self
        end

        private

        def project_uncached
          ::Avm::EacLatexBase0::Sources::Base.new(
            instance.source_instance.read_entry(::Avm::Instances::EntryKeys::FS_PATH)
          )
        end
      end
    end
  end
end
