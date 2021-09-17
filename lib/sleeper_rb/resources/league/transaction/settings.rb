# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      class Transaction
        ##
        # Settings for a transaction, includes information like FAAB bid amount.
        class Settings
          include SleeperRb::Utilities::Cache

          ##
          # :attr_reader: waiver_bid

          cached_attr :waiver_bid

          skip_refresh :all
        end
      end
    end
  end
end
