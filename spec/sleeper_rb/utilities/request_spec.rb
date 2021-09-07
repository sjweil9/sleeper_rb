# frozen_string_literal: true

RESPONSE = Struct.new(:code, :body)

RSpec.describe SleeperRb::Utilities::Request do
  describe "#execute_request" do
    let(:response200) { RESPONSE.new("200", { foo: "bar" }.to_json) }
    let(:response404) { RESPONSE.new("404") }
    let(:response400) { RESPONSE.new("400") }
    let(:response429) { RESPONSE.new("429") }
    let(:response500) { RESPONSE.new("500") }

    let(:uri) { URI(url) }
    let(:url) { SleeperRb::Utilities::Request::BASE_URL }

    subject do
      Class.new do
        include SleeperRb::Utilities::Request
      end.new
    end

    context "when response is 200" do
      it "should return the parsed JSON" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response200)
        expect { subject.send(:execute_request, url) }.not_to raise_error
      end
    end

    context "when response is 404" do
      it "should raise NotFound" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response404)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::NotFound)
      end
    end

    context "when response is 400" do
      it "should raise BadRequest" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response400)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::BadRequest)
      end
    end

    context "when response is 429" do
      it "should raise RateLimitExceeded" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response429)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::RateLimitExceeded)
      end
    end

    context "when response is any other code" do
      it "should raise ServerError" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response500)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::ServerError)
      end
    end
  end
end
