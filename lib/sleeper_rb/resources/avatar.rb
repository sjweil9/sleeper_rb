# frozen_string_literal: true

module SleeperRb
  module Resources
    ##
    # The Avatar class allows access to full-size or thumbnail URLs for user avatars.
    class Avatar
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      cached_attr :full_size, :thumbnail, :avatar_id

      ##
      # Initializes an avatar using an avatar_id.
      #
      # @param avatar_id [String] The alphanumeric ID for the avatar
      def initialize(avatar_id)
        @avatar_id = avatar_id
      end

      private

      def retrieve_values!
        full_url = "#{CDN_BASE_URL}/avatars/#{avatar_id}"
        full_file = download_file(full_url, "#{avatar_id}-full")
        thumb_url = "#{CDN_BASE_URL}/avatars/thumbs/#{avatar_id}"
        thumb_file = download_file(thumb_url, "#{avatar_id}-thumb")
        {
          full_size: full_file,
          thumbnail: thumb_file
        }
      end
    end
  end
end
