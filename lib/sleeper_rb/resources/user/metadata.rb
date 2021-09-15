# frozen-string-literal: true

module SleeperRb
  module Resources
    class User
      ##
      # Metadata exists only when the User object was retrieved from a league. Includes team_name for that league.
      class Metadata
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: team_name

        cached_attr :team_name

        skip_refresh :all
      end
    end
  end
end
