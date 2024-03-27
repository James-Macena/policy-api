# frozen_string_literal: true

module Clients
  class PolicyBase
    attr_reader :auth_token

    def initialize(auth_token)
      @auth_token = auth_token
    end

    def list_policies
      response = perform_get('/policies')

      response.body
    end

    def find_policy(id)
      response = perform_get("/policies/#{id}")

      response.body
    end

    private

    def perform_get(path)
      faraday_connection.get(path)
    end

    def faraday_connection
      Faraday.new(url: ENV.fetch('POLICY_BASE_API_URL')) do |builder|
        builder.request :authorization, 'Bearer', -> { auth_token }
        builder.request :json
        builder.response :json
      end
    end
  end
end
