# frozen-string-literal: true

module SleeperRb
  module Resources
    ##
    # Implements {SleeperRb::Utilities::ArrayProxy}[rdoc-ref:SleeperRb::Utilities::ArrayProxy] and wraps League objects.
    class LeagueArray < SleeperRb::Utilities::ArrayProxy
      ##
      # Returns leagues which are set to Best Ball mode.
      #
      # @return [{SleeperRb::Resources::LeagueArray}[rdoc-ref:SleeperRb::Resources::LeagueArray]]
      def best_ball
        where(best_ball: true)
      end

      ##
      # Returns leagues which use PPR scoring.
      #
      # @return [{SleeperRb::Resources::LeagueArray}[rdoc-ref:SleeperRb::Resources::LeagueArray]]
      def ppr
        where(ppr?: true)
      end

      ##
      # Returns leagues which use Half-PPR scoring.
      #
      # @return [{SleeperRb::Resources::LeagueArray}[rdoc-ref:SleeperRb::Resources::LeagueArray]]
      def half_ppr
        where(half_ppr?: true)
      end

      ##
      # Returns leagues which use Standard (Zero PPR) scoring.
      #
      # @return [{SleeperRb::Resources::LeagueArray}[rdoc-ref:SleeperRb::Resources::LeagueArray]]
      def standard
        where(standard?: true)
      end
    end
  end
end
