# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::NflState do
  before do
    stub_request(:get, nfl_state_url).to_return(status: 200, body: nfl_state_response)
  end

  subject { described_class.instance }

  let(:nfl_state_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/state/nfl") }
  let(:season_type) { "regular" }
  let(:season_start_date) { "2021-09-09" }
  let(:season) { "2021" }
  let(:previous_season) { "2020" }
  let(:week) { 1 }
  let(:leg) { 1 }
  let(:league_season) { "2021" }
  let(:league_create_season) { "2021" }
  let(:display_week) { 1 }
  let(:nfl_state_response) do
    {
      week: week,
      season_type: season_type,
      season_start_date: season_start_date,
      season: season,
      previous_season: previous_season,
      leg: leg,
      league_season: league_season,
      league_create_season: league_create_season,
      display_week: display_week
    }.to_json
  end

  describe "#retrieve_values!" do
    it "should set all proper values" do
      %i[season_type season_start_date season previous_season week leg league_season league_create_season display_week].each do |key|
        expect(subject.send(key)).to eq(send(key))
      end
    end
  end
end
