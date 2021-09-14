# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Represents a traded draft pick for any season of the League.
      class TradedPick
        include SleeperRb::Utilities::Cache

        cached_attr :league, :season, :round, :roster_id, :previous_owner_id, :owner_id

        skip_refresh :all

        cached_association(:original_roster) do
          league.rosters.detect { |roster| roster.roster_id == roster_id }
        end

        cached_association(:previous_roster) do
          league.rosters.detect { |roster| roster.roster_id == previous_owner_id }
        end

        cached_association(:current_roster) do
          league.rosters.detect { |roster| roster.roster_id == owner_id }
        end
      end
    end
  end
end
