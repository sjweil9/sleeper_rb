# frozen-string-literal: true

require_relative "draft/metadata"
require_relative "draft/settings"

module SleeperRb
  module Resources
    ##
    # Represents a draft for a given user.
    class Draft
      include SleeperRb::Utilities::Cache
      include SleeperRb::Utilities::Request

      ##
      # :attr_reader: type

      ##
      # :attr_reader: status

      ##
      # :attr_reader: start_time

      ##
      # :attr_reader: sport

      ##
      # :attr_reader: season_type

      ##
      # :attr_reader: season

      ##
      # :attr_reader: league_id

      ##
      # :attr_reader: league

      ##
      # :attr_reader: last_picked

      ##
      # :attr_reader: last_message_time

      ##
      # :attr_reader: last_message_id

      ##
      # :attr_reader: draft_order

      ##
      # :attr_reader: draft_id

      ##
      # :attr_reader: creators

      ##
      # :attr_reader: created

      ##
      # :method: settings
      # Settings for the draft.
      #
      # @return [{SleeperRb::Resources::Draft::Settings}[rdoc-ref:SleeperRb::Resources::Draft::Settings]]

      ##
      # :method: metadata
      # Metadata for the draft.
      #
      # @return [{SleeperRb::Resources::Draft::Metadata}[rdoc-ref:SleeperRb::Resources::Draft::Metadata]]

      cached_attr :type, :status, :start_time, :sport, :season_type, :season, :league_id, :last_picked, :league,
                  :last_message_time, :last_message_id, :draft_order, :draft_id, :creators, :created, :slot_to_roster_id,
                  settings: ->(hash) { Settings.new(hash) },
                  metadata: ->(hash) { Metadata.new(hash) }

      skip_refresh :all

      private

      def retrieve_values!
        url = "#{SleeperRb::Utilities::Request::BASE_URL}/draft/#{@draft_id}"
        execute_request(url)
      end
    end
  end
end
