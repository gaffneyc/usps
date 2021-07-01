require 'spec_helper'

describe USPS::Client do
  class RequestSubclassForTesting < USPS::Request::Base
    config(:api => 'testing', :tag => 'TestingTag')
  end

  let(:typhoeus_mock) { instance_double(Typhoeus::Response, timed_out?: timed_out, response_code: response_code) }
  let(:timed_out) { false }
  let(:response_code) { 200 }

  before do
    allow(Typhoeus::Request).to receive(:get).and_return(typhoeus_mock)
  end

  context "when a request times out" do
    let(:timed_out) { true }

    it "raises a TimeoutError" do
      expect {
        USPS::Client.new.request(RequestSubclassForTesting.new).send!
      }.to raise_error USPS::TimeoutError
    end
  end

  context "when response_code = 0" do
    let(:response_code) { 0 }

    it "raises a ConnectionError" do
      expect {
        USPS::Client.new.request(RequestSubclassForTesting.new).send!
      }.to raise_error USPS::ConnectionError
    end
  end
end
