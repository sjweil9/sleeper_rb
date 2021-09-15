# frozen-string-literal: true

require_relative "pick/metadata"

module SleeperRb
  module Resources
    class Draft
      ##
      # A pick from a given draft, containing information about the user and selected player.
      class Pick
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: round

        ##
        # :attr_reader: roster_id

        ##
        # :attr_reader: player_id

        ##
        # :attr_reader: picked_by

        ##
        # :attr_reader: pick_no

        ##
        # :attr_reader: is_keeper

        ##
        # :attr_reader: draft_slot

        ##
        # :attr_reader: draft_id

        ##
        # :method: draft
        # Returns the draft instance to which this pick belongs.
        #
        # @return [{SleeperRb::Resources::Draft}[rdoc-ref:SleeperRb::Resources::Draft]]

        ##
        # :method: metadata
        # Returns the metadata for this pick.
        #
        # @return [{SleeperRb::resources::Draft::Pick::Metadata}[rdoc-ref:SleeperRb::resources::Draft::Pick::Metadata]]

        cached_attr :round, :roster_id, :player_id, :picked_by, :pick_no, :is_keeper, :draft_slot, :draft_id, :draft,
                    metadata: ->(hash) { Metadata.new(hash) }

        skip_refresh :all

        ##
        # :method: player
        # Returns the player instance selected with this pick.
        #
        # @return [{SleeperRb::Resources::Player}[rdoc-ref:SleeperRb::Resources::Player]]
        cached_association :player do
          Player.new(player_id: player_id)
        end

        ##
        # :method: roster
        # Returns the roster instance to which this pick belongs.
        #
        # @return [{SleeperRb::Resources::League::Roster}[rdoc-ref:SleeperRb::Resources::League::Roster]]
        cached_association :roster do
          draft.league.rosters.detect { |roster| roster.roster_id == roster_id }
        end

        ##
        # :method: user
        # Returns the user instance to whom this pick belongs.
        #
        # @return [{SleeperRb::Resources::User}[rdoc-ref:SleeperRb::Resources::User]]
        cached_association :user do
          draft.league.users.detect { |user| user.user_id == picked_by }
        end
      end
    end
  end
end
