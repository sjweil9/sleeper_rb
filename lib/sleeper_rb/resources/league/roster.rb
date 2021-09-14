# frozen_string_literal: true

require_relative "roster/settings"

module SleeperRb
  module Resources
    class League
      ##
      # A roster belonging to a specific user in a specific league.
      class Roster
        include SleeperRb::Utilities::Cache

        PLAYER_LAMBDA = ->(array) { array&.map { |player_id| Resources::Player.new(player_id: player_id) } }

        cached_attr :roster_id, :owner_id, :league_id,
                    settings: ->(settings) { Roster::Settings.new(settings) },
                    starters: PLAYER_LAMBDA,
                    players: PLAYER_LAMBDA,
                    reserve: PLAYER_LAMBDA

        skip_refresh :all

        ##
        # @return [{SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]]
        cached_association(:owner) do
          Resources::User.new(user_id: owner_id)
        end
      end
    end
  end
end
