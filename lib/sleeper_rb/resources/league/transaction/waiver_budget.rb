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

          ##
          # :method: sending_roster
          # Returns the roster object that sent the WaiverBudget in this transaction.
          #
          # @return [{SleeperRb::Resources::League::Roster}[rdoc-ref:SleeperRb::Resources::League::Roster]]
          cached_association :sending_roster do
            transaction.league.rosters.detect { |roster| roster.roster_id == sender }
          end

          ##
          # :method: receiving_roster
          # Returns the roster object that received the WaiverBudget in this transaction.
          #
          # @return [{SleeperRb::Resources::League::Roster}[rdoc-ref:SleeperRb::Resources::League::Roster]]
          cached_association :receiving_roster do
            transaction.league.rosters.detect { |roster| roster.roster_id == receiver }
          end
        end
      end
    end
  end
end
