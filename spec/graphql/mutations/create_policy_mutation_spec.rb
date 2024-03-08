# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create policy mutation', type: :request do
  context 'when publishes message successfully' do
    let(:graphql_string) do
      <<~QUERY
        mutation {
          createPolicy(
            input:{
              policy: {
                validity: "2024-03-07"
                vehicle: {
                  model: "Fit"
                  make: "Honda"
                  plate: "TEST-000"
                  year: "2009"
                }
                insured: {
                  name: "John"
                  documentNumber: "12345678062"
                  documentType: "CPF"
                }
              }
            }
          ) {
              status
              description
            }
        }
      QUERY
    end

    before do
      allow(CreatePolicyTask).to receive(:publish!).and_return(true)

      graphql_request(graphql_string)
    end

    it 'returns success feedback message' do
      expect(response_data[:createPolicy]).to eq(
        { status: 200, description: 'Sua apólice será emitida em alguns instantes!' }
      )
      expect(CreatePolicyTask).to have_received(:publish!)
    end
  end
end
