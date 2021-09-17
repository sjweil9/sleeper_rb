# frozen-string-literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Implements {SleeperRb::Utilities::ArrayProxy} and wraps Transaction objects.
      class TransactionArray < SleeperRb::Utilities::ArrayProxy
        def trade; end

        def free_agent; end
      end
    end
  end
end
