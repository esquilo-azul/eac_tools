# frozen_string_literal: true

module Avm
  module EacLatexBase0
    module Sources
      class Build
        module CopyFiles
          def copy_project_files
            copy_project_dir('.')
          end

          def copy_project_obj(subpath)
            return if File.basename(subpath).start_with?('.')

            if File.directory?(File.join(project.root, subpath))
              copy_project_dir(subpath)
            else
              copy_project_file(subpath)
            end
          end

          def copy_project_file(subpath)
            ::Avm::EacLatexBase0::Sources::Build::File.new(project, subpath)
              .build_to_dir(source_temp_dir)
          end

          def copy_project_dir(subpath)
            Dir.entries(File.join(project.root, subpath)).each do |f|
              copy_project_obj(File.join(subpath, f))
            end
          end

          def copy_commons_files
            target_dir = source_temp_dir.join('commons')
            target_dir.mkpath
            ::Avm::EacLatexBase0::Sources::Build::Commons.instance.eac_template.apply(self,
                                                                                      target_dir)
          end
        end
      end
    end
  end
end
