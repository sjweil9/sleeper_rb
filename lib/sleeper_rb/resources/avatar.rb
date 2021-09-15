# frozen_string_literal: true

module SleeperRb
  module Resources
    ##
    # The Avatar class allows access to full-size or thumbnail URLs for user avatars.
    class Avatar
      include SleeperRb::Utilities::Request
      include SleeperRb::Utilities::Cache

      ##
      # :attr_reader: avatar_id

      ##
      # :method: full_size
      # Returns the full size image for the Avatar
      #
      # @return [Tempfile]

      ##
      # :method: thumbnail
      # Returns the full size image for the Avatar
      #
      # @return [Tempfile]

      cached_attr :full_size, :thumbnail, :avatar_id

      private

      def retrieve_values!
        full_url = "#{CDN_BASE_URL}/avatars/#{avatar_id}"
        full_file = download_file(full_url, "#{avatar_id}-full")
        thumb_url = "#{CDN_BASE_URL}/avatars/thumbs/#{avatar_id}"
        thumb_file = download_file(thumb_url, "#{avatar_id}-thumb")
        {
          full_size: full_file,
          thumbnail: thumb_file,
          avatar_id: avatar_id
        }
      end
    end
  end
end
