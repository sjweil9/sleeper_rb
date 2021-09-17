# frozen_string_literal: true

require_relative "user/metadata"

module SleeperRb
  module Resources
    ##
    # The User resource represents a single user in Sleeper. This also serves as the access points for associated data.
    class User
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      ##
      # :attr_reader: user_id

      ##
      # :attr_reader: username

      ##
      # :attr_reader: display_name

      ##
      # :attr_reader: is_owner

      ##
      # :method: metadata
      #
      # @return [{SleeperRb::Resources::User::Metadata}[rdoc-ref:SleeperRb::Resources::User::Metadata]]

      ##
      # :method: metadata
      #
      # @return [{SleeperRb::Resources::User::Metadata}[rdoc-ref:SleeperRb::Resources::User::Metadata]]

      ##
      # :method: avatar
      #
      # @return [{SleeperRb::Resources::Avatar}[rdoc-ref:SleeperRb::Resources::Avatar]]

      cached_attr :user_id, :username, :display_name, :is_owner,
                  metadata: ->(hash) { Metadata.new(hash) },
                  avatar: ->(id) { id ? Resources::Avatar.new(avatar_id: id) : nil }

      delegate(*Metadata.cached_attrs.keys, to: :metadata)

      ##
      # :method: leagues
      # Retrieves leagues for the user for the given season.
      # :call-seq:
      #   leagues(season_year)
      #
      # @param season_year [String] The year in which the leagues were played
      #
      # @return [{SleeperRb::Resources::LeagueArray}[rdoc-ref:SleeperRb::Resources::LeagueArray]]
      cached_association :leagues do |season_year|
        retrieve_leagues!(season_year)
      end

      ##
      # :method: drafts
      # Retrieves all drafts for the user for the given season
      # :call-seq:
      #   drafts(season_year)
      #
      # @param season_year [String] The year in which the leagues were played
      #
      # @return [{SleeperRb::Resources::DraftArray}[rdoc-ref:SleeperRb::Resources::DraftArray]]
      cached_association :drafts do |season_year|
        retrieve_drafts!(season_year)
      end

      ##
      # Initializes a user, with either username or user_id.
      #
      # @param username [String] The current username
      #
      # @param user_id [String] The numerical user_id
      def initialize(opts)
        raise ArgumentError, "must provide either user_id or username" unless opts[:user_id] || opts[:username]

        super
      end

      private

      def retrieve_values!
        uri = URI("#{BASE_URL}/user/#{@user_id || @username}")
        execute_request(uri)
      end

      def retrieve_leagues!(season_year)
        uri = URI("#{BASE_URL}/user/#{user_id}/leagues/nfl/#{season_year}")
        response = execute_request(uri)
        LeagueArray.new(response.map { |hash| Resources::League.new(hash) })
      end

      def retrieve_drafts!(season_year)
        uri = URI("#{BASE_URL}/user/#{user_id}/drafts/nfl/#{season_year}")
        response = execute_request(uri)
        DraftArray.new(response.map { |hash| Resources::Draft.new(hash) })
      end
    end
  end
end
