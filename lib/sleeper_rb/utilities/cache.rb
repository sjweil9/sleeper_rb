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
            define_method(attr) do
              ivar = :"@#{attr}"
              if instance_variable_defined?(ivar)
                instance_variable_get(ivar)
              else
                instance_variable_set(ivar, values[attr.to_s])
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
