# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Represents a traded draft pick for any season of the League.
      class TradedPick
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: league

        ##
        # :attr_reader: season

        ##
        # :attr_reader: round

        ##
        # :attr_reader: previous_owner_id

        ##
        # :attr_reader: roster_id

        ##
        # :attr_reader: owner_id

        cached_attr :league, :season, :round, :roster_id, :previous_owner_id, :owner_id

        skip_refresh :all

        ##
        # :method: original_roster
        # The roster which originally owned this pick.
        #
        # @return [{SleeperRb::Resources::League::Roster}[SleeperRb::Resources::league::Roster]]
        cached_association(:original_roster) do
          league.rosters.detect { |roster| roster.roster_id == roster_id }
        end

        ##
        # :method: previous_roster
        # The last roster to have owned this pick before the current one (can be same as original_roster).
        #
        # @return [{SleeperRb::Resources::League::Roster}[SleeperRb::Resources::league::Roster]]
        cached_association(:previous_roster) do
          league.rosters.detect { |roster| roster.roster_id == previous_owner_id }
        end

        ##
        # :method: current_roster
        # The roster which currently owns this pick.
        #
        # @return [{SleeperRb::Resources::League::Roster}[SleeperRb::Resources::league::Roster]]
        cached_association(:current_roster) do
          league.rosters.detect { |roster| roster.roster_id == owner_id }
        end
      end
    end
  end
end
