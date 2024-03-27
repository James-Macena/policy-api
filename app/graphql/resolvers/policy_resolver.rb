# frozen_string_literal: true

module Resolvers
  class PolicyResolver < BaseResolver
    type Types::PolicyType, null: true
    argument :id, ID, required: true

    def resolve(id:)
      policy = policy_base_client.find_policy(id)
      return if policy.blank?

      policy
    end

    private

    def policy_base_client
      Clients::PolicyBase.new(context[:auth_token])
    end
  end
end
