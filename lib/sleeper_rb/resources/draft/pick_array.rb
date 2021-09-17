# frozen-string-literal: true

module SleeperRb
  module Resources
    class Draft
      ##
      # Implements {SleeperRb::Utilities::ArrayProxy} and wraps Pick objects.
      class PickArray < SleeperRb::Utilities::ArrayProxy; end
    end
  end
end
