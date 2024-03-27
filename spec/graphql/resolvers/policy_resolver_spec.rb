# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Policy resolver', type: :request do
  let(:graphql_string) do
    <<~QUERY
      query {
        policy(id: "1") {
          validity
          vehicle {
            model
            make
            plate
            year
          }
          insured {
            name
            documentNumber
            documentType
          }
        }
      }
    QUERY
  end

  let(:policy_base_client) do
    double(Clients::PolicyBase, find_policy: get_policy_response)
  end

  before do
    allow(Clients::PolicyBase).to receive(:new).and_return(policy_base_client)

    graphql_request(graphql_string)
  end

  context 'when find policy successfully' do
    let(:get_policy_response) do
      load_json_symbolized('spec/responses/external/get_policy.json')
    end
    let(:expected_response) do
      load_json_symbolized('spec/responses/internal/policy_query.json')
    end

    it 'returns policy data' do
      expect(Clients::PolicyBase).to have_received(:new)
      expect(policy_base_client).to have_received(:find_policy).with('1')
      expect(response_data[:policy]).to eq(expected_response)
    end
  end

  context 'when policy is not found' do
    let(:get_policy_response) { '' }

    it 'returns nil' do
      expect(response_data[:policy]).to be_nil
    end
  end
end
