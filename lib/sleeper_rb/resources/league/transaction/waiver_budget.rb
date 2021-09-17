# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      class Transaction
        ##
        # Represents data about a waiver budget exchange in a transaction (trade).
        class WaiverBudget
          include SleeperRb::Utilities::Cache

          ##
          # :attr_reader: sender

          ##
          # :attr_reader: receiver

          ##
          # :attr_reader: amount

          ##
          # :method: transaction
          # The transaction to which this belongs.
          #
          # @return [{SleeperRb::Resources::League::Transaction}[rdoc-ref:SleeperRb::Resources::League::Transaction]]

          cached_attr :sender, :receiver, :amount, :transaction

          skip_refresh :all
        end
      end
    end
  end
end
