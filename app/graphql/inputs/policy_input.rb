# frozen_string_literal: true

module Inputs
  class PolicyInput < GraphQL::Schema::InputObject
    description 'Policy data to be created'

    argument :validity, GraphQL::Types::ISO8601DateTime, required: true
    argument :vehicle, Inputs::VehicleInput, required: true
    argument :insured, Inputs::InsuredInput, required: true
  end
end
