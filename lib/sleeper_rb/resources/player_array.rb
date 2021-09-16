# frozen-string-literal: true

module SleeperRb
  module Resources
    ##
    # Provides methods named for each valid roster position which return a PlayerArray containing all
    # players which match the given roster position.
    class PlayerArray < SleeperRb::Utilities::ArrayProxy
      SleeperRb::Utilities::RosterPosition::VALID_ROSTER_POSITIONS.each do |position|
        define_method(position) do
          where(position: position)
        end
      end
    end
  end
end
