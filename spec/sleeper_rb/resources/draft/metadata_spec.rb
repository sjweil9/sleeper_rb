# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft::Metadata do
  describe "#initialize" do
    subject { described_class.new(valid_opts) }

    let(:valid_opts) do
      {
        scoring_type: "ppr",
        offering_user_id: "469548265499521024",
        offering_slot: "1",
        nominating_user_id: "469548265499521024",
        nominating_slot: "1",
        nominated_player_id: "7591",
        name: "WH Auction BBall 2",
        hovered_player_id: "7591",
        highest_offer: "1",
        description: ""
      }
    end

    it "should set the proper values" do
      valid_opts.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end
    end
  end
end
