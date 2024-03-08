# frozen_string_literal: true

def graphql_request(graphql_string)
  post graphql_path, params: { query: graphql_string }
end

def response_data
  JSON.parse(response.body).deep_symbolize_keys[:data]
end