# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Scoring settings for a League instance
      class ScoringSettings
        include SleeperRb::Utilities::Cache

        FIELDS = %i[
          pass_2pt pass_int fgmiss rec_yd xpmiss blk_kick pts_allow_7_13 ff fgm_20_29 fgm_30_39 fgm_40_49 pts_allow_1_6
          st_fum_rec def_st_ff st_ff pts_allow_28_34 fgm_50p fum_rec def_td gm_0_19 int pts_allow_0 pts_allow_21_27
          rec_2pt rec xpm st_td def_st_fum_rec def_st_td sack fum_rec_td rush_2pt rec_td pts_allow_35p pts_allow_14_20
          rush_yd pass_yd pass_td rush_td fum_lost fum safe
        ].freeze

        def initialize(opts)
          opts.slice(*FIELDS).each do |key, val|
            instance_variable_set(:"@#{key}", val.to_f.round(2))
          end
        end

        def ppr?
          rec == 1.0
        end

        def half_ppr?
          rec == 0.5
        end

        def standard?
          rec == 0.0
        end

        private

        def values
          {}
        end
      end
    end
  end
end
