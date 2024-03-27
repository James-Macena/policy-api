# frozen_string_literal: true

module Resolvers
  class PoliciesResolver < BaseResolver
    type [Types::PolicyType], null: true

    def resolve
      policies = policy_base_client.list_policies
      return nil if policies.blank?

      policies
    end

    private

    def policy_base_client
      Clients::PolicyBase.new(context[:auth_token])
    end
  end
end
