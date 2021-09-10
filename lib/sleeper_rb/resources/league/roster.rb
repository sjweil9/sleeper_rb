module SleeperRb
  module Resources
    class League
      class Roster
        include SleeperRb::Utilities::Cache

        FIELDS = %i[]

        def initialize(opts)
          opts.slice(*FIELDS).each do |key, val|
            instance_variable_set(:"@#{key}", val)
          end
        end
      end
    end
  end
end