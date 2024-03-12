# frozen_string_literal: true

module Types
  class PolicyType < BaseObject
    field :validity, String, null: false
    field :vehicle, VehicleType, null: false
    field :insured, InsuredType, null: false
  end
end
