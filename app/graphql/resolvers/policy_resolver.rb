# frozen_string_literal: true

module Resolvers
  class PolicyResolver < BaseResolver
    type Types::PolicyType, null: true
    argument :id, ID, required: true

    def resolve(id:)
      response = Faraday.get("#{ENV.fetch('POLICY_BASE_API_URL')}/policies/#{id}")
      return unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
