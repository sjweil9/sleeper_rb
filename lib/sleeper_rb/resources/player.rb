module SleeperRb
  module Resources
    class Player
      extend SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      class << self
        ##
        # Ensuring there is one source of players so the heavy endpoint need not be called frequently.
        #
        # @return [Array<{SleeperRb::Resources::Player}[rdoc-ref:SleeperRb::Resources::Player]>]
        def all
          @all ||= player_hashes.reduce([]) do |array, (key, value)|
            array << new(value.merge(player_id: key))
          end
        end

        ##
        # Retrieves a particular Player by ID.
        #
        # @return [SleeperRb::Resources::Player] The Player instance
        def find(player_id)
          new(player_hashes[player_id].merge(player_id: player_id))
        end

        private

        def player_hashes
          @player_hashes ||= retrieve_players!
        end

        def retrieve_players!
          url = "#{BASE_URL}/players/nfl"
          execute_request(url)
        end
      end

      cached_attr :hashtag, :depth_chart_position, :status, :sport, :number, :injury_start_date, :weight,
                  :practice_participation, :sportradar_id, :team, :last_name, :college, :fantasy_data_id,
                  :injury_status, :player_id, :height, :age, :stats_id, :birth_country, :espn_id, :first_name,
                  :depth_chart_order, :years_exp, :rotowire_id, :rotoworld_id, :yahoo_id,
                  fantasy_positions: lambda { |array| array&.map { |pos| League::RosterPosition.new(pos) } },
                  position: lambda { |pos| League::RosterPosition.new(pos) }

      ##
      # @return [String] Combined first and last name
      def full_name
        [first_name, last_name].join(" ")
      end

      private

      def retrieve_values!
        self.class.player_hashes[@player_id.to_sym]
      end
    end
  end
end