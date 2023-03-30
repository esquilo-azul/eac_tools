# frozen_string_literal: true

require 'avm/launcher/paths/real'
require 'avm/launcher/stereotype'
require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    module Paths
      class Logical
        include ::Comparable
        include ::EacRubyUtils::SimpleCache

        class << self
          def from_h(context, hash)
            parent_path = hash[:parent_path] ? from_h(context, hash[:parent_path]) : nil
            new(context, parent_path, hash[:real], hash[:logical])
          end
        end

        common_constructor :context, :parent_path, :real, :logical do
          self.real = ::Avm::Launcher::Paths::Real.new(real)
        end

        def <=>(other)
          [logical, real] <=> [other.logical, other.real]
        end

        def to_s
          logical
        end

        def to_h
          { logical: logical, real: real.to_s, parent_path: parent_path ? parent_path.to_h : nil }
        end

        def project?
          stereotypes.any?
        end

        def children
          r = []
          Dir.entries(warped).each do |c|
            c_path = ::File.join(warped, c)
            next unless ::File.directory?(c_path)
            next if c.start_with?('.')

            r << build_child(c)
          end
          r
        end

        def included?
          !context.settings.excluded_paths.include?(logical)
        end

        private

        def stereotypes_uncached
          ::Avm::Launcher::Stereotype.stereotypes.select { |s| s.match?(self) }
        end

        def build_child(name)
          ::Avm::Launcher::Paths::Logical.new(
            context,
            self,
            ::File.join(warped, name),
            ::File.join(logical, name)
          )
        end

        def warped_uncached
          if is_a?(::Avm::Launcher::Instances::Base)
            stereotypes.each do |s|
              return s.warp_class.new(self) if s.warp_class
            end
          end
          real
        end
      end
    end
  end
end
