# frozen_string_literal: true

class Object
  def erb_template(subpath, binding_obj = nil)
    self.class.erb_template(subpath, binding_obj || binding)
  end
end
