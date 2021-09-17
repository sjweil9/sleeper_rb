# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      class Transaction
        ##
        # Miscellaneous information about the transaction, for example notes about why a waiver bid did not go through.
        class Metadata
          include SleeperRb::Utilities::Cache

          cached_attr

          skip_refresh :all
        end
      end
    end
  end
end
