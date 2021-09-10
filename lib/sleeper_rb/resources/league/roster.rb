module SleeperRb
  module Resources
    class League
      class Roster
        include SleeperRb::Utilities::Cache

        PLAYER_LAMBDA = lambda { |array| array.map { |player_id| Resources::Player.new(player_id: player_id) } }

        cached_attr :roster_id, :owner_id, :league_id,
                    settings: lambda { |settings| Roster::Settings.new(settings) },
                    starters: PLAYER_LAMBDA,
                    players: PLAYER_LAMBDA,
                    reserve: PLAYER_LAMBDA

        def owner
          @owner ||= Resources::User.new(user_id: owner_id)
        end
      end
    end
  end
end
