# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Implements {SleeperRb::Utilities::ArrayProxy} and wraps Transaction objects.
      class TransactionArray < SleeperRb::Utilities::ArrayProxy
        ##
        # Returns transactions which are trades.
        #
        # @return [{SleeperRb::Resources::League::TransactionArray}[rdoc-ref:SleeperRb::Resources::League::TransactionArray]]
        def trade
          where(type: "trade")
        end

        ##
        # Returns transactions which are free agent acquisitions.
        #
        # @return [{SleeperRb::Resources::League::TransactionArray}[rdoc-ref:SleeperRb::Resources::League::TransactionArray]]
        def free_agent
          where(type: "free_agent")
        end

        ##
        # Returns transactions which are free agent acquisitions made with FAAB.
        #
        # @return [{SleeperRb::Resources::League::TransactionArray}[rdoc-ref:SleeperRb::Resources::League::TransactionArray]]
        def faab
          where(type: "free_agent", waiver_bid: { not: nil })
        end

        ##
        # Returns transactions which are free agent acquisitions made via the waiver wire.
        #
        # @return [{SleeperRb::Resources::League::TransactionArray}[rdoc-ref:SleeperRb::Resources::League::TransactionArray]]
        def waiver
          where(type: "free_agent", waiver_bid: nil)
        end
      end
    end
  end
end
