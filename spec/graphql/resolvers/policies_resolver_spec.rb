# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Policies resolver', type: :request do
  let(:graphql_string) do
    <<~QUERY
      query {
        policies {
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
    stub_get_policies(get_policies_args)
    graphql_request(graphql_string)
  end

  context 'when find policies successfully' do
    let(:get_policies_response) { [load_json_symbolized('spec/responses/external/get_policy.json')].to_json }
    let(:get_policies_args) { { status: 200, response: get_policies_response } }
    let(:expected_response) do
      [load_json_symbolized('spec/responses/internal/policy_query.json')]
    end

    it 'returns policies data' do
      expect(response_data[:policies]).to eq(expected_response)
    end
  end

  context 'when policies are not found' do
    let(:get_policies_args) { { status: 404 } }

    it 'returns nil' do
      expect(response_data[:policies]).to be_nil
    end
  end
end
