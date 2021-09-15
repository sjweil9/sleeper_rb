# frozen-string-literal: true

module SleeperRb
  module Resources
    class Draft
      ##
      # Metadata about a particular Draft.
      class Metadata
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: scoring_type

        ##
        # :attr_reader: name

        ##
        # :attr_reader: description

        ##
        # :attr_reader: offering_user_id

        ##
        # :attr_reader: offering_slot

        ##
        # :attr_reader: nominating_user_id

        ##
        # :attr_reader: nominating_slot

        ##
        # :attr_reader: nominated_player_id

        ##
        # :attr_reader: hovered_player_id

        ##
        # :attr_reader: highest_offer

        cached_attr :scoring_type, :name, :description, :offering_user_id, :offering_slot, :nominating_user_id,
                    :nominating_slot, :nominated_player_id, :hovered_player_id, :highest_offer

        ##
        # :method: offering_user
        # The user who has made the most recent offer.
        #
        # @return [{SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]]
        cached_association :offering_user do
          User.new(user_id: offering_user_id)
        end

        ##
        # :method: nominating_user
        # The user who has made the most recent nomination.
        #
        # @return [{SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]]
        cached_association :nominating_user do
          User.new(user_id: nominating_user_id)
        end

        ##
        # :method: nominated_player
        # The player who is currently nominated.
        #
        # @return [{SleeperRb::Resources::Player}[rdoc-ref:SleeperRb::Resources::Player]]
        cached_association :nominated_player do
          Player.new(player_id: nominated_player_id)
        end

        ##
        # :method: hovered_player
        #
        # @return [{SleeperRb::Resources::Player}[rdoc-ref:SleeperRb::Resources::Player]]
        cached_association :hovered_player do
          Player.new(player_id: hovered_player_id)
        end

        skip_refresh :all
      end
    end
  end
end
