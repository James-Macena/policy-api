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

  before do
    stub_get_policy(get_policy_args)
    graphql_request(graphql_string)
  end

  context 'when find policy successfully' do
    let(:get_policy_response) { load_json('spec/responses/external/get_policy.json') }
    let(:get_policy_args) { { id: '1', status: 200, response: get_policy_response } }
    let(:expected_response) do
      load_json_symbolized('spec/responses/internal/policy_query.json')
    end

    it 'returns policy data' do
      expect(response_data[:policy]).to eq(expected_response)
    end
  end

  context 'when policy is not found' do
    let(:get_policy_args) { { id: '1', status: 404 } }

    it 'returns nil' do
      expect(response_data[:policy]).to be_nil
    end
  end
end
