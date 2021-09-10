# frozen_string_literal: true

module SleeperRb
  module Utilities
    ##
    # This module encapsulates the logic for caching and refreshing values retrieved from the Sleeper API.
    module Cache
      ##
      # Methods to be extended into the class when included.
      module ClassMethods
        ##
        # Creates a memoized attribute reader for the named attributes.
        #
        # = Example
        # +cached_attr :display_name, :username+
        def cached_attr(*attrs)
          attrs.each do |attr|
            field_name = attr.is_a?(Hash) ? attr.keys.first : attr
            define_method(field_name) do
              ivar = :"@#{field_name}"
              if instance_variable_defined?(ivar)
                instance_variable_get(ivar)
              elsif attr.is_a?(Hash)
                translator = attr.values.first
                instance_variable_set(ivar, translator.call(values[field_name.to_sym]))
              else
                instance_variable_set(ivar, values[field_name.to_sym])
              end
            end
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end

      ##
      # Refreshes all memoized values set by cached_attr.
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
