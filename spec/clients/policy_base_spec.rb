# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::PolicyBase, type: :client do
  describe '#list_policies' do
    let(:response) { double(Faraday::Response, body: 'fake response') }
    let(:faraday_connection) { double(Faraday::Connection, get: response) }

    subject { described_class.new('fake.auth.token').list_policies }

    before do
      allow(Faraday).to receive(:new).and_return(faraday_connection)

      subject
    end

    it 'returns response body' do
      expect(faraday_connection).to have_received(:get).with('/policies')
      expect(response).to have_received(:body)
      expect(Faraday).to have_received(:new).with(
        url: ENV.fetch('POLICY_BASE_API_URL')
      )
    end
  end

  describe '#find_policy' do
    let(:response) { double(Faraday::Response, body: 'fake response') }
    let(:faraday_connection) { double(Faraday::Connection, get: response) }

    subject { described_class.new('fake.auth.token').find_policy('1') }

    before do
      allow(Faraday).to receive(:new).and_return(faraday_connection)

      subject
    end

    it 'returns response body' do
      expect(faraday_connection).to have_received(:get).with('/policies/1')
      expect(response).to have_received(:body)
      expect(Faraday).to have_received(:new).with(
        url: ENV.fetch('POLICY_BASE_API_URL')
      )
    end
  end
end
