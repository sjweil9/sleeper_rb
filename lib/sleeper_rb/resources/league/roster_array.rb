# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Implements {SleeperRb::Utilities::ArrayProxy} and wraps Roster objects.
      class RosterArray < SleeperRb::Utilities::ArrayProxy; end
    end
  end
end
