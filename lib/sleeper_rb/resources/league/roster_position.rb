# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      ##
      # A string representing a roster position (QB/RB/TE/K/DST/WR/FLEX/BN/IR)
      class RosterPosition
        attr_reader :position

        def initialize(position)
          @position = position.upcase
        end

        VALID_ROSTER_POSITIONS = %w[qb rb wr te k dst flex bn ir super_flex].freeze

        VALID_ROSTER_POSITIONS.each do |position_key|
          define_method("#{position_key}?") { position == position_key.upcase }
        end
      end
    end
  end
end
