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
        full_url = "#{CDN_BASE_URL}/avatars/#{id}"
        full_file = download_file(full_url, "#{id}-full")
        thumb_url = "#{CDN_BASE_URL}/avatars/thumbs/#{id}"
        thumb_file = download_file(thumb_url, "#{id}-thumb")
        {
          full_size: full_file,
          thumbnail: thumb_file
        }
      end
    end
  end
end
