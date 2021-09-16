# frozen-string-literal: true

RSpec.configure do |config|
  config.before(:each) do
    player_response = File.read(File.expand_path("../fixtures/player_response.json", File.dirname(__FILE__)))
    stub_request(:get, "#{SleeperRb::Utilities::Request::BASE_URL}/players/nfl").to_return(body: player_response)
  end
end
