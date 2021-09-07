# frozen_string_literal: true

module SleeperRb
  module Utilities
    module Cache
      module ClassMethods
        def cached_attr(*attrs)
          attrs.each do |attr|
            define_method(attr) do
              ivar = :"@#{attr}"
              if instance_variable_defined?(ivar)
                instance_variable_get(ivar)
              else
                instance_variable_set(ivar,
                                      values[attr.to_s])
              end
            end
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end

      def refresh
        @values = retrieve_values!
        self
      end

      private

      def values
        return @values if defined?(@values)

        @values = retrieve_values!
      end

      def retrieve_values!
        raise NotImplementedError, "must implement retrieve_values! to use SleeperRb::Cache"
      end
    end
  end
end
