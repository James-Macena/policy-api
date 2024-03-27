# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Validates authorization token', type: :request do
  describe 'in every request.' do
    context 'When authorization token is provided' do
      it 'does validate the token' do
        allow(JWT).to receive(:decode).and_call_original
        graphql_request('fake query')

        expect(response).to have_http_status(:ok)
        expect(JWT).to have_received(:decode)
      end

      context 'When authorization token is invalid' do
        it 'reurns unauthorized' do
          post graphql_path, params: { query: 'fake query' },
                             headers: { Authorization: 'Bearer invalid.token' }

          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to eq('Invalid token')
        end
      end

      context 'When authorization token has an invalid signature' do
        let(:token) do
          'Bearer eyJhbGciOiJIUzI1NiJ9.' \
            'e30.XmNK3GpH3Ys_7wsYBfq4C3M6goz71I7dTgUkuIa5lyQ'
        end

        it 'reurns unauthorized' do
          post graphql_path, params: { query: 'fake query' },
                             headers: { Authorization: token }

          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to eq('Invalid token')
        end
      end
    end

    context 'When authorization token is not provided' do
      it 'reurns unauthorized' do
        post graphql_path, params: { query: 'fake query' }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('Invalid token')
      end
    end
  end
end
