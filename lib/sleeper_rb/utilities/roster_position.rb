# frozen_string_literal: true

module SleeperRb
  module Utilities
    ##
    # A string representing a roster position. See VALID_ROSTER_POSITIONS.
    # For every possible position in VALID_ROSTER_POSITIONS, there is a corresponding predicate method (e.g. `qb?`).
    class RosterPosition
      attr_reader :position

      def initialize(position)
        @position = position.upcase
      end

      VALID_ROSTER_POSITIONS = %w[
        qb rb wr te k dst flex bn ir super_flex ol dl de lb olb mlb fs ss db cb nb c rg lg lt rt
      ].freeze

      VALID_ROSTER_POSITIONS.each do |position_key|
        define_method("#{position_key}?") { position == position_key.upcase }
      end
    end
  end
end
