# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Represents a matchup for a specific team in a specific week. Two records with the same matchup_id are paired
      # against each other.
      class Matchup
        include SleeperRb::Utilities::Cache

        cached_attr :starters_points, :roster_id, :points, :matchup_id, :custom_points, :league,
                    starters: ->(array) { array&.map { |id| Player.new(player_id: id) } },
                    players: ->(array) { array&.map { |id| Player.new(player_id: id) } }

        skip_refresh :all

        ##
        # @return [{SleeperRb::Resources::League::Roster}[rdoc-ref:SleeperRb::Resources::League::Roster]]
        cached_association(:roster) do
          retrieve_roster!
        end

        private

        def retrieve_roster!
          league.rosters.detect { |roster| roster.roster_id == roster_id }
        end
      end
    end
  end
end
