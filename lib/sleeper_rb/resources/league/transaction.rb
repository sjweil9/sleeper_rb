# frozen-string-literal: true

require_relative "transaction/metadata"
require_relative "transaction/settings"
require_relative "transaction/waiver_budget"

module SleeperRb
  module Resources
    class League
      ##
      # Represents a waiver move, free agent transaction, or trade.
      class Transaction
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: transaction_id

        ##
        # :attr_reader: type

        ##
        # :attr_reader: status

        ##
        # :attr_reader: roster_ids

        ##
        # :attr_reader: week

        ##
        # :attr_reader: drops

        ##
        # :attr_reader: creator

        ##
        # :attr_reader: consenter_ids

        ##
        # :attr_reader: adds

        ##
        # :attr_reader: created

        ##
        # :attr_reader: status_updated

        # rubocop:disable Layout/LineLength

        ##
        # :method: waiver_budget
        #
        # @return [Array<{SleeperRb::Resources::League::Transaction::WaiverBudget}[rdoc-ref:SleeperRb::Resources::League::Transaction::WaiverBudget]>]

        ##
        # :method: settings
        #
        # @return [{SleeperRb::Resources::League::Transaction::Settings}[rdoc-ref:SleeperRb::Resources::League::Transaction::Settings]]

        ##
        # :method: metadata
        #
        # @return [{SleeperRb::Resources::League::Transaction::Metadata}[rdoc-ref:SleeperRb::Resources::League::Transaction::Metadata]]

        ## :method: league
        # The league this transaction is a part of.
        #
        # @return [{SleeperRb::Resources::League}[rdoc-ref:SleeperRb::Resources::League]]

        ##
        # :method: draft_picks
        # Any draft picks traded as part of this transaction.
        #
        # @return [{SleeperRb::Resources::TradedPickArray}[rdoc-ref:SleeperRb::Resources::TradedPickArray]]

        # rubocop:enable Layout/LineLength

        cached_attr :league, :transaction_id, :type, :status, :roster_ids, :leg, :drops, :creator, :consenter_ids,
                    :adds, created: :timestamp, status_updated: :timestamp,
                           waiver_budget: ->(array) { array&.map { |hash| WaiverBudget.new(hash.merge(transaction: self)) } },
                           settings: ->(hash) { hash ? Settings.new(hash) : nil },
                           metadata: ->(hash) { hash ? Metadata.new(hash) : nil },
                           draft_picks: ->(array) { TradedPickArray.new(array&.map { |hash| TradedPick.new(hash) }) }

        delegate(*Settings.cached_attrs.keys, to: :settings)
        delegate(*Metadata.cached_attrs.keys, to: :settings)

        alias week leg

        skip_refresh :all

        ##
        # :method: rosters
        # Returns rosters participating in this transaction.
        #
        # @return [{SleeperRb::Resources::League::RosterArray}[rdoc-ref:SleeperRb::Resources::League::RosterArray]]
        cached_association :rosters do
          league.rosters.select { |roster| roster_ids.include?(roster.roster_id) }
        end
      end
    end
  end
end
