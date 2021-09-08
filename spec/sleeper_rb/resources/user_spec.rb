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
  let(:username) { "foobar" }
  let(:user_id) { "469586445502246912" }
  let(:avatar) { "c8de9e651b19331f6eae4f9f26164107" }
  let(:bad_id) { "219082094128012321" }

  let(:user_response) do
    {
      verification: nil,
      username: username,
      user_id: user_id,
      token: nil,
      summoner_region: nil,
      summoner_name: nil,
      solicitable: nil,
      real_name: nil,
      phone: nil,
      pending: nil,
      notifications: nil,
      is_bot: false,
      email: nil,
      display_name: username,
      deleted: nil,
      data_updated: nil,
      currencies: nil,
      created: nil,
      cookies: nil,
      avatar: avatar
    }.to_json
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
end
