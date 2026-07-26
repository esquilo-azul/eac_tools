# frozen_string_literal: true

require 'erb'

class Module
  # @param subpath [Pathname]
  # @param binding_obj [Object]
  # @return [ERB]
  def erb_template(subpath, binding_obj)
    ::ERB.new(eac_template.child(subpath).path.read).result(binding_obj)
  end
end
