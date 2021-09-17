# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Implements {SleeperRb::Utilities::ArrayProxy} and wraps Matchup objects.
      class MatchupArray < SleeperRb::Utilities::ArrayProxy; end
    end
  end
end
