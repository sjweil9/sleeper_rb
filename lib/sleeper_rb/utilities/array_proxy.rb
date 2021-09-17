# frozen-string-literal: true

require "delegate"

module SleeperRb
  module Utilities
    ##
    # A wrapper for arrays of various SleeperRb::Resources that implements a light ActiveRecord-inspired syntax
    # for filtering the underlying collection.
    #
    # Valid operators for use in #where are: gt, gte, lt, lte, not.
    class ArrayProxy < SimpleDelegator
      VALID_OPERATORS = {
        gt: ->(element, comparison) { element > comparison },
        gte: ->(element, comparison) { element >= comparison },
        lt: ->(element, comparison) { element < comparison },
        lte: ->(element, comparison) { element <= comparison },
        not: ->(element, comparison) { element != comparison },
        eq: ->(element, comparison) { element == comparison },
        in: ->(element, comparison) { comparison.include?(element) }
      }.freeze

      def where(options = {})
        filtered = __getobj__.dup
        options.each do |field, value|
          value = { eq: value } unless value.is_a?(Hash)
          raise ArgumentError, "Invalid operator, must be one of: #{valid_operators}" unless valid_keys?(value)

          value.each do |operator, comparison|
            filtered = filtered.select { |object| VALID_OPERATORS[operator].call(object.send(field), comparison) }
          end
        end
        self.class.new(filtered)
      end

      private

      def valid_operators
        VALID_OPERATORS.keys.join(", ")
      end

      def valid_keys?(hash)
        hash.keys.all? { |key| VALID_OPERATORS.keys.include?(key) }
      end
    end
  end
end
