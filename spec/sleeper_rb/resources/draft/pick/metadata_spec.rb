# frozen-string-literal: true

RSpec.describe SleeperRb::Resources::Draft::Pick::Metadata do
  subject { described_class.new(valid_opts) }

  let(:valid_opts) do
    {
      years_exp: "4",
      team: "MIN",
      status: "Active",
      sport: "nfl",
      position: "RB",
      player_id: "4029",
      number: "33",
      news_updated: "1629591331715",
      last_name: "Cook",
      injury_status: "",
      first_name: "Dalvin"
    }
  end

  let(:translated_keys) { %i[news_updated] }

  describe "#initialize" do
    it "should set all proper values" do
      valid_opts.reject { |key, _v| translated_keys.include?(key) }.each do |key, value|
        expect(subject.send(key)).to eq(value)
      end

      expect(subject.position).to be_an_instance_of(SleeperRb::Utilities::RosterPosition)
      expect(subject.news_updated).to eq(Time.at(valid_opts[:news_updated].to_i / 1000))
    end
  end

  describe "#full_name" do
    it "should return the combined first and last name" do
      expect(subject.full_name).to eq("Dalvin Cook")
    end
  end
end
