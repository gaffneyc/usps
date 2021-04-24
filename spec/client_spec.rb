require 'spec_helper'

describe USPS::Client do
  class RequestSubclassForTesting < USPS::Request::Base
    config(:api => 'testing', :tag => 'TestingTag')
  end

  context "when a request times out" do
    let(:typhoeus_mock) { instance_double(Typhoeus::Response, timed_out?: true) }

    before do
      allow(Typhoeus::Request).to receive(:get).and_return(typhoeus_mock)
    end

    it "raises a TimeoutError" do
      expect {
        USPS::Client.new.request(RequestSubclassForTesting.new).send!
      }.to raise_error USPS::TimeoutError
    end
  end
end
