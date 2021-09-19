# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      class Transaction
        ##
        # Miscellaneous information about the transaction, for example notes about why a waiver bid did not go through.
        class Metadata
          include SleeperRb::Utilities::Cache

          # The Sleeper documentation lists this field for transactions but none of the examples show the actual
          # structure of the object. This is left here for now as a placeholder to be filled in once I come across
          # a transaction where the metadata is not null.
          cached_attr

          skip_refresh :all
        end
      end
    end
  end
end
