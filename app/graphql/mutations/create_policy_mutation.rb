# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :policy, Inputs::PolicyInput, required: true

    field :status, Integer, null: false
    field :description, String, null: false

    def resolve(policy:)
      CreatePolicyTask.publish!(policy: policy.to_json)

      { status: 200, description: 'Sua apólice será emitida em alguns instantes!' }
    end
  end
end
