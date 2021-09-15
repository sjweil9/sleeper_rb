# frozen_string_literal: true

RSpec.describe SleeperRb::Resources::User do
  before do
    stub_request(:get, username_url).to_return(status: 200, body: user_response)
    stub_request(:get, user_id_url).to_return(status: 200, body: user_response)
    stub_request(:get, bad_url).to_return(status: 404)
  end

  let(:username_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/user/#{username}") }
  let(:user_id_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/user/#{user_id}") }
  let(:bad_url) { URI("#{SleeperRb::Utilities::Request::BASE_URL}/user/#{bad_id}") }
  let(:bad_id) { "219082094128012321" }
  let(:user_id) { "374409574377324544" }
  let(:username) { "mindoflogic90" }
  let(:avatar) { "c8de9e651b19331f6eae4f9f26164107" }

  let(:user_response) do
    File.read(File.expand_path("../../fixtures/user_response.json", File.dirname(__FILE__)))
  end

  describe "#retrieve_values!" do
    context "when initialized with username" do
      subject { described_class.new(username: username) }

      it "should set all proper values" do
        expect(Net::HTTP).to receive(:get_response).with(username_url).once.and_call_original
        expect(subject.username).to eq(username)
        expect(subject.user_id).to eq(user_id)
        expect(subject.avatar).to be_an_instance_of(SleeperRb::Resources::Avatar)
        expect(subject.avatar.avatar_id).to eq(avatar)
        expect(subject.display_name).to eq(username)
      end
    end

    context "when initialized with user_id" do
      subject { described_class.new(user_id: user_id) }

      it "should set all proper values" do
        expect(Net::HTTP).to receive(:get_response).with(user_id_url).once.and_call_original
        expect(subject.username).to eq(username)
        expect(subject.user_id).to eq(user_id)
        expect(subject.avatar).to be_an_instance_of(SleeperRb::Resources::Avatar)
        expect(subject.avatar.avatar_id).to eq(avatar)
        expect(subject.display_name).to eq(username)
      end
    end

    context "when initialized with an invalid user_id" do
      subject { described_class.new(user_id: bad_id) }

      it "should raise NotFound" do
        expect { subject.display_name }.to raise_error(SleeperRb::NotFound)
      end
    end
  end

  describe "#leagues" do
    before { stub_request(:get, leagues_url).to_return(body: leagues_response) }
    let(:leagues_url) { "#{SleeperRb::Utilities::Request::BASE_URL}/user/#{user_id}/leagues/nfl/#{year}" }
    let(:year) { 2021 }

    let(:leagues_response) do
      File.read(File.expand_path("../../fixtures/leagues_response.json", File.dirname(__FILE__)))
    end

    subject { described_class.new(user_id: user_id) }

    it "should return all leagues for a user by season" do
      leagues = subject.leagues(year)
      expect(leagues).to all be_an_instance_of(SleeperRb::Resources::League)
      expect(leagues.first.league_id).to eq("737785373232623616")
      expect(leagues.last.league_id).to eq("735284283123548160")
    end
  end

  describe "#drafts" do
    before { stub_request(:get, drafts_url).to_return(body: drafts_response) }
    let(:drafts_url) { "#{SleeperRb::Utilities::Request::BASE_URL}/user/#{user_id}/drafts/nfl/#{year}" }
    let(:year) { 2021 }

    let(:drafts_response) do
      File.read(File.expand_path("../../fixtures/drafts_response.json", File.dirname(__FILE__)))
    end

    subject { described_class.new(user_id: user_id) }

    it "should return all drafts for a user by season" do
      drafts = subject.drafts(year)
      expect(drafts).to all be_an_instance_of(SleeperRb::Resources::Draft)
      expect(drafts.first.draft_id).to eq("737785377116553216")
      expect(drafts.last.draft_id).to eq("735284283798888448")
    end
  end
end
