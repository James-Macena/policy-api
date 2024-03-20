# frozen_string_literal: true

module Resolvers
  class PoliciesResolver < BaseResolver
    type [Types::PolicyType], null: true

    def resolve
      response = Faraday.get("#{ENV.fetch('POLICY_BASE_API_URL')}/policies")
      return unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
