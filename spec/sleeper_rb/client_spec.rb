# frozen_string_literal: true

RSpec.describe SleeperRb::Client do
  subject { described_class.new }

  describe "nfl_state" do
    it "returns the instance of NflState" do
      expect(subject.nfl_state).to eq(SleeperRb::Resources::NflState.instance)
    end
  end

  describe "user" do
    it "returns a User instance by username" do
      result = subject.user(username: "foo")
      expect(result).to be_an_instance_of(SleeperRb::Resources::User)
      expect(result.username).to eq("foo")
    end

    it "returns a User instance by user_id" do
      result = subject.user(user_id: "ABC123")
      expect(result).to be_an_instance_of(SleeperRb::Resources::User)
      expect(result.user_id).to eq("ABC123")
    end
  end
end
