# frozen_string_literal: true

module Inputs
  class VehicleInput < GraphQL::Schema::InputObject
    description 'Vehicle data to be created'

    argument :model, String, required: true
    argument :make, String, required: true
    argument :plate, String, required: true
    argument :year, String, required: true
  end
end
