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
        # +cached_attr :display_name, :username, foo: ->(x) { x + 3 }+
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

        ##
        # Creates a memoized association that returns another resource.
        def cached_association(name, &block)
          define_method(name) do |arg = nil|
            if arg
              cached_associations[name] ||= {}
              cached_associations[name][arg.to_s] ||= instance_exec(arg, &block)
            else
              cached_associations[name] ||= instance_exec(&block)
            end
          end
        end

        ##
        # Takes in a list of fields which should be excluded from refresh. Use :all for models which do not have
        # any endpoint but only retrieve their data from another object. These models have no API source to refresh
        # themselves, but they still have associations.
        def skip_refresh(*fields)
          fields.any? { |field| field == :all } ? @skip_refresh_fields = :all : skip_refresh_fields.concat(fields)
        end

        ##
        # The stored mapping of cached attribute names to their translator functions.
        def cached_attrs
          @cached_attrs ||= {}
        end

        ##
        # The stored list of fields which should be excluded from refresh.
        def skip_refresh_fields
          @skip_refresh_fields ||= []
        end

        private

        def create_method(field_name, translator)
          cached_attrs[field_name.to_sym] = translator
          skip_refresh_fields << field_name.to_sym if field_name.to_s =~ /\w+_id/
          define_method(field_name) do
            ivar = :"@#{field_name}"
            instance_variable_get(ivar) || instance_variable_set(ivar, translator.call(values[field_name.to_sym]))
          end
        end
      end

      ##
      # Ensures that ClassMethods are extended into the base class when including.
      def self.included(base)
        base.extend ClassMethods
      end

      ##
      # Sets up an object with values for any cached_attrs pre-initialized if provided.
      #
      # @param opts [Hash] Key/value pairs that can match any cached_attr.
      def initialize(opts = {})
        opts.slice(*cached_attrs.keys).each do |key, val|
          instance_variable_set(:"@#{key}", cached_attrs[key].call(val))
        end
      end

      ##
      # Refreshes all associations and memoized values set by cached_attr.
      #
      # @return [self]
      def refresh
        cached_attrs.keys.reject { |k| skip_refresh_fields == :all || skip_refresh_fields.include?(k) }.each do |attr|
          ivar = :"@#{attr}"
          instance_variable_set(ivar, nil)
        end
        @values = nil
        @cached_associations = {}
        self
      end

      private

      def cached_attrs
        self.class.cached_attrs
      end

      def skip_refresh_fields
        self.class.skip_refresh_fields
      end

      def cached_associations
        @cached_associations ||= {}
      end

      def values
        @values ||= retrieve_values!
      end

      def retrieve_values!
        {}
      end
    end
  end
end
