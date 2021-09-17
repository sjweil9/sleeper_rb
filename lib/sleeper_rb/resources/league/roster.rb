# frozen_string_literal: true

require_relative "roster/settings"

module SleeperRb
  module Resources
    class League
      ##
      # A roster belonging to a specific user in a specific league.
      class Roster
        include SleeperRb::Utilities::Cache

        PLAYER_LAMBDA = ->(array) { PlayerArray.new(array&.map { |player_id| Player.new(player_id: player_id) }) }

        ##
        # :attr_reader: roster_id

        ##
        # :attr_reader: owner_id

        ##
        # :attr_reader: league_id

        ##
        # :method: league
        # The league to which the roster belongs
        #
        # @return [{SleeperRb::Resources::League}[rdoc-ref:SleeperRb::Resources::League]]

        ##
        # :method: settings
        #
        # @return [{SleeperRb::Resources::League::Roster::Settings}[rdoc-ref:SleeperRb::Resources::League::Roster::Settings]]

        ##
        # :method: starters
        # The players currently starting for this roster.
        #
        # @return [{SleeperRb::Resources::PlayerArray}[rdoc-ref:SleeperRb::Resources::PlayerArray]]

        ##
        # :method: players
        # The players currently currently on the roster.
        #
        # @return [{SleeperRb::Resources::PlayerArray}[rdoc-ref:SleeperRb::Resources::PlayerArray]]

        ##
        # :method: reserve
        # The players currently on the reserve for this roster.
        #
        # @return [{SleeperRb::Resources::PlayerArray}[rdoc-ref:SleeperRb::Resources::PlayerArray]]

        cached_attr :roster_id, :owner_id, :league_id, :league,
                    settings: ->(settings) { Settings.new(settings) },
                    starters: PLAYER_LAMBDA,
                    players: PLAYER_LAMBDA,
                    reserve: PLAYER_LAMBDA

        delegate(*Settings.cached_attrs.keys, to: :settings)

        skip_refresh :all

        ##
        # :method: owner
        #
        # @return [{SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]]
        cached_association :owner do
          User.new(user_id: owner_id)
        end
      end
    end
  end
end
