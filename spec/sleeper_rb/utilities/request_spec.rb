# frozen_string_literal: true

RSpec.describe SleeperRb::Utilities::Request do
  describe "execute_request" do
    RESPONSE = Struct.new(:code, :body)
    let(:response_200) { RESPONSE.new("200", { foo: "bar" }.to_json) }
    let(:response_404) { RESPONSE.new("404", "") }
    let(:response_400) { RESPONSE.new("400", "") }
    let(:response_500) { RESPONSE.new("500", "") }

    let(:uri) { URI(url) }
    let(:url) { SleeperRb::Utilities::Request::BASE_URL }

    subject do
      Class.new do
        include SleeperRb::Utilities::Request
      end.new
    end

    context "when response is 200" do
      it "should return the parsed JSON" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response_200)
        expect { subject.send(:execute_request, url) }.not_to raise_error
      end
    end

    context "when response is 404" do
      it "should raise NotFound" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response_404)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::NotFound)
      end
    end

    context "when response is 400" do
      it "should raise BadRequest" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response_400)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::BadRequest)
      end
    end

    context "when response is any other code" do
      it "should raise ServerError" do
        expect(Net::HTTP).to receive(:get_response).with(uri).and_return(response_500)
        expect { subject.send(:execute_request, url) }.to raise_error(SleeperRb::ServerError)
      end
    end
  end
end