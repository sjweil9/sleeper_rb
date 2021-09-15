# frozen-string-literal: true

module SleeperRb
  module Resources
    class Draft
      ##
      # Settings for a given Draft.
      class Settings
        include SleeperRb::Utilities::Cache

        ##
        # :attr_reader: teams

        ##
        # :attr_reader: slots_wr

        ##
        # :attr_reader: slots_te

        ##
        # :attr_reader: slots_rb

        ##
        # :attr_reader: slots_qb

        ##
        # :attr_reader: slots_k

        ##
        # :attr_reader: slots_flex

        ##
        # :attr_reader: slots_def

        ##
        # :attr_reader: slots_dbn

        ##
        # :attr_reader: rounds

        ##
        # :attr_reader: pick_time

        ##
        # :attr_reader: reversal_round

        ##
        # :attr_reader: player_type

        ##
        # :attr_reader: nomination_timer

        ##
        # :attr_reader: enforce_position_limits

        ##
        # :attr_reader: cpu_autopick

        ##
        # :attr_reader: budget

        ##
        # :attr_reader: alpha_sort

        cached_attr :teams, :slots_wr, :slots_te, :slots_rb, :slots_qb, :slots_k, :slots_flex, :slots_def,
                    :slots_bn, :rounds, :pick_timer, :reversal_round, :player_type, :nomination_timer,
                    :enforce_position_limits, :cpu_autopick, :budget, :alpha_sort

        skip_refresh :all
      end
    end
  end
end
