# frozen_string_literal: true

module SleeperRb
  module Resources
    class League
      ##
      # Scoring settings for a League instance
      class ScoringSettings
        ##
        # :attr_reader: pass_2pt

        ##
        # :attr_reader: pass_int

        ##
        # :attr_reader: fgmiss

        ##
        # :attr_reader: rec_yd

        ##
        # :attr_reader: xpmiss

        ##
        # :attr_reader: blk_kick

        ##
        # :attr_reader: pts_allow_7_13

        ##
        # :attr_reader: ff

        ##
        # :attr_reader: fgm_20_29

        ##
        # :attr_reader: fgm_30_39

        ##
        # :attr_reader: fgm_40_49

        ##
        # :attr_reader: pts_allow_1_6

        ##
        # :attr_reader: st_fum_rec

        ##
        # :attr_reader: def_st_ff

        ##
        # :attr_reader: st_ff

        ##
        # :attr_reader: pts_allow_28_34

        ##
        # :attr_reader: fgm_50p

        ##
        # :attr_reader: fum_rec

        ##
        # :attr_reader: def_td

        ##
        # :attr_reader: fgm_0_19

        ##
        # :attr_reader: int

        ##
        # :attr_reader: pts_allow_0

        ##
        # :attr_reader: pts_allow_21_27

        ##
        # :attr_reader: rec_2pt

        ##
        # :attr_reader: rec

        ##
        # :attr_reader: xpm

        ##
        # :attr_reader: st_d

        ##
        # :attr_reader: def_st_fum_rec

        ##
        # :attr_reader: def_st_td

        ##
        # :attr_reader: sack

        ##
        # :attr_reader: fum_rec_td

        ##
        # :attr_reader: rush_2pt

        ##
        # :attr_reader: rec_td

        ##
        # :attr_reader: pts_allow_35p

        ##
        # :attr_reader: pts_allow_14_20

        ##
        # :attr_reader: rush_yd

        ##
        # :attr_reader: pass_yd

        ##
        # :attr_reader: pass_td

        ##
        # :attr_reader: rush_td

        ##
        # :attr_reader: fum_lost

        ##
        # :attr_reader: fum

        ##
        # :attr_reader: safe

        # rubocop:disable Naming/VariableNumber
        FIELDS = %i[
          pass_2pt pass_int fgmiss rec_yd xpmiss blk_kick pts_allow_7_13 ff fgm_20_29 fgm_30_39 fgm_40_49 pts_allow_1_6
          st_fum_rec def_st_ff st_ff pts_allow_28_34 fgm_50p fum_rec def_td fgm_0_19 int pts_allow_0 pts_allow_21_27
          rec_2pt rec xpm st_td def_st_fum_rec def_st_td sack fum_rec_td rush_2pt rec_td pts_allow_35p pts_allow_14_20
          rush_yd pass_yd pass_td rush_td fum_lost fum safe
        ].freeze
        # rubocop:enable Naming/VariableNumber

        attr_reader(*FIELDS)

        def initialize(opts)
          opts.slice(*FIELDS).each do |key, val|
            instance_variable_set(:"@#{key}", val.to_f.round(2))
          end
        end

        ##
        # @return [Boolean] If league uses PPR scoring
        def ppr?
          rec.to_i == 1
        end

        ##
        # @return [Boolean] If league uses Half-PPR scoring
        def half_ppr?
          rec > 0.0 && rec < 1.0
        end

        ##
        # @return [Boolean] If league uses Standard (0 PPR) scoring
        def standard?
          rec.to_i.zero?
        end
      end
    end
  end
end
