# frozen_string_literal: true

def graphql_request(graphql_string)
  valid_token =
    JWT.encode({}, ENV.fetch('JWT_SECRET_KEY'), ENV.fetch('JWT_ALGORITHM'))

  post graphql_path, params: { query: graphql_string },
                     headers: { Authorization: "Bearer #{valid_token}" }
end

def response_data
  JSON.parse(response.body, symbolize_names: true)[:data]
end
