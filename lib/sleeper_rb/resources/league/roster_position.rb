# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      ##
      # A string representing a roster position (QB/RB/TE/K/DST/WR)
      class RosterPosition
        attr_reader :position

        def initialize(position)
          @position = position
        end

        %w[qb rb wr te k dst flex bn].each do |position_key|
          define_method("#{position_key}?") { position == position_key.upcase }
        end
      end
    end
  end
end
