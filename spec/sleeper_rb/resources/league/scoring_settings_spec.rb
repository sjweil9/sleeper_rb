# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::League::ScoringSettings do
  # rubocop:disable Naming/VariableNumber
  let(:valid_settings) do
    {
      pass_2pt: 2.0, pass_int: -1.0, fgmiss: -1.0, rec_yd: 0.10000000149011612, xpmiss: -1.0, fgm_30_39: 3.0,
      blk_kick: 2.0, pts_allow_7_13: 4.0, ff: 1.0, fgm_20_29: 3.0, fgm_40_49: 4.0, pts_allow_1_6: 7.0, st_fum_rec: 1.0,
      def_st_ff: 1.0, st_ff: 1.0, pts_allow_28_34: -1.0, fgm_50p: 5.0, fum_rec: 2.0, def_td: 6.0, fgm_0_19: 3.0,
      int: 2.0, pts_allow_0: 10.0, pts_allow_21_27: 0.0, rec_2pt: 2.0, rec: 1.0, xpm: 1.0, st_td: 6.0,
      def_st_fum_rec: 1.0, def_st_td: 6.0, sack: 1.0, fum_rec_td: 6.0, rush_2pt: 2.0, rec_td: 6.0, pts_allow_35p: -4.0,
      pts_allow_14_20: 1.0, rush_yd: 0.10000000149011612, pass_yd: 0.03999999910593033, pass_td: 4.0, rush_td: 6.0,
      fum_lost: -2.0, fum: -1.0, safe: 2.0
    }
  end
  # rubocop:enable Naming/VariableNumber

  subject { described_class.new(valid_settings) }

  it "should set all valid fields as instance variables" do
    valid_settings.each do |key, val|
      expect(subject.send(key)).to eq(val.to_f.round(2))
    end
  end

  describe "#ppr?" do
    it "should return true if receptions score for 1 point" do
      subject.instance_variable_set(:@rec, 1.0)
      expect(subject.ppr?).to eq(true)

      subject.instance_variable_set(:@rec, 0.5)
      expect(subject.ppr?).to eq(false)
    end
  end

  describe "#half_ppr?" do
    it "should return true if receptions score between 0 and 1 point" do
      subject.instance_variable_set(:@rec, 0.5)
      expect(subject.half_ppr?).to eq(true)

      subject.instance_variable_set(:@rec, 1.0)
      expect(subject.half_ppr?).to eq(false)
    end
  end

  describe "#standard?" do
    it "should return true if receptions score zero" do
      subject.instance_variable_set(:@rec, 0.0)
      expect(subject.standard?).to eq(true)

      subject.instance_variable_set(:@rec, 1.0)
      expect(subject.standard?).to eq(false)
    end
  end
end
