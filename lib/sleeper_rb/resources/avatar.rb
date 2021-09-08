# frozen_string_literal: true

module SleeperRb
  module Resources
    ##
    # The Avatar class allows access to full-size or thumbnail URLs for user avatars.
    class Avatar
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      cached_attr :full_size, :thumbnail, :id

      ##
      # Initializes an avatar using an avatar_id.
      # @param avatar_id [String] The alphanumeric ID for the avatar
      def initialize(avatar_id)
        @id = avatar_id
      end

      private

      def retrieve_values!
        uri = "https://sleepercdn.com/avatars/#{id}"
        full_url = download_file(uri, "#{id}-full")
        thumb_uri = "https://sleepercdn.com/avatars/thumbs/#{id}"
        thumb_url = download_file(thumb_uri, "#{id}-thumb")
        {
          full_size: full_url,
          thumbnail: thumb_url
        }
      end
    end
  end
end