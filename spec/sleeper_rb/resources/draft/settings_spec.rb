# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft::Settings do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    {
      teams: 6,
      slots_wr: 2,
      slots_te: 1,
      slots_rb: 2,
      slots_qb: 1,
      slots_k: 1,
      slots_flex: 2,
      slots_def: 1,
      slots_bn: 5,
      rounds: 15,
      pick_timer: 120,
      reversal_round: 0,
      player_type: 0,
      nomination_timer: 60,
      enforce_position_limits: 1,
      cpu_autopick: 1,
      budget: 200,
      alpha_sort: 0
    }
  end

  describe "#initialize" do
    it "should set the proper values" do
      valid_opts.each do |key, val|
        expect(subject.send(key)).to eq(val)
      end
    end
  end
end
