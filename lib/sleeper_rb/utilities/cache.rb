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
        # +cached_attr :display_name, :username, foo: lambda { |x| x + 3 }+
        def cached_attr(*attrs)
          attrs.each do |attr|
            if attr.is_a?(Hash)
              attr.each do |field_name, translator|
                create_method(field_name, translator)
              end
            else
              create_method(attr, ->(x) { x })
            end
          end
        end

        def cached_attrs
          @cached_attrs ||= {}
        end

        def create_method(field_name, translator)
          cached_attrs[field_name.to_sym] = translator
          define_method(field_name) do
            ivar = :"@#{field_name}"
            if instance_variable_defined?(ivar)
              instance_variable_get(ivar)
            else
              instance_variable_set(ivar, translator.call(values[field_name.to_sym]))
            end
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end

      def initialize(opts = {})
        opts.slice(*cached_attrs.keys).each do |key, val|
          instance_variable_set(:"@#{key}", cached_attrs[key].call(val))
        end
      end

      ##
      # Refreshes all memoized values set by cached_attr.
      def refresh
        @values = retrieve_values!
        self
      end

      private

      def cached_attrs
        self.class.cached_attrs
      end

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
