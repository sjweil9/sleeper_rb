# frozen-string-literal: true

module SleeperRb
  module Resources
    class User
      ##
      # Metadata exists only when the User object was retrieved from a league. Includes team_name for that league.
      class Metadata
        include SleeperRb::Utilities::Cache

        cached_attr :team_name
      end
    end
  end
end