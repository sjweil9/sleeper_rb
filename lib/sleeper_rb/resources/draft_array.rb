# frozen-string-literal: true

module SleeperRb
  module Resources
    ##
    # Implements {SleeperRb::Utilities::ArrayProxy} and wraps Draft objects.
    class DraftArray < SleeperRb::Utilities::ArrayProxy
      ##
      # Returns all auction drafts.
      #
      # @return [{SleeperRb::Resources::DraftArray}[rdoc-ref:SleeperRb::Resources::DraftArray]]
      def auction
        where(auction?: true)
      end

      ##
      # Returns all snake drafts.
      #
      # @return [{SleeperRb::Resources::DraftArray}[rdoc-ref:SleeperRb::Resources::DraftArray]]
      def snake
        where(snake?: true)
      end
    end
  end
end
